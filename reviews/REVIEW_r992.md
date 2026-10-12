# Review r992: the thirty-six typed entries of the adjugate law

Gate 2, sole reviewer by design. The mathematics of the adjugate law was settled in [r990](REVIEW_r990.md) and [r991](REVIEW_r991.md), so this round asks one question only: do the Lean statements in [I67AdjugateEntries.lean](../lean/HamiltonsCubic/Results/I67AdjugateEntries.lean) say what the result says?

Log: [agent_logs/r992-adjugate-entries.log](../agent_logs/r992-adjugate-entries.log)

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | the file states the adjugate law entry by entry, at all thirty-six $(i,j)$ | **CONFIRMED** |
| 2 | the polynomial on the six diagonal entries IS $\mathrm{Pf}(X)$, in the fifteen free entries | **CONFIRMED** |
| 3 | the thirty off-diagonal entries assert the product vanishes | **CONFIRMED** |
| 4 | each proof uses only the fifteen $\sigma_6$ entries and $X$'s skewness | **CONFIRMED** |
| 5 | the fifteen $\sigma_6$ entries are the signed Pfaffian of the complementary four-set | **CONFIRMED** |
| 6 | the file is `sorry`-free and rests on the three standard axioms | **CONFIRMED** |
| 7 | the file does NOT state `pf6 X` = that polynomial, and says so | **CONFIRMED**, with one correction to the size of the residual debt |

## Row 2, attacked first: the diagonal cubic IS the Pfaffian

I recomputed $\mathrm{Pf}(X)=\frac1{48}\sum\varepsilon_{abcdef}X_{ab}X_{cd}X_{ef}$ from the definition, summing over all $720$ permutations with the sign taken from the inversion count, on a skew $6\times6$ of free symbols $x_{ij}$, $i<j$. It returns fifteen monomials. The cubic written on the right of `adj_0_0` is those fifteen monomials, with every sign agreeing:

$$x_{01}x_{23}x_{45}-x_{01}x_{24}x_{35}+x_{01}x_{25}x_{34}-x_{02}x_{13}x_{45}+x_{02}x_{14}x_{35}-x_{02}x_{15}x_{34}+x_{03}x_{12}x_{45}-x_{03}x_{14}x_{25}+x_{03}x_{15}x_{24}-x_{04}x_{12}x_{35}+x_{04}x_{13}x_{25}-x_{04}x_{15}x_{23}+x_{05}x_{12}x_{34}-x_{05}x_{13}x_{24}+x_{05}x_{14}x_{23}$$

The difference expands to the zero polynomial, asserted rather than eyeballed. The control asserts that corrupting one coefficient makes the same difference nonzero, so the comparison is sensitive. The six diagonal right-hand sides are one string: stripping the goal's left side from `adj_0_0`, `adj_1_1`, `adj_2_2`, `adj_3_3`, `adj_4_4`, `adj_5_5` and deduplicating leaves exactly one. Each is negated, matching $-\mathrm{Pf}(X)\,\mathrm{Id}$ rather than $+$.

**So the file is not typing true statements about a convenient cubic.** It is typing the Pfaffian.

## Row 5, and the whole product

I rebuilt $\sigma_6(X)=\tfrac12\star_6(X\wedge X)$ from the Lean definitions themselves, [levi6](../lean/HamiltonsCubic/Base/SelfDual.lean#L602), [star6](../lean/HamiltonsCubic/Base/SelfDual.lean#L618), [halfw](../lean/HamiltonsCubic/Base/SelfDual.lean#L99) and [wedgeSelf](../lean/HamiltonsCubic/Base/SelfDual.lean#L106), taking `wedge2 X X = halfw X X + halfw X X`, and compared against all fifteen `sigma_i_j` right-hand sides as written in [I67AdjugateLaw.lean](../lean/HamiltonsCubic/Results/I67AdjugateLaw.lean). All fifteen agree identically, and each is the Pfaffian of the complementary four-set with the sign of the completing permutation. A perturbation control on `sigma_0_1` fails the same comparison.

Extending $\sigma$ to all thirty-six indices by skewness and forming $\sum_k X_{ik}\sigma_{kj}$, the six diagonal entries equal $-\mathrm{Pf}(X)$ and the thirty off-diagonal entries equal zero, as polynomials in the fifteen free variables. That is the law, so the thirty-six Lean goals are jointly the law and nothing weaker.

## Rows 1 and 3: the count and the indices

Thirty-six `theorem adj_i_j` declarations, `adj_0_0` through `adj_5_5` in lexicographic order, none missing and none repeated. For every one of the thirty-six, the index pair in the name equals the index pair applied to the product in the goal, checked mechanically rather than by reading. Thirty statements end in `= 0`, and those thirty are exactly the $i\ne j$ pairs. The left side is uniformly `(X * ((1/2 : ℝ) • star6 (wedgeSelf X))) i j`, which is $\big(X\,\sigma_6(X)\big)_{ij}$ with the multiplication on the correct side.

**One remark, not a defect.** The identity matrix never appears. A reader recovers $-\mathrm{Pf}(X)\,\mathrm{Id}$ by pairing "diagonal carries the cubic" with "off-diagonal vanishes" themselves, because the file types entries and never assembles them into a matrix equation.

## Row 4: the proofs are honest

All thirty-six signatures are literally `theorem adj_i_j (hX : IsSkew X) :`, with `IsSkew` resolving to the real-valued [IsSkew](../lean/HamiltonsCubic/Base/WeylReal.lean#L34) of `HamiltonsCubic.RealLayer`, one of the two namespaces the file opens. The only other binder is the section variable `X : Matrix (Fin 6) (Fin 6) ℝ`. Every local `have` in every proof is one of: the skewness of $\sigma_6$ from [star6_isSkew](../lean/HamiltonsCubic/Base/SelfDual.lean#L628), which carries no hypothesis at all, its diagonal consequence, or one of the twenty-one entrywise consequences of `hX` (fifteen off-diagonal flips, six vanishing diagonal entries). The external names invoked across the whole file are `star6_isSkew`, the fifteen `sigma_i_j`, and Mathlib's `Matrix.mul_apply`, `Matrix.smul_apply`, `Matrix.transpose_apply`, `Matrix.neg_apply` and `Fin.sum_univ_six`, closing with `linarith` and `ring`. There is no `decide`, no `native_decide`, no local `axiom`.

Each proof cites exactly five `sigma_i_j` lemmas, and each of the fifteen is cited by exactly twelve proofs, which is the count a row-by-row expansion predicts.

On the parent's report that skewness was the whole difficulty: as committed, `hX` is load-bearing in all thirty-six, `adj_0_0` included, since the `sigma_i_j` rewrites each take `hX` as an argument.

## Row 6: no `sorry`, three standard axioms

The string `sorry` occurs once in [I67AdjugateEntries.lean](../lean/HamiltonsCubic/Results/I67AdjugateEntries.lean), at line 9, inside the module docstring that runs to line 24, describing L193's `sorry`. The namespace opens at line 26, so no proof body contains one. The same holds for the two occurrences in the sibling file, and the four dependencies ([SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean), [Bivectors.lean](../lean/HamiltonsCubic/Base/Bivectors.lean), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)) carry none.

`lake build --no-build` reports all targets up to date across 8710 jobs, so the compiled artifacts match the committed source. `#print axioms` on `adj_0_0`, `adj_1_0`, `adj_2_3`, `adj_3_3`, `adj_5_5`, `sigma_0_1` and `sigma_4_5` returns `[propext, Classical.choice, Quot.sound]` for every one, in forty seconds on Lean 4.33.1.

## Row 7: the file does not overclaim, and its own accounting is honest

`pf6` appears twice in the file, both at lines 21 and 23 of the module docstring, under a heading **What is NOT stated** which says plainly that `pf6 X` is not related to the explicit polynomial, names the obstacle as `simp` exceeding its step ceiling on `triple6 X X X`, and states the remaining debt as a scalar identity. `triple6` appears once, in the same paragraph. `adjugate_law` appears once, at line 9, describing L193 rather than claiming anything about it. No theorem in the file mentions `pf6`, and [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) still carries its `sorry` at line 82.

**The file's own "What is NOT stated" section is accurate.** The [INDEX.md](../lean/INDEX.md) row for the file is accurate on the same point, and correctly carries "Gate 2 owed on this file".

**The one correction.** Both the file's docstring and the index row say the remaining debt is *one scalar identity*. That understates it by a small, mechanical step. Granting `pf6 X = <the polynomial>`, L193's `adjugate_law` also needs the thirty-six entry lemmas assembled into a matrix equation, an `ext` plus a case split on the two indices against `Matrix.one_apply`. The step is routine and cheap, but it is not nothing, and the phrase "one scalar identity" invites a reader to think the file is one `rw` from closing L193. Suggested replacement, positive form: *what remains is one scalar identity, `pf6 X = <the polynomial>`, plus the entrywise assembly of the thirty-six lemmas into the matrix statement.*

## Vacuity witness

`IsSkew` is satisfied with $\mathrm{Pf}\ne0$ by the block form $X=\varphi_{01}+\varphi_{23}+\varphi_{45}$, that is $X_{01}=X_{23}=X_{45}=1$ and all other free entries zero, extended by skewness. On it $\mathrm{Pf}(X)=1$, asserted from the recomputed Pfaffian. The thirty-six statements are therefore about something, and the diagonal ones are not vacuously true.

## What this file leaves owed, in one sentence

The file leaves owed the single scalar identity `pf6 X = <the diagonal polynomial>`, blocked by `simp`'s step ceiling on the six nested sums of `triple6 X X X`, together with the entrywise assembly of its thirty-six lemmas into L193's matrix-valued `adjugate_law`.
