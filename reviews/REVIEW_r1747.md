# REVIEW r1747: the repair of r1746 and L227 at n = 5, [L227Full.lean](../lean/HamiltonsCubic/Results/L227Full.lean)

**Verdict: CONFIRMED WITH OBSERVATIONS.** The repair closes [r1746](REVIEW_r1746.md)'s refutation: every docstring and INDEX row that names $\Theta_n$ now matches the constant typed, the `_of` forms are sound and their instances supply the diagonal hypothesis over the right ranges, and `L227_full` is L227's bound at $n=5$ with $\sqrt{\texttt{thetaOddSq}\,5}=\tfrac{2\sqrt2}3$. The observations are wording and scope notes, none of which changes a typed statement.

Scope: commit 64cca17c, the four Lean files [L57Block.lean](../lean/HamiltonsCubic/Results/L57Block.lean), [L57BlockConj.lean](../lean/HamiltonsCubic/Results/L57BlockConj.lean), [L228Item3.lean](../lean/HamiltonsCubic/Results/L228Item3.lean), [L227Full.lean](../lean/HamiltonsCubic/Results/L227Full.lean), the L227 and L228 rows of [lean/INDEX.md](../lean/INDEX.md), against [problem.md](../findings/problem.md)'s L57 and [second-order.md](../findings/second-order.md)'s L226, L227 and L228. Read only, `lake build` held by another session. The `L227Full.olean` in `lean/.lake/build` is newer than the source, which is circumstantial evidence that the file compiled and is not relied on. No `sorry`, `native_decide` or `axiom` in the four files or the repository.

## (1) Does the repair close r1746?

- Every occurrence of Θ in the four files was read. `L57_block`, `L57_block_conj`, `L228_item3` and `diag_bound` are each described as $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, "the record's $\Theta_n$ at even $n$". `diag_bound_odd`, `L57_block_odd`, `L57_block_conj_odd`, `L228_item3_odd` are described with the odd constant $\Theta_n^2=2(n-1)(n-3)/((n+1)(n-2))$, which is `thetaOddSq` in [L57Odd.lean](../lean/HamiltonsCubic/Results/L57Odd.lean) and the record's odd $\Theta_n$ (problem.md, L57 statement). Each matches its type.
- `L57_block_n4`'s docstring, $\Theta_4=\theta_0(4)=\sqrt{12}/4$, matches its type $\sqrt{2\cdot3\cdot2}/4$. `L227_full`'s docstring, $\Theta_5=2\sqrt2/3$, matches its type.
- L57Block.lean's title "obeys $P\le\Theta_n\lVert W\rVert^3$" is now true, the file holding both parities.
- INDEX L227 row: `L227_full` with $\tfrac{2\sqrt2}3=\Theta_5$, and `L57_block` "the record's $\Theta_n$ at even $n$", `L57_block_odd` "the odd $\Theta_n$". Correct. INDEX L228 row: `L228_item3` "$\theta_0(n)$, the record's $\Theta_n$ at even $n$", `L228_item3_odd` "the record's odd $\Theta_n$ at odd $n\ge5$". Correct.
- The even instances carry no parity hypothesis. They are true at every $n\ge4$ (the $\theta_0$ bound is valid and weaker at odd $n$) and are labelled $\Theta_n$ only at even $n$, which is what r1746 asked for.

## (2) The `_of` forms and their instances

- `L57_block_of`, `L57_block_conj_of`, `L228_item3_of`, `L57_block_le_two_of` take `c` and `hc : ∀ w` weight on `Fin 3 ⊕ Fin m` (resp. `Fin (m + 1)`), `P(diagOp w) ≤ c ‖diagOp w‖³`. The proofs use `hc` only at `wOf S M K` (proved a weight by `wOf_isWeight`) after the norm and $P$ transfers, which are parity-free. Sound.
- `diag_bound (hm : 1 ≤ m)`: `card = m + 3 ≥ 4`, closed by `L57_diagonal`. `diag_bound_odd (hm : 2 ≤ m) (hodd : ¬ Even (m + 3))`: `card ≥ 5` and odd, closed by `L57_diagonal_odd`, `card_block` rewriting the cast. Hypotheses exactly those of the cited theorems.
- `L228_item3` at `Fin (m + 1)` calls `diag_bound (by omega)` with `1 ≤ m + 1`, always true. `L228_item3_odd (hm : 1 ≤ m) (hodd : ¬ Even (m + 1 + 3))` calls `diag_bound_odd` with `2 ≤ m + 1`. `L57_block_odd` and `L57_block_conj_odd` pass `2 ≤ m` and `¬ Even (m + 3)` through. The ranges are $n\ge4$ for $\theta_0$ and odd $n\ge5$ for the odd constant, as briefed.
- Falsifier of the `_of` forms: a weight-bounded `c` and a Ricci-flat `blockOp` in the stated class with $P>c\lVert W\rVert^3$. Of the odd instances: such an operator at odd $n\ge5$ with $P>\Theta_n\lVert W\rVert^3$, which would also falsify `L57_diagonal_odd` through `wOf`.

## (3) L227Full.lean

- `exists_diag_frame`: the spectral theorem through Mathlib's `eigenvectorUnitary`, $A=Q\operatorname{diag}(y)Q^{\mathsf T}$, then $Q^{\mathsf T}AQ=\operatorname{diag}(y)$ from $Q^{\mathsf T}Q=1$. `DiagIn F A` is $(F^{\mathsf T}AF)_{xy}=0$ for $x\ne y$ (L228Item3.lean line 35). Sound.
- `blockOp_normal_form`: $t_a=\operatorname{tr}M_a/3$, $X_a=M_a-t_aI$ traceless and symmetric, $M=t_aI+X_a$ by `add_sub_cancel`. The $J$-row of `ricciFlat_iff` gives $(\operatorname{tr}S)I-S=-N$, `ricciJ_inverse` gives $S=N-\tfrac12(\operatorname{tr}N)I$, and `N_shift` gives $\sum X_a-\tfrac12(\sum t_a)I$, since $\operatorname{tr}N=3\sum t_a$. This is the record's $S=X_1+X_2-mI$ at two outer indices with $\mu=\sum t_a=2m$. Correct.
- `L57_block_le_two_of (hm : m ≤ 1)`: at `m = 0` the frame is `1` and `hdiag` is vacuous. At `m = 1` the frame is `exists_diag_frame` on `Xs 1`, the one block besides `Xs 0`. Then `L228_item3_of` at block $0$, so no relabelling is needed. Sound. Lean's `m` is the outer count minus one, so `m ≤ 1` is the record's "$m\le2$" (outer count, L226's $m=n-k$). The INDEX row's quotation is correct in the record's notation.
- `L227_full`: `thetaOddSq 5` $=2\cdot4\cdot2/(6\cdot3)=8/9=(2\sqrt2/3)^2$, and `Real.sqrt_sq` with positivity gives $2\sqrt2/3$. Hand arithmetic, a screen. `diag_bound_odd (m := 2)` with `2 ≤ 2` and `¬ Even 5` supplies `hc` at `Fin 3 ⊕ Fin 2`, fed to `L57_block_le_two_of (m := 1)` at `Fin (1 + 1)`, definitionally `Fin 2`.
- **Faithfulness to "every unit $W\in\mathcal S_J\cap\mathcal W_5$".** Lean's hypotheses are: symmetric $S$ and $M_a$, symmetric hollow $K$, and all Ricci entries zero. The record's $\mathcal S_J\cap\mathcal W_5$ is symmetric (built in at symmetric blocks), Bianchi and Ricci-flat. L226 item 3 makes Bianchi automatic at $k=3$, and $K$ symmetric and hollow is the parametrisation of $W\varphi_{ab}=K_{ab}\varphi_{ab}$ on unordered pairs. So the typed class is the record's class, neither weakened nor strengthened, given L226's identification of $\mathcal S_J$ with the `blockOp` family, which is the typed layer of [L226Statement.lean](../lean/HamiltonsCubic/Results/L226Statement.lean) and was not re-checked here. The homogeneous form $P\le\Theta_5\lVert W\rVert^3$ is equivalent to the unit form by degree, $P$ cubic and the norm of degree one.
- Falsifier of `L227_full`: symmetric $S$, $M_0$, $M_1$ and a scalar $K_{01}$ with the Ricci form of `blockOp` zero and $P>\tfrac{2\sqrt2}3\lVert W\rVert^3$. Of `L57_block_n4`: the same at one outer block with $P>\tfrac{\sqrt{12}}4\lVert W\rVert^3$.

## (4) What the rows claim beyond the types

- L227 row: "**Owed**: the attainment clause (a unit $W$ with commuting blocks at $\Theta_5$)". Listed owed, correct. Nothing else in the row exceeds a type.
- L228 row: "**Owed**: item 4, and the attainment of $\Theta_n$ in $\mathcal D_n$". Listed owed, correct.
- Falsifier of the owed attainment clause (not typed): a proof that the supremum of $P$ over unit $W$ in the class is not attained, or is attained only at a $W$ whose blocks $M_a$ and $S$ fail to commute.

## Observations

- O1. The INDEX L227 row says "every Ricci-flat `blockOp S M K` with symmetric blocks and two outer indices" and omits the hypothesis that $K$ is symmetric and hollow, which `L227_full` carries. Harmless, since that is the parametrisation, but the row should name it.
- O2. [second-order.md](../findings/second-order.md)'s Lean paragraphs (L227, L228) name "instances `L57_block`, `L57_block_conj` at $c=\theta_0(n)$ for even $n$ and `L57_block_odd` at the odd diagonal constant", omitting `L57_block_conj_odd` and `L228_item3_odd`. Accurate as far as it goes, incomplete as a list.
- O3. `L227_full` rests on L226's identification of $\mathcal S_J\cap\mathcal W_5$ with the Ricci-flat `blockOp` family. That identification is a layer outside this commit, and the row should keep citing it as such.
