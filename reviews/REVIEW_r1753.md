# REVIEW r1753: L271Coord.lean and the L271 row's promotion to proved

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every new theorem is correct and faithful, and it compiles against the built olean with the standard three axioms. (3)'s second and third clauses, and (4)'s "so $Q\ne0$ by (3)", are typed only as links that the prose chains together. No single operator theorem states them.

Target: [L271Coord.lean](../lean/HamiltonsCubic/Results/L271Coord.lean) (commit 1c4cc91d) and the L271 row of [lean/INDEX.md](../lean/INDEX.md). Source: [findings/second-order.md](../findings/second-order.md), Lemma L271. Footing: analysis only. The single computation was `#print axioms` on five theorems against the existing olean, which took seconds and built nothing.

## (1) Is "coordinate-diagonal" faithful as ∃ w, torusOp A U V = coordOp w?

Yes. `coordOp w` sends $X$ to $\operatorname{skew}(w\odot X)$. On a basis bivector $\varphi(a,b)=E_{ba}-E_{ab}$ this gives $\tfrac12(w_{ab}+w_{ba})\,\varphi(a,b)$, so `coordOp w` is diagonal in the basis $e_a\wedge e_b$ with the weights of $w$ symmetrised. Every operator that is diagonal in that basis is `coordOp` of its own weight matrix, so the existential over arbitrary $w$ (neither symmetric nor positive) is exactly "coordinate-diagonal". The index $(i,0),(i,1)$ is the record's $e_{2i-1},e_{2i}$, the basis fixed by the torus that the record's proof of (3) uses.

## (2) Hand checks

- **`torusMat_coord`, off the diagonal ($i\ne j$).** $U_{ij}(\mathrm{cPart}\,B+\mathrm{aPart}\,B)=U_{ij}B$, which is $w_{T}\odot X$ with $w_T=U_{ij}$.
- **`torusMat_coord`, on the diagonal.** With $A$ diagonal the sum is $A_{ii}X_{(i,1)(i,0)}$. Using $J_2=\begin{pmatrix}0&-1\\1&0\end{pmatrix}$ and skewness, entry $(i,0),(i,1)$ is $-A_{ii}X_{(i,1)(i,0)}=A_{ii}X_{(i,0)(i,1)}$ and entry $(i,1),(i,0)$ is $A_{ii}X_{(i,1)(i,0)}$. The diagonal entries match $0\cdot X=0$. This agrees with `wT`.
- **`coord_torus`, the pair test.** $X=\varphi((j,1),(i,0))$ has $X_{(i,0)(j,1)}=1$, so $B_{01}=1$ in block $(i,j)$. At $((i,1),(j,0))$ the value is $-\tfrac12U_{ij}+\tfrac12V_{ij}$. The transpose entry $((j,0),(i,1))$ reads block $(j,i)$ with $B'_{10}=-1$ and gives $\tfrac12U-\tfrac12V$. The skew part is $(V_{ij}-U_{ij})/2$. The coordinate side reads $X_{(i,1)(j,0)}=X_{(j,0)(i,1)}=0$, so it gives $0$ and $U_{ij}=V_{ij}$. The symmetry of $U$ and $V$ is used, as hypothesised.
- **`coord_torus`, the Cartan test.** $X=\varphi((l,0),(l,1))$ has $X_{(l,1)(l,0)}=1$, so the sum is $A_{kl}$. Entry $(k,0),(k,1)$ is $-A_{kl}$ and the transpose entry is $+A_{kl}$, so the skew part is $-A_{kl}$. The coordinate side gives $0$ for $k\ne l$. All four checks hold.

## (3) L271_three_coord and the remaining clauses of (3)

- **The first clause, typed and faithful.** `L271_three_coord` holds at idempotents ($m\ge3$, $A$ symmetric, $U,V$ pair weights) and states coordinate-diagonal $\iff U-V=0$.
  - Forward: `coord_torus` gives $U=V$ off the diagonal, and both diagonals are zero.
  - Backward: idempotency gives $A=A_\mu$, whose off-diagonal entries $V^2-U^2$ vanish, so `torus_coord` applies.
  - The record's "An idempotent in the family" asks for no positivity, and the theorem assumes none.
- **O1: the $m\ge3$ hypothesis is inert.** `L268_torus_idem_core` carries no $m\ge3$, and the INDEX's L268 row records that hypothesis as unused. The hypothesis is harmless. Using `_core` would drop it.
- **O2: the second clause is typed only in parts.** "The only positive solution with $Q=0$ is $I/c$" reads at the operator as: a positive-definite idempotent `torusOp A U U` equals $\mathrm{idOp}/(2(m-1))$. Four typed links give it:
  - `L268_pd_pos` gives $\mu>0$.
  - `L268_torus_idem` gives $A=A_\mu$ and the system.
  - `L271_Q_zero` gives $U\equiv1/(2(m-1))$.
  - $A_\mu=\operatorname{diag}(2(m-1)u^2)=I/c$ and `idOp_eq_torusOp` with linearity give the operator.

  `L271_Q_zero` itself stops at the weights and names neither $A$ nor the operator. The composition is mechanical but untyped.
- **O3: the third clause is immediate but untyped.** "Every other torus-invariant PD idempotent has $V_{ij}\ne U_{ij}$ for some pair" is the contrapositive of O2's composite.
  - It is immediate once that composite exists. It has no named theorem.
  - Its "torus-invariant" reads through `torusOp`. The fact that every $T$-invariant symmetric operator is a `torusOp` is owed on the L268 row ([r1629](REVIEW_r1629.md)) and is excluded here. L271 is stated "in L268's notation", on the family $A\oplus\bigoplus\mu_\alpha I_{R_\alpha}$.

## (4) AEq_swap, AEq_sign, pos_not_swap

- **`AEq_swap` is correct.** $d_i=\sum_l(U^2+V^2)=\tfrac12\sum_l(P^2+Q^2)$ is `dPQ`, which is symmetric in $P,Q$, and $-P_{ij}Q_{ij}$ is symmetric too.
- **`AEq_sign` is correct.** Given $s_i^2=1$, $(SAS)_{ii}=A_{ii}$, and `dPQ` depends only on $Q^2$. $s_is_jA_{ij}=-P_{ij}s_is_jQ_{ij}$ holds exactly when $A_{ij}=-P_{ij}Q_{ij}$. Together with L271Sym's `PQSys_*` and `Fpq_*`, these complete "the system and $F$ are invariant", which closes r1752's O1.
- **`pos_not_swap` is correct and stronger than the record.** $\lvert q\rvert<p$ and $\lvert p\rvert<q$ give $q<p<q$. The theorem shows that the swap of a positive solution is never positive, where the record says only that the swap "does not preserve" positivity. It closes r1752's O3.

## (5) Is the promotion to proved justified?

**Mostly, and with one wording fix.** Coverage clause by clause:

| Clause | Typed at | Gap |
|---|---|---|
| (1) norm and $F$ | `L271_F_slice` | none |
| (2) system, $A$ equations | `L271_pq_system` | none |
| (2) symmetries | L271Sym, `AEq_swap`, `AEq_sign`, `Fpq_neg` | none |
| (2) positivity iff $P>\lvert Q\rvert$ | `pos_iff`, `L268_pd_pos`, `L268_torus_pd` | none |
| (2) swap breaks positivity | `pos_not_swap` | none |
| (3) coordinate-diagonal iff $Q=0$ | `L271_three_coord` | none |
| (3) positive with $Q=0$ is $I/c$ | `L271_Q_zero` on the weights | O2: operator composite untyped |
| (3) every other PD has $U\ne V$ somewhere | nothing | O3: contrapositive of O2, immediate |
| (4) split, eigenvalue, threshold | `L271_split_core`, `L271_eigen`, `L271_threshold` | O4 |

- **O4: (4)'s parenthesis is not typed.** `L271_eigen` assumes $C_P,C_Q\ne0$ directly. The record's "for $C\ne I/c$ (so $Q\ne0$ by (3))" is the O2/O3 composite again and is untyped.
- **O5: the row overstates.** "Every clause of L271 is typed at the operator" is true of (1), (2), (3)'s first clause and (4)'s formulas. For (3)'s second and third clauses it holds as a chain of typed links. The row should say so, or a short theorem `L271_Q_zero_op` (positive-definite idempotent `torusOp A U U` $=\mathrm{idOp}/(2(m-1))$) with its contrapositive would make it literal. The promotion stands on that reading, because no mathematics is missing, only assembly.
- **O6: cosmetic duplicates.** `cPart_10`, `aPart_10`, `cPart_01` and `aPart_01` repeat same-named lemmas in `I117S` (`cPart_10` and `cPart_01` exist there, in the form $(\cdot)/2$). The file compiles, so name resolution worked, but the duplicates are redundant.

## What would falsify each statement

- **`torusMat_coord` and `torus_coord`:** a diagonal $A$, a matrix $U$ and a skew $X$ where some entry of `torusMat A U U X` differs from $w_T\odot X$.
- **`coord_torus`:** symmetric $U\ne V$ at a pair, or a non-diagonal $A$, whose `torusOp` still equals some `coordOp w`.
- **`L271_three_coord`:** an idempotent `torusOp` with $U\ne V$ that is coordinate-diagonal, or one with $U=V$ that is not.
- **`AEq_swap` and `AEq_sign`:** a triple $(A,P,Q)$ satisfying the Cartan equations whose swapped or sign-conjugated triple fails them.
- **`pos_not_swap`:** reals with $\lvert q\rvert<p$ and $\lvert p\rvert<q$.
- **(3)'s composite:** a positive-definite torus idempotent with $U=V$ other than $I/(2(m-1))$.

## Axioms

`#print axioms` on `L271_three_coord`, `coord_torus`, `AEq_swap`, `AEq_sign` and `pos_not_swap` gives `propext`, `Classical.choice` and `Quot.sound`. The file contains no `sorry` and no `native_decide`, and the olean (02:09) is newer than the source (02:08).
