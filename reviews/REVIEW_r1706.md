# REVIEW r1706: L240's first step in L240Row.lean, row_le_eight and bracketTotal_le_56 (97872ff0)

**Verdict: CONFIRMED AS MATHEMATICS, DUPLICATE AS A DELIVERABLE.** The four declarations of [L240Row.lean](../lean/HamiltonsCubic/Results/L240Row.lean) are correct and say what the record's first proof line says: `row X i` is the record's $\mathrm{row}_i$, `bracketTotal X = ∑ i, row X i` holds by `rfl`, and `row_le_eight` applies L237's `kappa_cap_norm` at $r=6$ to the element and its six partners in the right norm. **The same three results were already proved, reviewed and indexed two days earlier** in [L240Rows.lean](../lean/HamiltonsCubic/Results/L240Rows.lean) (commits 7a6fdc13 and 992ef9c6, Gate 2 [r1157](REVIEW_r1157.md)), with identical definitions and the same proof route, and the L240 row of [lean/INDEX.md](../lean/INDEX.md) already recorded them. The commit therefore adds a second copy, and the INDEX row now announces as new ("its first step is PROVED in L240Row.lean") what its own later sentence already credits to L240Rows.lean.

| # | Claim | Verdict |
|---|---|---|
| 1a | `row X i` is the record's $\mathrm{row}_i=\sum_{j\ne i}\lVert[X_i,X_j]\rVert^2$ in $\langle X,Y\rangle=-\tfrac12\operatorname{tr}XY$ | **CONFIRMED** |
| 1b | `bracketTotal_eq_sum_row` holds by definition | **CONFIRMED** (`rfl`, the inner sum of `bracketTotal` verbatim) |
| 2a | `ipSo_eq_inner2`: $-\tfrac12\operatorname{tr}(XY)=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ for skew $X$ | **CONFIRMED** (only $X$ skew is needed, as stated) |
| 2b | `row_le_eight` applies $\kappa_6\le8$ correctly: partners via `Fin.succAbove`, unit $X_i$, same `inner2` and `br` | **CONFIRMED** |
| 2c | `bracketTotal_le_56` | **CONFIRMED** |
| 3a | The row claims the first step only, not the lemma | **CONFIRMED** |
| 3b | `seven_frame_lemma`'s `sorry` still correctly described | **CONFIRMED** (unchanged at [SevenFrameGap.lean:649](../lean/HamiltonsCubic/Results/SevenFrameGap.lean#L649), still `sorry`) |
| 3c | The results are new to the layer | **REFUTED**: duplicates of `L240Rows.row`, `L240Rows.row_le_eight`, `L240Rows.bracketTotal_le_56`, `L240Rows.inner2_eq_ipSo` (D1) |
| 4 | Axioms: standard three only | **CONFIRMED** (screen, audit 4/4) |

One line: every declaration is right and the INDEX sentence is true, but it re-proves results the layer already held under Gate 2, and the L240 row now records the same step twice.

## Attack line 1: the row and the total

- **Record.** [second-order.md](../findings/second-order.md), Lemma L240: statement with $\langle X,Y\rangle=-\tfrac12\operatorname{tr}XY$ and $T=\sum_{i\ne j}\lVert[X_i,X_j]\rVert^2$, proof opening "$T=56-\sum_i\delta_i$ with $\delta_i=8-\mathrm{row}_i\ge0$ (L237)". $\mathrm{row}_i$ is L239's $\sum_{j\ne i}\lVert[X_i,X_j]\rVert^2$, ordered over $j$.
- **Lean.** [SevenFrameGap.lean:640](../lean/HamiltonsCubic/Results/SevenFrameGap.lean#L640) defines `ipSo X Y = -(1/2) * (X * Y).trace` and `bracketTotal X = ∑ i, ∑ j, if i = j then 0 else ipSo [X i, X j] [X i, X j]` with the bracket written out as `X i * X j - X j * X i`. `row X i` is exactly that inner sum, so `bracketTotal_eq_sum_row` is definitional and the file proves it by `rfl`. The norm is the record's: `ipSo B B` for skew $B$ equals $\tfrac12\lVert B\rVert_F^2$, the square norm in $-\tfrac12\operatorname{tr}$.

## Attack line 2: the cap and the normalisation

- **`ipSo_eq_inner2`.** `inner2 X Y = ½ tr(XᵀY)` (the `RealLayer` definition, identical in form to [L82Statement.lean:182](../lean/HamiltonsCubic/Results/L82Statement.lean#L182)). With $X^{\mathsf T}=-X$, $\tfrac12\operatorname{tr}(-XY)=-\tfrac12\operatorname{tr}(XY)$. Checked by hand. The hypothesis is on the first argument only, which is the argument that is transposed.
- **The brackets are skew.** `hbr` derives $[X_i,X_j]^{\mathsf T}=-[X_i,X_j]$ from the two skew hypotheses, so `ipSo_eq_inner2` applies to each bracket term.
- **The cap.** [L237SlotCounts.lean:212](../lean/HamiltonsCubic/Results/L237SlotCounts.lean#L212) states `∑ j, inner2 (br X (y j)) (br X (y j)) ≤ (r + 2) * inner2 X X` for skew $X$, $r\ge1$ skew orthonormal $y$ in `inner2`. The file instantiates $X=X_i$, $r=6$, $y_k=X_{\mathrm{succAbove}(i,k)}$. Orthonormality of $y$ follows from `hon` through `ipSo_eq_inner2` and injectivity of `Fin.succAbove i` (`Fin.succAbove_right_inj`), and unitness of $X_i$ is `hon i i`. `Fin.sum_univ_succAbove _ i` splits the row into the zero diagonal term and the six partner terms, and `Fin.succAbove_ne` discharges the `if`. The cap reads $\mathrm{row}_i\le8\cdot1$.
- **Against the record's L237.** The record states $\kappa_6=8$ for $n\ge6$ and smaller values below. `kappa_cap_norm` is the uniform bound $r+2$ at every $n$, which is what L240 ("any $n$") needs, and at $n\le4$ no orthonormal seven-frame exists, so the hypotheses are vacuous there.
- **The total.** $\sum_{i<7}8=56$ by `Finset.sum_le_sum`. The inequality $T\le56$ is exactly $\sum_i\delta_i\ge0$ with each $\delta_i\ge0$, the proof's first line.

## Attack line 3: scope and the sorry

- The file's docstring and the INDEX sentence both call this the first step and name `seven_frame_lemma` as still carrying its `sorry`. Neither claims $T\le54.064$. The `sorry` is untouched and its description in the INDEX row (the slot spectrum, Ky Fan weights, Gram computation, von Neumann, final count) is unchanged by the commit. **CONFIRMED.**
- **D1, the duplicate (the one defect).** [L240Rows.lean](../lean/HamiltonsCubic/Results/L240Rows.lean), committed in 7a6fdc13 and fixed in 992ef9c6 (both ancestors of 97872ff0) and reviewed by [r1157](REVIEW_r1157.md), already contains `inner2_eq_ipSo` (the same identity, sides swapped), `br_skew`, the same `row` definition character for character, `row_le_eight` by the same `kappa_cap_norm` at $r=6$ through `Fin.succAbove`, `bracketTotal_le_56` by the same `calc`, and in addition `exists_small_deficit`. [lean/HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) imports it at line 754. The L240 row of [lean/INDEX.md](../lean/INDEX.md) already said, before this commit: "**The rows**, in L240Rows.lean in `seven_frame_lemma`'s own notation: `row_le_eight` ... and `bracketTotal_le_56`, the proof's opening $T=56-\sum_i\delta_i$ with $\delta_i\ge0$". The commit leaves that sentence in place and prepends a parenthetical crediting the same two theorems to L240Row.lean, so the row now records the step twice under two files, and [plan-lean.md:110](../plan-lean.md#L110) was regenerated from it.
- **Repair (for the lean loop, which owns the file).** Delete L240Row.lean and its staged import, and revert the INDEX row's added parenthetical and its file-column entry, so L240Rows.lean remains the single home of the step. No downstream declaration uses the new namespace `HamiltonsCubic.L240Row` (the two namespaces differ, so both build side by side, which is why the build did not flag it).

## Attack line 4: axioms and build

- `lake build HamiltonsCubic.Results.L240Row`: builds, one style warning (line 14 exceeds 100 characters, in the module docstring). Screen.
- `python3 scripts/misc/axiom_audit.py --only L240Row.lean`: "4/4 clean, resting on the standard three alone". Screen.
- The file has no `sorry`, `native_decide` or `axiom` (read).

## What would break the claims, and where I looked

- **A second `inner2` with a different factor**, which would make `kappa_cap_norm`'s cap a statement in another norm. Looked: L240Row opens `HamiltonsCubic.RealLayer` as L237SlotCounts does, the term typechecks against `kappa_cap_norm` with no coercion, and `ipSo_eq_inner2`'s proof unfolds to $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- **A `row` summed over unordered pairs or over $j<i$ only**, which would halve $T$ against the record's ordered total. Looked: `row` sums over all `j : Fin 7` with the diagonal zeroed, matching `bracketTotal`.
- **Partners that are not orthonormal after reindexing**, which would void `kappa_cap_norm`'s hypothesis. Looked: `succAbove` is injective and misses $i$, so the six partners are distinct and different from $X_i$.
- **A seven-frame with a row above 8**, which would refute L237. None exists by the kernel-checked cap. The record's best frames total $42$, rows averaging $6$.
- **The same theorem already in the layer**, which would make the deliverable redundant. Looked: `grep` for `row_le_eight` and for `exists_small_deficit` (the next line of the proof) found [L240Rows.lean](../lean/HamiltonsCubic/Results/L240Rows.lean), which is D1.

## Findings

- **D1 (defect in the record, not in the mathematics).** L240Row.lean duplicates L240Rows.lean, already reviewed by r1157 and indexed, and the INDEX L240 row now credits the first step to both files. Repair: remove L240Row.lean and its import, and revert the INDEX parenthetical.
- **N1.** Line 14 of L240Row.lean trips the 100-column style linter (moot if D1's repair deletes the file).
- **N2.** The record's own L240 "Lean" line in second-order.md names neither file. Pointing it at L240Rows.lean's three theorems would close that.
- **N3.** The commit's INDEX diff also adds the L278 row, another session's work (its own commit message says that row "rode into 97872ff0"), which 97872ff0's message does not list. The row is that session's and was out of scope here.
