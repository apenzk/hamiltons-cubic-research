# REVIEW r1157: L240's rows and deficit step in Lean

Brief: [2026-09-25-L240rows-gate2-brief.md](2026-09-25-L240rows-gate2-brief.md). Declarations read at 3ae14ff9 in [L240Rows.lean](../lean/HamiltonsCubic/Results/L240Rows.lean), against the first two sentences of L240's proof in [second-order.md](../findings/second-order.md#lemma-l240-the-seven-frame-lemma-every-orthonormal-seven-frame-in-son-has-bracket-total-at-most-54064). Analysis-only. One exact-rational screen of three constants (seconds), reported as a screen.

## Verdicts

| item | verdict | correction |
|---|---|---|
| 1. hypotheses, vacuity, `row` | CONFIRMED | none |
| 2. the constant $1.936/7$ | CONFIRMED with one correction | the smallest later threshold is $0.277$, and the stability note's step 6 still carries $0.27657$ |
| 3. build, axioms, INDEX row | CONFIRMED with one correction | the INDEX row's "every later threshold being at least $0.2871$" should read $0.277$ |

## Item 1

- **`inner2_eq_ipSo`.** `inner2 A B` is $\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$ and `ipSo A B` is $-\tfrac12\mathop{\mathrm{tr}}(AB)$, so $A^{\mathsf T}=-A$ is exactly what equates them. The hypothesis is on $A$ alone, which is the right one. `br_skew` is the transpose identity $[A,B]^{\mathsf T}=B^{\mathsf T}A^{\mathsf T}-A^{\mathsf T}B^{\mathsf T}=BA-AB=-[A,B]$, stated with both skew hypotheses. CONFIRMED.
- **`row` is the row of `bracketTotal`.** Its body is the inner sum of `bracketTotal` in [SevenFrameGap.lean](../lean/HamiltonsCubic/Results/SevenFrameGap.lean) (line 643) verbatim, with `ipSo` of the bracket, and both `bracketTotal_le_56` and `exists_small_deficit` close `bracketTotal X = ∑ i, row X i` by `rfl`, which the kernel accepted. CONFIRMED.
- **`row_le_eight` and `bracketTotal_le_56`** take `hskew : ∀ i, (X i)ᵀ = -X i` and `hon : ∀ i j, ipSo (X i) (X j) = if i = j then 1 else 0`, the hypotheses of `seven_frame_lemma` character for character. The six partners are `X (i.succAbove k)`, their `inner2`-orthonormality is transported from `hon` through `inner2_eq_ipSo` and `Fin.succAbove_right_inj`, and `kappa_cap_norm` at $r=6$ with $\langle X_i,X_i\rangle=1$ gives $\le8$. The only rewrite between `kappa_cap_norm`'s sum and `row` is `Fin.sum_univ_succAbove` at $i$ with the diagonal term $0$. CONFIRMED.
- **`exists_small_deficit`** carries neither `hskew` nor `hon`. It is the pure averaging step from the definition of `row`, so it holds for every family of matrices and is stronger than the proof needs. It asserts nothing about $\delta_i\ge0$, which the proof takes from `row_le_eight`.
- **Vacuity.** `hon` is unsatisfiable when $\dim\mathfrak{so}(n)<7$, that is $n\le4$. This is the same range in which `seven_frame_lemma` is vacuous, and the record's "any $n$" is true there trivially. No weakening beyond the target statement. CONFIRMED.

## Item 2

- **$0.27657$ does not follow.** $7\times0.27657=1.93599<1.936$ (exact rational screen). All seven $\delta_i=0.27657$ gives $\sum\delta_i=1.93599<1.936$, so $T>54.064$ with smallest deficit exactly $0.27657$: the rounded strict bound is false as a consequence. $1.936/7=0.2765714\ldots$ is the correct constant. CONFIRMED.
- **Later thresholds.** The proof in [the stability note](2026-09-24-I73-seven-frame-stability.md) uses the deficit $x$ against two thresholds.
  - $x<0.277$ (equivalently $y\le x\le0.277$): the triangle gap lemmas `triangle_gap_*` (conclusion $\ge277/1000$), the star gap lemmas `sgM_*`, `sgK` (hypothesis `yS … ≤ 277/1000`), and L239's scope "deficit below $0.277$".
  - $x<0.2871$: the final count, $3.204-5.416x>1.936-x$ iff $x<1.268/4.416=0.28714\ldots$.
  - Both exceed $1.936/7$, so nothing downstream needs the rounded value. The binding one is $0.277$, with margin $0.00043$. CONFIRMED.
- **Correction, residual rounding.** [the stability note](2026-09-24-I73-seven-frame-stability.md) step 6 (line 101) still reads "$x\le\sum\delta_i/7<0.27657$". [second-order.md](../findings/second-order.md) has been repaired to $1.936/7$. The note's line should read $<1.936/7=0.2765714\ldots$.

## Item 3

- **Build.** `lake build HamiltonsCubic.Results.L240Rows` completed successfully (8741 jobs). The one `sorry` warning in the log is `seven_frame_lemma` in [SevenFrameGap.lean](../lean/HamiltonsCubic/Results/SevenFrameGap.lean) line 649, which no L240Rows declaration uses. The remaining warnings are three unused simp arguments (lines 30, 45) and two long lines (68, 69), lint only.
- **Axioms.** `python3 scripts/misc/axiom_audit.py --only L240Rows`: 5 of 5 declarations clean, resting on the standard three alone.
- **INDEX row.** [lean/INDEX.md](../lean/INDEX.md) L240's "The rows" sentence names exactly `row_le_eight`, `bracketTotal_le_56`, `exists_small_deficit` and their content, and keeps (c), (d), (e) owed. It claims nothing the file lacks. **Correction**: "the exact value is harmless downstream, every later threshold being at least $0.2871$" is false as a reason. The gap lemmas' threshold is $0.277$. Suggested: "every later threshold being at least $0.277$ (the gap lemmas), the count's being $0.2871$". The conclusion (harmless) stands. CONFIRMED with that wording correction.
