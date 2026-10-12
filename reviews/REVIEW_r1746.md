# REVIEW r1746: the rotation on the block family and L228 item 3, [L57BlockConj.lean](../lean/HamiltonsCubic/Results/L57BlockConj.lean) and [L228Item3.lean](../lean/HamiltonsCubic/Results/L228Item3.lean)

**Verdict: REFUTED, for the claim and not for the proofs.** Every declaration in both files is sound as read and the chain of `L228_item3` is the record's proof of item 3 step for step. But the bound all three theorems conclude is `√(2(n−1)(n−2))/n · ‖W‖³`, which is the record's $\Theta_n$ only at even $n$. At odd $n$ the record's $\Theta_n$ is $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$, strictly smaller, so `L228_item3` proves item 3 at even $n$ only, and the INDEX rows that write "$P(W)\le\Theta_n\lVert W\rVert^3$" and "Item 3 PROVED" overclaim at odd $n$. The defect is inherited from `L57_block` ([r1745](REVIEW_r1745.md) passed it) and the repair is mechanical: [L57Odd.lean](../lean/HamiltonsCubic/Results/L57Odd.lean) already has `L57_diagonal_odd`.

Scope: both files as committed in 376954fe and 4023688a (identical to the working tree), `L57_block` in [L57Block.lean](../lean/HamiltonsCubic/Results/L57Block.lean), `L228_item2` in [L228Item2.lean](../lean/HamiltonsCubic/Results/L228Item2.lean), `align_to_frame` and `inFrame` in [L228Statement.lean](../lean/HamiltonsCubic/Results/L228Statement.lean), `N_shift` in [L228Item1.lean](../lean/HamiltonsCubic/Results/L228Item1.lean), `blockP`, `cubicJ`, `ricciJ_inverse` in [L226Statement.lean](../lean/HamiltonsCubic/Results/L226Statement.lean), `ricciFlat_iff` in [L226Mixed.lean](../lean/HamiltonsCubic/Results/L226Mixed.lean), Lemma L228 in [second-order.md](../findings/second-order.md), Lemma L57 and the parity note in [problem.md](../findings/problem.md), and the L227 and L228 rows of [lean/INDEX.md](../lean/INDEX.md). No `lake build` was run. Neither file has `sorry`, `native_decide` or `axiom`. Both `.olean` files postdate their sources (01:25:15 against 01:24:23, 01:28:56 against 01:28:08), which is consistent with a clean compile (an inference from timestamps). No numerical screen was run beyond evaluating the two constants at $n=5$.

## (1) The conjugation identities and `blockP_conj`

- `conj_mul` needs only $FF^{\mathsf T}=1$: $F^{\mathsf T}AF\,F^{\mathsf T}BF=F^{\mathsf T}A(FF^{\mathsf T})BF$. Correct.
- `trace_conj`: $\operatorname{tr}(F^{\mathsf T}AF)=\operatorname{tr}(FF^{\mathsf T}A)$ by cyclicity. Correct.
- `det_conj`: $\det F^{\mathsf T}\det A\det F=\det A\,(\det F)^2$ and $(\det F)^2=1$ from $F^{\mathsf T}F=1$. Correct.
- `adj_formula` is Cayley–Hamilton at size 3, $\operatorname{adj}A=A^2-(\operatorname{tr}A)A+e_2(A)I$ with $e_2=\tfrac12((\operatorname{tr}A)^2-\operatorname{tr}A^2)$, proved entrywise. Correct for every $3\times3$ $A$, symmetric or not.
- `adj_conj` pushes the formula through `conj_mul` and `trace_conj`, and the identity term uses $F^{\mathsf T}\cdot1\cdot F=1$. Correct.
- `blockP_conj`: `blockP` is `cubicJ S` (trace of the cube and $3\det$), $\operatorname{tr}M_a^3+3\operatorname{tr}(S\operatorname{adj}M_a)$, $\operatorname{tr}(M_aM_b)$ and scalars in $K$. The adjugate term becomes $\operatorname{tr}(F^{\mathsf T}SF\,F^{\mathsf T}\operatorname{adj}(M_a)F)=\operatorname{tr}(S\operatorname{adj}M_a)$. Every term is covered. `normSq_conj` likewise.
- Falsifier: a real $3\times3$ $A$ and orthogonal $F$ with $\operatorname{adj}(F^{\mathsf T}AF)\ne F^{\mathsf T}\operatorname{adj}(A)F$, or a $(S,M,K)$ whose `blockP` changes under the rotation.

## (2) `ricci_conj`

- `ricciFlat_iff` characterises Ricci-flatness of `blockOp S M K` (symmetric $S$, $M_a$, symmetric hollow $K$) as $(\operatorname{tr}S)I-S+\sum_aM_a=0$ and $\operatorname{tr}M_a+\sum_bK_{ab}=0$.
- The J condition is conjugated as a whole: $F^{\mathsf T}(\dots)F=0$, expanded with $F^{\mathsf T}F=1$ on the identity term and `trace_conj` on $\operatorname{tr}S$. The outer condition only sees $\operatorname{tr}M_a$, which is invariant. `isSymm_conj` supplies the symmetry hypotheses on the rotated side. Sound.
- Falsifier: a Ricci-flat `blockOp S M K` with $F^{\mathsf T}SF$, $F^{\mathsf T}M_aF$ giving a non-Ricci-flat operator.

## (3) `L57_block_conj`

- Hypothesis: $F$ orthogonal, $F^{\mathsf T}SF$ and every $F^{\mathsf T}M_aF$ diagonal, the original operator Ricci-flat, $m\ge1$. That is the right hypothesis: it is what item 3's proof produces ("Every block of $W'$ and $S'$ are diagonal in $F$") and exactly what `L57_block` needs after the rotation. `Pcubic_blockOp` and `normSq_blockOp` carry $P$ and the norm to `blockP` and L226's norm formula, which are invariant, and `ricci_conj` feeds `L57_block`.
- **Conclusion: `√(2(n−1)(n−2))/n · ‖W‖³` at $n=m+3$, at every $n$.** This is $\theta_0(n)$. The record's L57 ("the diagonal theorem, all $n$, both parities", [problem.md](../findings/problem.md)) bounds by $\Theta_n$, which is $\theta_0(n)$ at even $n$ and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, and the record states the difference as $\theta_0(n)^2-\Theta_n^2=\tfrac{8(n-1)}{n^2(n+1)(n-2)}$, adding that "a bound read off $\theta_0$ at odd $n$ describes no object". At $n=5$ the two are $\sqrt{24}/5\approx0.980$ and $\sqrt{8/9}\approx0.943$.
- So `L57_block` and `L57_block_conj` are true theorems and are the record's L57 on the block family at even $n$ only. The brief's gloss "$\Theta_n=\sqrt{2(n-1)(n-2)}/n$" and r1745's (5) ("the record's $\Theta_n$ at $n=m+3$") are both wrong at odd $n$.
- Falsifier of the typed statement: a Ricci-flat block operator, $S$ and $M_a$ diagonalised by one orthogonal $F$, with $P>\theta_0(m+3)\lVert W\rVert^3$. Falsifier of the record-level reading at odd $n$: the same with $P$ between $\Theta_n\lVert W\rVert^3$ and $\theta_0(n)\lVert W\rVert^3$, which the Lean statement does not exclude.

## (4) `L228_item3`

- **Hypothesis.** `DiagIn F A` is $F^{\mathsf T}AF$ diagonal, i.e. $A$ diagonal in the orthonormal frame of $F$'s columns. `hdiag : ∀ i, DiagIn F (Xs i.succ)` is the record's "the blocks $X_c$, $c\ne a$, simultaneously diagonal in one orthonormal frame" at $a=0$, no more. The operator is `blockOp` with $S=X-\tfrac12\mu I$, $M_a=t_aI+X_a$, traceless symmetric $X_a$, symmetric hollow $K$, plus full Ricci-flatness. The fixed form of $S$ is what the J rows force (`L228_item1_ricci`), so this is the record's $W\in\mathcal S_J\cap\mathcal W_n$ in L226's parametrisation, nothing added. Non-vacuous: $t=0$, $K=0$ and any traceless symmetric $X_a$ satisfy both Ricci conditions.
- **$\ell'$ diagonal in $F$.** $R$, $T=\sum X_c^2$, $\sum\beta_{0c}X_c$ and $R^2$ are, by `diagIn_sum`, `diagIn_mul` (which uses $FF^{\mathsf T}=1$ correctly) and `diagIn_smul`, and `eq_inFrame` writes $\ell'=F\operatorname{diag}(l)F^{\mathsf T}$. Matches the record.
- **Alignment.** `align_to_frame` gives $Y'=F\operatorname{diag}(y)F^{\mathsf T}$ with the same $\operatorname{tr}Y$, $\operatorname{tr}Y^2$, $\operatorname{tr}Y^3$ and $\operatorname{tr}(Y\ell')\le\operatorname{tr}(Y'\ell')$.
- **$W'$.** `Xs' = Fin.cons (Y' − ½R) (Xs ∘ succ)` keeps the other blocks, $t$ and $K$. $X'_0$ is traceless ($\operatorname{tr}Y'=\operatorname{tr}Y=\operatorname{tr}X_0+\tfrac12\operatorname{tr}R$) and symmetric. Applying `L228_item2` to `Xs'` gives the same $R$, $T$, $\ell'$, `cA`, `nA` (all functions of `Xs' ∘ succ = Xs ∘ succ`) and $Y$-slot $Y'$ after `sub_add_cancel`.
- **$P(W')\ge P(W)$** by $\operatorname{tr}Y'^3=\operatorname{tr}Y^3$ and the pairing, **same norm** by $\operatorname{tr}Y'^2=\operatorname{tr}Y^2$. Correct.
- **Ricci-flat.** J rows: `N_shift` gives $S'=N'-\tfrac12(\operatorname{tr}N')I$ for $N'=\sum M'_a$, and `ricciJ_inverse` turns that into $(\operatorname{tr}S')I-S'=-N'$. Outer rows: $\operatorname{tr}M'_a=3t_a=\operatorname{tr}M_a$, so the old condition transfers. Correct and matches the record.
- **Every block diagonal in $F$.** $X'_0$ by `diagIn_inFrame` and `diagIn_sub`, the rest by hypothesis, $S'$ and $M'_a$ by closure with `diagIn_one`. Then `L57_block_conj` at $m+1\ge1$ and `hPle.trans` close it.
- Falsifier of the typed statement: a Ricci-flat $W$ in the family with $X_1,\dots,X_m$ diagonal in one $F$ and $P(W)>\theta_0(m+4)\lVert W\rVert^3$. **The conclusion is the record's item 3 exactly when $n=m+4$ is even.** At odd $n$ it is the weaker $\theta_0$ bound, per (3).
- Not typed and not listed as owed: the record's sentences "In items 3 and 4 the value $\Theta_n$ is attained in $\mathcal D_n\subseteq\mathcal S_J$" and "At $m\le2$ item 3 covers every $W$".

## (5) The INDEX rows

- **L227 row** says `L57_block_conj` has "$P(W)\le\Theta_n\lVert W\rVert^3$". With the record's $\Theta_n$ this is false at odd $n$ as a description of the typed statement. L227 is $n=5$, odd, so for L227 itself the typed bound is $\theta_0(5)$, not $\Theta_5$. The "Owed: the membership of $W'$" is accurate.
- **L228 row** says "Item 3 PROVED" with "$P(W)\le\Theta_n\lVert W\rVert^3$". Overclaims at odd $n$ (even $m$ in the file's `Fin (m + 1)`). Everything else in the row (the chain, the lemmas cited, "Owed: item 4") matches what is typed.
- The same overclaim sits in the docstrings of [L57Block.lean](../lean/HamiltonsCubic/Results/L57Block.lean) (line 236 defines "$\Theta_n=\sqrt{2(n-1)(n-2)}/n$"), [L57BlockConj.lean](../lean/HamiltonsCubic/Results/L57BlockConj.lean) and [L228Item3.lean](../lean/HamiltonsCubic/Results/L228Item3.lean), and in the Lean paragraph of L228 in [second-order.md](../findings/second-order.md), which says `L57_block` gives "$P(W)\le\Theta_n\lVert W\rVert^3$, $n=m+3\ge4$".

## Repair

- Add `L57_block_odd`: the same `hP`, `hN` as `L57_block`, closed by `L57_diagonal_odd` (hypotheses `5 ≤ card` and `¬ Even card`, i.e. $m\ge2$ and $m$ even), giving `√(thetaOddSq (m+3))`.
- Carry it through `L57_block_conj` (the rotation part is parity-free, so an odd twin is a one-line change of the final `exact`) and `L228_item3` (only the final `L57_block_conj` call changes). Alternatively state one theorem with the parity-split constant.
- Until then, the INDEX rows and docstrings should read "$\theta_0(n)$, which is $\Theta_n$ at even $n$" and list item 3 at odd $n$ as owed. [REVIEW_r1745.md](REVIEW_r1745.md) (5) should carry a note that its constant check holds at even $n$ only.

## Observations

- O1: `ricci_conj` and `L57_block_conj` assume both $F^{\mathsf T}F=1$ and $FF^{\mathsf T}=1$. For square real matrices each implies the other, so this is harmless redundancy.
- O2: `L228_item3` assumes the fixed form of $S$ and full Ricci-flatness, the J half of which is then re-derived for $W'$ from the form alone. This matches the record's setting and costs nothing.
