# Review r1498: L178 step 2 in Lean, the layer's # on su(2) is twice the adjugate

Gate 2 review of commit dbdc0e12: the new [Results/L178Sharp.lean](../lean/HamiltonsCubic/Results/L178Sharp.lean) (`wp`, `Rp`, `cofQF`, `sharp_sd`, `wm`, `Rm`, `sharp_asd`) on top of [Base/Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) (`basis4`, `pair4`, `coord4`, `toMat4`, `sharpQF`, `sharpQF_one_basis`, `sharpMat`), and the record edits ([lean/INDEX.md](../lean/INDEX.md) line 70, [diagonal-half.md](../findings/diagonal-half.md) line 607). One reviewer. Analysis-only rule inherited: the only compute was the module build (8708 jobs, "Build completed successfully", no warning from L178Sharp.lean) and the axiom audit.

| item | claim | verdict |
| --- | --- | --- |
| A | `wp`/`wm` are the self-dual and anti-self-dual bivectors in `basis4`'s coordinates, `Rp`/`Rm` carry block $B$ on $\Lambda^\pm$ in the orthonormal basis $\omega^\pm/\sqrt2$ and vanish on the other summand, and $\langle R^\#\eta,\eta\rangle=4\,x^{\mathsf T}\mathop{\mathrm{cof}}(B)x$ means $R^\#=2\mathop{\mathrm{cof}}(B)$ on $\Lambda^\pm$ and $0$ off it, consistent with the anchor $\mathrm{Id}^\#=2\,\mathrm{Id}$ | CONFIRMED |
| B | the `simp only` / `norm_num` / `ring` proofs cannot alter the statement, and the heartbeat bumps are scoped and commented | CONFIRMED |
| C | no edited sentence overstates, and the owed list is complete | CONFIRMED WITH GAP |
| D | both theorems rest on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED |

**Summary: `sharp_sd` and `sharp_asd` compute the layer's own `sharpQF` on an operator supported on $\Lambda^+$ or $\Lambda^-$ of $\Lambda^2\mathbb R^4$, and the identity says exactly that $R^\#$ is $2\mathop{\mathrm{cof}}(B)$ on that summand in orthonormal coordinates and zero on the other, which is diagonal-half.md's $\gamma^2=2$ and step 3's confinement remark at $n=4$. The constant agrees with `sharpQF_one_basis`. 2/2 theorems on the standard three axioms. Gap C-1: step 1 lives in `Biv 4` over $\mathbb R$ and step 2 in `Matrix (Fin 6) (Fin 6) ℚ`, and the transfer that chains them is not in the L178 row's owed list. CONFIRMED WITH GAP.**

## A. Fidelity

- **Coordinates.** `phi i j = single j i 1 - single i j 1` and `coord4 A a = A (j,i)` for `pair4 a = (i,j)`, so `coord4 (phi i j)` is $1$ at the index of $(i,j)$ and `coord4 ∘ toMat4` is the identity. The basis indices are $0{:}\,e_{01}$, $1{:}\,e_{02}$, $2{:}\,e_{03}$, $3{:}\,e_{12}$, $4{:}\,e_{13}$, $5{:}\,e_{23}$. `inner2` $=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ makes `basis4` orthonormal, so the coordinate dot product is the $\Lambda^2$ inner product.
- **`wp`, `wm`.** Read off the match (L178Sharp.lean lines 29 to 30 and 60 to 61): `wp` is $e_{01}+e_{23}$, $e_{02}-e_{13}$, $e_{03}+e_{12}$ and `wm` is $e_{01}-e_{23}$, $e_{02}+e_{13}$, $e_{03}-e_{12}$. With $\star e_{01}=e_{23}$, $\star e_{02}=-e_{13}$, $\star e_{03}=e_{12}$ (standard orientation, the convention r1497 checked against `star4`), these are the $\pm1$ eigenvectors of $\star$. They are the same formulas as L178Split.lean's `om4p`, `om4m` (line 69). Each has square norm $2$, and `wp i · wm j = 0` for all $i,j$ (disjoint or cancelling supports). **Faithful.**
- **`Rp`, `Rm`.** `Rp` $=\tfrac12\sum_{ij}B_{ij}\,w_iw_j^{\mathsf T}$ with $B=[[a,b,c],[b,d,e],[c,e,f]]$, which is $\sum B_{ij}u_iu_j^{\mathsf T}$ for the orthonormal $u_i=w_i/\sqrt2$. So its block in the basis $u$ is $B$, and it kills $\Lambda^\mp$ because $w^\pm\perp w^\mp$. **Faithful.**
- **`cofQF`.** The cofactor matrix of symmetric $B$ has diagonal $df-e^2$, $af-c^2$, $ad-b^2$ and off-diagonal $C_{12}=ce-bf$, $C_{13}=be-cd$, $C_{23}=bc-ae$, matching lines 42 to 44 with the factor $2$ on cross terms. **Correct.**
- **The conclusion.** The arguments $(\eta_0+\eta_5)/2$, $(\eta_1-\eta_4)/2$, $(\eta_2+\eta_3)/2$ are $x_i=\langle\eta,w^+_i\rangle/2$, and the minus arguments are the same for $w^-$. With orthonormal coordinates $\xi_i=\langle\eta,u_i\rangle=\sqrt2x_i$, $4x^{\mathsf T}Cx=2\xi^{\mathsf T}C\xi$. `sharpQF R` is a quadratic form in $\eta$ (`toMat4` linear, `br` bilinear, $R$ entering twice), and `sharpMat` is its polarisation, so `sharpMat R` is the unique symmetric matrix with that form: $2\sum C_{ij}u_iu_j^{\mathsf T}$, which is $2\mathop{\mathrm{cof}}(B)$ on $\Lambda^\pm$ and $0$ on $\Lambda^\mp$ and on the mixed block. This reading is prose, since no theorem in the file is stated about `sharpMat`. Note, not a gap: the step from a quadratic form to its polarisation is the definition of `sharpMat`.
- **The layer's #.** `sharpQF` is Sharp.lean's `R_sharp_quadform`, the definition that `Qop` and `Pcubic` build on. **Faithful.**
- **The constant against the anchor.** At $B=I$, $\mathop{\mathrm{cof}}(B)=I$ and `Rp` $=P^+$, so $(P^+)^\#=2P^+$ and likewise $(P^-)^\#=2P^-$. Hand check at $\eta=e_{01}$: $x=(\tfrac12,0,0)$ gives $\langle(P^\pm)^\#e_{01},e_{01}\rangle=4\cdot\tfrac14=1$ each, summing to `sharpQF_one_basis`'s $2$, which requires the cross term of $(P^++P^-)^\#$ to vanish, as diagonal-half.md's additivity sentence says. **Consistent.** In fact the file now checks $(P^\pm)^\#=2P^\pm$ directly, which is what the unaudited r771 sentence in diagonal-half.md line 607 was supplied to infer.
- **Step 3's confinement remark.** The form depends on $\eta$ only through its $\Lambda^\pm$ component, so $W^\#$ is confined to $\Lambda^\pm$ when $W$ is. At $n=4$ that is proved. **CONFIRMED.**

## B. Soundness

- **The simp set cannot change the statement.** The theorem type is elaborated before the tactic block, and `simp only`, `norm_num` and `ring` can only close or fail to close it. Any mis-reduction of the pattern-matched `wp` would make the proof fail, not prove something else, and the kernel rechecks the term. The meaning of `wp` is therefore settled by its source, read in A.
- **Unfolding.** The set is Sharp.lean's `sharpQF_one_basis` set plus `Rp`/`Rm`, `wp`/`wm`, `cofQF`, with `Fin.sum_univ_six` and `Fin.ext_iff`, the combination Sharp.lean's header records as the one that reduces `pair4`.
- **Heartbeats.** Both `set_option maxHeartbeats 8000000 in` are scoped to their theorem with a reason comment, and the build raises no `maxHeartbeats` linter warning for this file. `set_option maxRecDepth 100000` is file-wide and uncommented, as in Sharp.lean. Note, not a gap. **CONFIRMED.**

## C. Record accuracy

- **lean/INDEX.md line 70.** "Step 2 is PROVED" with `sharp_sd`, `sharp_asd`, the form $4x^{\mathsf T}\mathop{\mathrm{cof}}(B)x$ with $x_i=\langle\eta,\omega_i\rangle/2$ and its reading $2\mathop{\mathrm{cof}}(B)$ on $\Lambda^\pm$ match the file. The owed clause "that $\#$ restricts to the adjugate on $\mathfrak{su}(2)$" is removed, and the padding (step 3) and steps 4 and 5 stay owed. The row stays **partial**. No overstatement.
- **diagonal-half.md line 607.** The added sentence says kernel-checked with the layer's own $\#$ for $W$ supported on $\Lambda^\pm$. No overstatement. It leaves standing "That sentence was missing and is supplied by r771 at audit, so it is itself unaudited", which the new check now covers at $n=4$ ($B=I$ gives $(P^\pm)^\#=2P^\pm$). An understatement, not a gap.
- **Gap C-1: the two steps live on different carriers, and the bridge is not named.** `L178_split` (L178Split.lean line 145) is about `W : Biv 4 →ₗ[ℝ] Biv 4`, with `Biv 4 = EuclideanSpace ℝ (Pairs 4)` (Base/BivModel.lean line 92). `sharp_sd` is about `Matrix (Fin 6) (Fin 6) ℚ` with rational block entries. Chaining step 1 into step 2 needs (a) the identification of `Pairs 4` with `basis4`'s `Fin 6` order, under which `om4p` and `wp` agree, and (b) the passage from $\mathbb Q$ to $\mathbb R$, which for a polynomial identity universally quantified in $a,\dots,f,\eta$ is immediate mathematically but is a separate statement in Lean, since `sharpQF` exists only over $\mathbb Q$. The row's owed list names the padding and "steps 4 and 5 read on the layer's objects", neither of which names this transfer. Suggested repair: add "and the transfer between L178Split.lean's `Biv 4` over $\mathbb R$ and Sharp.lean's `Fin 6` coordinates over $\mathbb Q$" to the owed clause at lean/INDEX.md line 70. **CONFIRMED WITH GAP.**

## D. Axioms

- `python3 scripts/misc/axiom_audit.py --only L178Sharp`: "auditing 2 declarations across 1 files, 2/2 clean -- resting on the standard three alone".
- The build reports no warning from L178Sharp.lean. **CONFIRMED.**

## E. Style

- The commit's added lines carry no em dash (grep count 0) and no backticks inside link text (grep for ``[` `` count 0).
- The semicolon in the L178 row before "symbolic identities by `norm_num` and `ring`" separates items of the row's comma-bearing list in the same way step 1's "; standard three axioms" does, the permitted use.
- lean/INDEX.md line 70 and diagonal-half.md line 607 are single lines. The Lean header wraps inside a `.lean` comment block, outside the markdown rule. **CONFIRMED.**

## Overall

**CONFIRMED WITH GAP.** `sharp_sd` and `sharp_asd` prove diagonal-half.md's Lemma L178 step 2 at $n=4$ with the layer's own `sharpQF`: an operator with block $B$ on $\Lambda^\pm$ (orthonormal basis $\omega^\pm/\sqrt2$) and zero elsewhere has $R^\#=2\mathop{\mathrm{cof}}(B)$ on $\Lambda^\pm$ and $0$ off it, the record's $\gamma^2=2$, and the constant agrees with `sharpQF_one_basis`. 2/2 theorems on the standard three axioms. Gap C-1 (lean/INDEX.md line 70): the owed list omits the carrier transfer between step 1's `Biv 4` over $\mathbb R$ and step 2's `Fin 6` coordinates over $\mathbb Q$. Notes, not gaps: the reading at the level of `sharpMat` is by polarisation in prose, `maxRecDepth` is set file-wide without a comment, and diagonal-half.md line 607 still calls the additivity sentence unaudited although the new theorem checks its conclusion at $n=4$.
