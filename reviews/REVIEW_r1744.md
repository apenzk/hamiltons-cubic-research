# REVIEW r1744: L228 item 2 at the operator, [L228Item2.lean](../lean/HamiltonsCubic/Results/L228Item2.lean)

**Verdict: CONFIRMED WITH OBSERVATIONS.** `L228_item2` states the record's item 2 faithfully at the block `a = 0`, its proof is sound as read, and the INDEX row claims what is typed apart from one untyped parenthetical (O1).

Scope: the working-tree file (uncommitted), [L228Statement.lean](../lean/HamiltonsCubic/Results/L228Statement.lean) for `cubicX`, `cubic_split`, `complete_square`, `complete_square_norm`, [L228Item1.lean](../lean/HamiltonsCubic/Results/L228Item1.lean) for the statement of `L228_item1`, `beta`, `P0`, `N0` (taken as given, r1743 checks it), the Lemma L228 block of [second-order.md](../findings/second-order.md), and the diff of [lean/INDEX.md](../lean/INDEX.md). No `lake build` was run. The file has no `sorry`, `native_decide` or `axiom`, and its `.olean` in `lean/.lake/build` is dated one minute after the source, which is consistent with a successful compile (an inference from timestamps).

## (1) The block `a = 0` against "for each $a$"

- The relabelling argument is sound mathematically. A permutation $\sigma$ of the outer set sends the data to $(t\circ\sigma, X\circ\sigma, K(\sigma\cdot,\sigma\cdot))$, which keeps every hypothesis (`hX`, `hXs`, `hK`, `hK0`), and $\beta$ transforms as $\beta_{\sigma a\,\sigma b}$ since it is built from $K_{ab}$, $t_a$, $t_b$ and the invariant $\mu$. $R_a$, $T_a$, $Y_a$, $\ell'_a$ transform accordingly.
- The transfer back to the original $W$ is untyped. It needs either $P$ and the norm invariant under the outer relabelling of `blockOp`, or (cheaper) item 1's right side invariant under reindexing: `cubicX` and the Gram sum reindex by `Equiv.sum_comp`, `P0` and `N0` sum over $a<b$ and $a<b<c$ of symmetric summands, so they need a symmetrisation step.
- So a statement at an arbitrary `a : Fin (m + 1)` would be stronger as a Lean theorem, though equivalent mathematically. The content is fully present at `a = 0`. See O1.
- Indexing: the Lean `m` is the record's $m-1$ (the outer set is `Fin (m + 1)`), which only excludes the empty outer set, where item 2 is vacuous.

## (2) `cA` and `nA` are free of $X_a$

- `cA t K Xr` and `nA t K Xr` take only `t`, `K` and `Xr = fun i => Xs i.succ`, so by their types they cannot depend on `Xs 0`. This is the record's "do not depend on $X_a$", whose proof fixes "everything but $X_a$", scalars included.
- `cA` uses $\beta_{0,i+1}$ (through $t_0$, $K_{0,i+1}$, $\mu$), $\beta_{i+1,j+1}$ and `P0 t K`, all scalar. `nA` is $\tfrac12\lvert R\rvert^2+\sum_{c\ne0}\lvert X_c\rvert^2+N_0$.

## (3) $\ell'$

- `ℓ = (3/2)•(R*R) + 3•T + 2•∑ i, beta t K 0 i.succ • Xs i.succ` is $\tfrac32R_a^2+3T_a+2\sum_{c\ne a}\beta_{ac}X_c$ at $a=0$, with $R$, $T$, $Y$ the record's.

## (4) The combination, by hand

- `L228_item1` gives $P=\texttt{cubicX}+\sum_{a\ne b}\beta_{ab}\mathop{\mathrm{tr}}(X_aX_b)+P_0$.
- `sum_ne_succ` (symmetry of $\beta$ from `hK`, of the trace pairing from `trace_mul_comm`) splits the Gram sum as $2\sum_i\beta_{0,i+1}\mathop{\mathrm{tr}}(X_0X_{i+1})$ plus the pairs among the others, and `hB0` rewrites the first as $\mathop{\mathrm{tr}}(X_0\cdot2B)$ with $B=\sum_i\beta_{0,i+1}X_{i+1}$.
- `cubic_split` gives $6\mathop{\mathrm{tr}}X_0^3+9\mathop{\mathrm{tr}}(X_0^2R)+\mathop{\mathrm{tr}}(X_0(6R^2+3T))+[2\mathop{\mathrm{tr}}R^3+3\mathop{\mathrm{tr}}(RT)+\sum\mathop{\mathrm{tr}}X_c^3]$. Adding, the $X_0$ part is $6\mathop{\mathrm{tr}}X_0^3+9\mathop{\mathrm{tr}}(X_0^2R)+\mathop{\mathrm{tr}}(X_0L)$ with $L=6R^2+3T+2B$, as briefed.
- `complete_square Y R L` with $X_0=Y-\tfrac12R$ gives $6\mathop{\mathrm{tr}}Y^3+\mathop{\mathrm{tr}}(Y(L-\tfrac92R^2))+\tfrac32\mathop{\mathrm{tr}}R^3-\tfrac12\mathop{\mathrm{tr}}(RL)$, and $L-\tfrac92R^2=\tfrac32R^2+3T+2B=\ell'$ (`hL'`, by `module`).
- `cA` is exactly the bracket from `cubic_split`, plus $\tfrac32\mathop{\mathrm{tr}}R^3-\tfrac12\mathop{\mathrm{tr}}(RL)$ with $L$ written out, plus the Gram pairs among the others, plus `P0`. The closing `linarith` over `hsplit`, `hsq`, `hLs`, `hB0` is the linear combination this describes.

## (5) The norm

- `L228_item1`'s norm with `Fin.sum_univ_succ` twice: $\lvert X_0+R\rvert^2+\lvert X_0\rvert^2+\sum_{c\ne0}\lvert X_c\rvert^2+N_0=2\lvert X_0\rvert^2+2\mathop{\mathrm{tr}}(X_0R)+\lvert R\rvert^2+\cdots$ (`hXX`), and `complete_square_norm` turns $2\lvert X_0\rvert^2+2\mathop{\mathrm{tr}}(X_0R)$ into $2\lvert Y\rvert^2-\tfrac12\lvert R\rvert^2$. Total $2\lvert Y\rvert^2+\tfrac12\lvert R\rvert^2+\sum_{c\ne0}\lvert X_c\rvert^2+N_0$, which is $2\lvert Y\rvert^2+$`nA`.
- $\lvert Y\rvert^2$ is written `(Y * Y).trace`, which is the Frobenius square since $Y$ is symmetric under `hXs`.

**Screen, reported as a screen only.** Exact rational arithmetic at four outer blocks, three random draws of symmetric traceless $X_c$, $t$, symmetric zero-diagonal $K$: `cubicX` plus the Gram sum minus $(6\mathop{\mathrm{tr}}Y^3+\mathop{\mathrm{tr}}(Y\ell')+c_a-P_0)$ is $0$, and the norm residual is $0$, in all three.

## (6) The INDEX row

- It claims `L228_item2` at $a=0$ of `Fin (m + 1)`, the record's $R,T,Y,\ell'$, both identities, `cA` and `nA` explicit in $t$, $K$ and the other blocks, and the four ingredients. All typed.
- The parenthetical "(every block after relabelling)" is a gloss on an untyped transfer (O1). "Owed" correctly drops item 2.

## Falsifiers

- `sum_ne_succ`: a symmetric `f` on `Fin (m + 1)` whose ordered off-diagonal sum differs from twice the pairs through `0` plus the pairs among the others.
- `L228_item2`, value: symmetric traceless blocks, reals `t`, symmetric zero-diagonal `K` with `Pcubic (blockOp …)` different from $6\mathop{\mathrm{tr}}Y^3+\mathop{\mathrm{tr}}(Y\ell')+$`cA`.
- `L228_item2`, norm: the same data with `normSq (blockOp …)` different from $2\mathop{\mathrm{tr}}Y^2+$`nA`.
- "Free of $X_a$" (`cA`, `nA`): true by their signatures, so no object falsifies it.
- The "for each $a$" reading: a permutation $\sigma$ of `Fin (m + 1)` with `Pcubic` or `normSq` of `blockOp` changing under the permuted data.

## Observations

- **O1.** The relabelling from `a = 0` to an arbitrary block is asserted in the header and the INDEX row and typed nowhere. Either state `L228_item2` at an arbitrary `a` over a general `Fintype` outer set, or type the invariance of item 1's right side under `Equiv.Perm (Fin (m + 1))`, or mark the parenthetical in the row as untyped.
- **O2.** The record's own **Lean** paragraph in the L228 block of [second-order.md](../findings/second-order.md) still lists "item 2's Gram and norm expansions" among what lies outside the file, and does not cite `L228Item1.lean` or `L228Item2.lean`. It should be updated when this lands.
