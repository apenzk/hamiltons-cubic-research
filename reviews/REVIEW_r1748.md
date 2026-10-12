# REVIEW r1748: L228 item 4 in Lean, [L228Item4.lean](../lean/HamiltonsCubic/Results/L228Item4.lean)

**Verdict: CONFIRMED WITH OBSERVATIONS.** `L228_item4_of` is the record's item 4 at $a=0$, $b=1$ with the record's proof step for step: `E_split` is item 1's value split into a $V$-free part and exactly $\tfrac32\operatorname{tr}(V^2X)+\tfrac34\operatorname{tr}(V^2U)-\tfrac12\beta_{01}\operatorname{tr}V^2+\sum_c(\beta_{0c}-\beta_{1c})\operatorname{tr}(VX_c)$, `align_lin` is a sound Birkhoff step for arbitrary coefficients, and the constants are labelled as r1746 and r1747 require. The observations are wording notes on the INDEX row and do not change a typed statement.

Scope: the working-tree file (uncommitted), the L228 row of [lean/INDEX.md](../lean/INDEX.md), against [second-order.md](../findings/second-order.md) Lemma L228 statement item 4 and proof step 4. L228Item1 to 3, L57Block, L57BlockConj and L227Alignment taken as given (r1743 to r1747). Read only, `lake build` held by another session. The `L228Item4.olean` in `lean/.lake/build` (01:44) is newer than the source (01:43). `lake env lean` on a scratch file with `#print axioms` against that olean reports `[propext, Classical.choice, Quot.sound]` for `L228_item4_of`, `L228_item4`, `L228_item4_odd`, `le_perm_general`, `align_lin` and `E_split`. No `sorry`, `native_decide` or `axiom` in the file.

## (1) `le_perm_general` and `align_lin`

- `le_perm_general`: the map $M\mapsto\sum_{i,k}M_{ik}c_{ik}$ is linear for any $c$, hence convex, and $(B_{ik}^2)$ is doubly stochastic for orthogonal $B$ (`sq_mem_doublyStochastic`), so it lies in the convex hull of permutation matrices (Mathlib's Birkhoff, `doublyStochastic_eq_convexHull_permMatrix`). `ConvexOn.exists_ge_of_mem_convexHull` gives a vertex $P_\sigma$ with value no smaller, and $\sum_{i,k}(P_\sigma)_{ik}c_{ik}=\sum_ic_{i\sigma(i)}$. Correct for arbitrary real $c_{ik}$, no sign or structure assumed.
- `align_lin`: $V=Q\operatorname{diag}(\nu)Q^{\mathsf T}$, $B=Q^{\mathsf T}F$ orthogonal (both products checked). With $Z=F\operatorname{diag}(z)F^{\mathsf T}$, $L=F\operatorname{diag}(l)F^{\mathsf T}$, $\operatorname{tr}(V^2Z)+\operatorname{tr}(VL)=\sum_{i,k}B_{ik}^2(\nu_i^2z_k+\nu_il_k)$, one linear form in $B^{\circ2}$ with $c_{ik}=\nu_i^2z_k+\nu_il_k$, which is the record's form. $V'=F\operatorname{diag}(\nu\circ\sigma^{-1})F^{\mathsf T}$ gives $\sum_k\nu_{\sigma^{-1}k}^2z_k+\nu_{\sigma^{-1}k}l_k=\sum_i\nu_i^2z_{\sigma i}+\nu_il_{\sigma i}$, the permutation value. Its spectrum is $\nu$ permuted, so trace and $\operatorname{tr}V^2$ agree (both typed). Sound. The combined pairing is essential here: the two terms are aligned by one permutation, and the coefficient matrix makes that automatic.
- Falsifier: an orthogonal $F$, symmetric $V$ and vectors $z,l$ with $\operatorname{tr}(V^2Z)+\operatorname{tr}(VL)$ strictly above every $\sum_i\nu_i^2z_{\sigma i}+\nu_il_{\sigma i}$. Birkhoff excludes it.

## (2) The pair identities and `E_split`

Hand check with $A=\tfrac12(U+V)$, $B=\tfrac12(U-V)$, all $3\times3$ real, not assumed commuting.

- `sq_pair`: $(A+B)^2+(A-B)^2=2A^2+2B^2$, so $\lvert X_a\rvert^2+\lvert X_b\rvert^2=\tfrac12(\lvert U\rvert^2+\lvert V\rvert^2)$. This is the record's "the norm is fixed" at fixed $U$ and $\lvert V\rvert$.
- `xsq_pair`: $\operatorname{tr}(XA^2)+\operatorname{tr}(XB^2)=\tfrac12\operatorname{tr}(XU^2)+\tfrac12\operatorname{tr}(V^2X)$, the last by cyclicity from $\operatorname{tr}(XV^2)$.
- `cube_pair`: $(U+V)^3+(U-V)^3$ keeps the words with an even number of $V$: $2U^3$ plus $2(UV^2+VUV+V^2U)$. The three two-$V$ words have equal trace only by cyclicity, giving $\operatorname{tr}A^3+\operatorname{tr}B^3=\tfrac18(2\operatorname{tr}U^3+6\operatorname{tr}(V^2U))=\tfrac14\operatorname{tr}U^3+\tfrac34\operatorname{tr}(V^2U)$. Correct. The Lean proof is entrywise `ring`, which contains the cyclicity.
- `mul_pair`: $(A+B)^2-(A-B)^2=2(AB+BA)$, trace $4\operatorname{tr}(AB)$.
- `lin_pair`: $b_0A+b_1B=\tfrac{b_0+b_1}2U+\tfrac{b_0-b_1}2V$, paired with $C$.
- `sum_ne_split2`: `sum_ne_succ` twice gives $\sum_{a\ne b}g=2g_{01}+2\sum_i(g_{0,i+2}+g_{1,i+2})+\sum_{i\ne j}g_{i+2,j+2}$ for symmetric $g$, and $g_{ab}=\beta_{ab}\operatorname{tr}(X_aX_b)$ is symmetric by $K$ symmetric and trace cyclicity.
- `E_split`, summing: $3\cdot$`xsq_pair` gives $\tfrac32\operatorname{tr}(XU^2)+\tfrac32\operatorname{tr}(V^2X)$, `cube_pair` gives $\tfrac14\operatorname{tr}U^3+\tfrac34\operatorname{tr}(V^2U)$, $2\beta_{01}\cdot$`mul_pair` gives $\tfrac12\beta_{01}\lvert U\rvert^2-\tfrac12\beta_{01}\lvert V\rvert^2$, and the cross terms give $\sum_c(\beta_{0c}+\beta_{1c})\operatorname{tr}(UX_c)+(\beta_{0c}-\beta_{1c})\operatorname{tr}(VX_c)$. So the $V$-part is exactly $\tfrac32\operatorname{tr}(V^2X)+\tfrac34\operatorname{tr}(V^2U)-\tfrac12\beta_{01}\operatorname{tr}V^2+\sum_c(\beta_{0c}-\beta_{1c})\operatorname{tr}(VX_c)$, as `PsiE` defines it. The record's $L$ carries no factor $\tfrac12$ because the ordered-pair sum counts each $c$ twice, which matches.
- `PsiE_eq` rewrites it as $\operatorname{tr}(V^2Z)+\operatorname{tr}(VL)-\tfrac12\beta_{01}\operatorname{tr}V^2$, $Z=\tfrac32X+\tfrac34U$, $L=\sum_c(\beta_{0c}-\beta_{1c})X_c$. The record's "depends on the frame of $V$ only through $\operatorname{tr}(V^2Z)+\operatorname{tr}(VL)$" holds, the third term being spectral.
- Falsifier: $3\times3$ matrices $A,B,X$ violating any one identity, for instance a non-commuting pair with $\operatorname{tr}(UV^2)\ne\operatorname{tr}(VUV)$, which cyclicity forbids.

## (3) Hypothesis and chain of `L228_item4_of`

- Hypotheses: `hUd : DiagIn F (Xs 0 + Xs 1)`, `hrest : ∀ i : Fin m, DiagIn F (Xs i.succ.succ)`, $F$ orthogonal. That is the record's hypothesis at $a=0$, $b=1$ exactly. The outer set is `Fin (m + 2)`, so Lean's `m` is the record's $m-2$ and the record's $m\ge2$ is built into the type, with $n=(m+2)+3$.
- $W'$ with $X'_0=\tfrac12(U+V')$, $X'_1=\tfrac12(U-V')$, other blocks unchanged: `hU'`, `hV'`, `hXr'` and `hX'` give the same $U$, $X$ and other blocks, and $t$, $K$ are reused, so `PhiE` and $P_0(t,K)$ agree. The $V$-part is no smaller by `h3`, and $-\tfrac12\beta_{01}\operatorname{tr}V^2$ is unchanged by `h2`. `hPle` is `linarith` on those.
- Traceless: $\operatorname{tr}X'_{0,1}=\tfrac12(\operatorname{tr}U\pm\operatorname{tr}V)$ with $\operatorname{tr}V'=\operatorname{tr}V$ and $\operatorname{tr}U\pm\operatorname{tr}V=2\operatorname{tr}X_{0,1}=0$. Symmetric: $U$ and $V'$ symmetric.
- Norm: item 1's norm is $\lvert X\rvert^2+\sum\lvert X_a\rvert^2+N_0(t,K)$, and `hsq` is `sq_pair` twice with $\lvert V'\rvert=\lvert V\rvert$.
- Ricci-flat: `ricciFlat_iff` asks for the $J$-row, supplied by `ricciJ_inverse` and `N_shift` at traceless $X'_a$, and for $\operatorname{tr}M_a+\sum_bK_{ab}=0$, which depends on $M'_a$ only through $\operatorname{tr}M'_a=3t_a=\operatorname{tr}M_a$. Correct.
- Every block diagonal in $F$: $X'_{0,1}$ by `diagIn_add`/`diagIn_sub` of $U$ and `inFrame F ν`, the rest by `hrest`, then $S'$ and $M'_a$ by the closure lemmas and `diagIn_one`. `L57_block_conj_of` at `m + 2` closes, and `hnorm` transfers.
- Falsifier: a Ricci-flat block operator with symmetric traceless $X_a$, $X_0+X_1$ and $X_{c\ge2}$ diagonal in one orthonormal $F$, and $P>c\lVert W\rVert^3$ for a $c$ every diagonal weight obeys.

## (4) Constants

- `L228_item4` is $\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$ at $n=(m+2)+3$ through `diag_bound` with `1 ≤ m + 2`. Valid at every $n\ge5$ and docstring-labelled the record's $\Theta_n$ at even $n$ only. Correct.
- `L228_item4_odd` is $\sqrt{\texttt{thetaOddSq}\,n}$ under `¬ Even (m + 2 + 3)` through `diag_bound_odd` with `2 ≤ m + 2`, the record's odd $\Theta_n$ at odd $n\ge5$. Correct.
- Falsifier: an operator in the class at odd $n\ge5$ with $P>\Theta_n^{\rm odd}\lVert W\rVert^3$, which would also falsify `L57_diagonal_odd` through `wOf`.

## (5) The INDEX row

- The item 4 sentence names `L228_item4_of` "at the blocks $a=0$, $b=1$ of `Fin (m + 2)`", lists `L228_item4` with $\theta_0(n)$ and `L228_item4_odd` with the odd $\Theta_n$, and describes `E_split`, `align_lin`, `le_perm_general` and $W'$ as typed. Nothing untyped is claimed as typed.
- **Observation 1.** Items 2 and 3 in the same row state that the relabelling from $a=0$ to an arbitrary block is prose. The item 4 sentence gives the typed scope ($a=0$, $b=1$) and leaves the relabelling to arbitrary distinct $a,b$ unsaid. One clause, "the relabelling to arbitrary distinct $a,b$ is prose", would match the other items.
- **Observation 2.** The row writes $L=\sum_c(\beta_{ac}-\beta_{bc})X_c$ without the range $c\notin\{a,b\}$ that the record and the Lean sum (over `i.succ.succ`) carry.
- **Observation 3.** The row writes `Fin (m + 2)` in a sentence that otherwise uses the record's $m$, so the reader meets two meanings of $m$. The record's $m$ is Lean's `m + 2`.
- Item 4's statement concerns $W\in\mathcal S_J\cap\mathcal W_n$, and the typed class is the Ricci-flat `blockOp` normal form, as for item 3. The identification is L226's and `blockOp_normal_form`'s (r1747), outside this scope.
