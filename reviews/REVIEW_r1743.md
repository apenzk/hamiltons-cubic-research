# REVIEW r1743: L228 item 1 at the operator ([L228Item1.lean](../lean/HamiltonsCubic/Results/L228Item1.lean)) and the r1742 follow-ups in [L217Op.lean](../lean/HamiltonsCubic/Results/L217Op.lean)

**Verdict: CONFIRMED WITH OBSERVATIONS.** `L228_item1` is the record's item 1 of [Lemma L228](../findings/second-order.md), stated on a superset of the record's domain (Ricci-flat on $J$, the outer Ricci condition dropped), with $P_0$, $N_0$ and $\beta$ exactly the record's. Every $3\times3$ identity checks by hand, the Gram cancellation and $\beta_{ab}$ come out as the record says, and the proofs are sound as read. The L217Op edits close r1742 O1 and O3 (O2 is closed in the INDEX row). The observations are a stale **Lean.** paragraph in the record, a duplicate of an existing L226Mixed lemma, and an uncomposed Ricci-flat corollary.

Method: read the working tree (file uncommitted), derived every identity from the definitions of `blockP`, `cubicJ`, `cubicX` and `normSq_blockOp`. No `lake build`. Screens, reported as screens only: the file carries no `sorry`, `axiom` or `native_decide` token, and its `.olean` (01:05:51) postdates the source (01:04:24). An exact rational evaluation of `blockP` against the right-hand side of `L228_item1_poly` and of the norm identity at $m=1,3,4$ with random symmetric traceless $X_a$, random $t$ and symmetric $K$ gave difference $0$ in both.

## (1) Is `L228_item1` the record's item 1?

- **Setting.** The record writes $S=N-\tfrac12(\operatorname{tr}N)I$ with $M_a=t_aI+X_a$, so $\operatorname{tr}N=3\mu$ and $S=X-\tfrac12\mu I$ (its proof says so: "$S=X-cI$ since $\operatorname{tr}N=3\mu$", $c=\tfrac12\mu$). Lean's `S` argument is `∑ a, Xs a - ((∑ a, t a) / 2) • 1` and `M = fun a => t a • 1 + Xs a`. Identical. Inside the proofs Lean's `c` is $-\tfrac12\mu$ and $S=X+cI$, a sign convention only.
- **The norm.** `normSq_blockOp` gives $\lVert W\rVert^2=(S S)^{\mathrm{tr}}+\sum_a(M_aM_a)^{\mathrm{tr}}+\sum_{a<b}K_{ab}^2$, which at symmetric blocks is L226's Setting norm $\lvert R_J\rvert^2+\sum\lvert M_a\rvert^2+\sum_{a<b}K_{ab}^2$ in the orthonormal frame $\varphi_{23},\varphi_{31},\varphi_{12}$. `L228_item1` writes $\lvert X\rvert^2$ as `((∑ Xs) * (∑ Xs)).trace` and $\lvert X_a\rvert^2$ as `(Xs a * Xs a).trace`, which equal the Frobenius squares because `hXs` makes every $X_a$, hence $X$, symmetric. This is the record's convention.
- **The cubic.** `cubicX` is $2\operatorname{tr}X^3+3\sum_c\operatorname{tr}(XX_c^2)+\sum_c\operatorname{tr}X_c^3$ with the product order $X X_c X_c$, cyclically the record's $\operatorname{tr}(XX_a^2)$. The Gram sum is over ordered pairs $a\ne b$ with `beta t K a b`, as in the record.
- **Domain.** The record's $W\in\mathcal S_J\cap\mathcal W_n$ has both Ricci conditions of L226 item 2. `L228_item1` imposes only the $J$ one (through the choice of $S$) and holds for every $t$, $K$. It is therefore the record's statement on a larger set, and stronger.
- Falsifier: symmetric traceless $X_a$, reals $t_a$, symmetric zero-diagonal $K$ with $P(\texttt{blockOp}(X-\tfrac12\mu I,\,t_aI+X_a,\,K))$ or its `normSq` different from the right-hand side.

## (2) $P_0$, $N_0$ and $\beta$

- `P0 t K` $=6c^3+\sum_a(3t_a^3+9ct_a^2)+\sum_{a<b}(K_{ab}^3+9K_{ab}t_at_b)+3\sum_{a<b<c}K_{ab}K_{ac}K_{bc}$ with $c=-\tfrac12\mu$, and `N0 t K` $=3c^2+3\sum_at_a^2+\sum_{a<b}K_{ab}^2$. Both are functions of `t` and `K` alone by their signatures, so "depending on the scalars only" is typed by construction.
- They match the record's proof: $6c^3=-\tfrac34\mu^3$, $9ct_a^2=-\tfrac92\mu t_a^2$, $\lvert S\rvert^2=\lvert X\rvert^2+\tfrac34\mu^2$ and $\lvert M_a\rvert^2=3t_a^2+\lvert X_a\rvert^2$.
- `beta t K a b` $=\tfrac32(K_{ab}-t_a-t_b-\tfrac12\mu)$ is the record's $\beta_{ab}$ verbatim.
- Falsifier: a pair $(t,K)$ at which $P-\text{(the }X\text{-terms)}$ varies with $X$, that is, a residual $X$-dependence the definitions omit. The screen found none.

## (3) `S_of_ricci` and `N_shift`

- **`S_of_ricci` is sound.** From `Ric_blockOp_J`, $\operatorname{Ric}_{pq}=0$ at every $p,q\in J$ is $(\operatorname{tr}S)I-S+N=0$. Its trace gives $3\operatorname{tr}S-\operatorname{tr}S+\operatorname{tr}N=0$, so $\operatorname{tr}S=-\tfrac12\operatorname{tr}N$, and then $S=(\operatorname{tr}S)I+N=N-\tfrac12(\operatorname{tr}N)I$. The Lean steps (entrywise `ext`, the trace with `trace_one` over `Fin 3`, the rearrangement `sub_add_eq_add_sub`, `sub_eq_zero`) follow this line.
- **`N_shift` is correct.** $\sum_a(t_aI+X_a)=\mu I+X$, trace $3\mu$, and $\mu I+X-\tfrac32\mu I=X-\tfrac12\mu I$.
- **The outer Ricci condition** $\operatorname{tr}M_a+\sum_{b\ne a}K_{ab}=0$ reads $3t_a+\sum_bK_{ab}=0$. It fixes $t$ as a linear function of $K$, so on $\mathcal S_J\cap\mathcal W_n$ the scalars $P_0$, $N_0$ become functions of $K$ alone, and at $m=1$ it forces $t_1=0$, which is what gives the record's Gate 1 (d) value $P_0=N_0=0$. Item 1 does not need it: the identity is polynomial in free $(t,K)$. The Lean at $m=1$ correctly has $P_0=-\tfrac94t_1^3\ne0$ at $t_1\ne0$, a point outside $\mathcal W_n$.
- Falsifier for `S_of_ricci`: a symmetric $S$ and symmetric $M_a$ with every $J$-row Ricci entry zero and $S\ne N-\tfrac12(\operatorname{tr}N)I$.

## (4) Hypotheses of `L228_item1`

| hypothesis | record | used |
|---|---|---|
| `hX : tr (Xs a) = 0` | $\operatorname{tr}X_a=0$ | yes, every shift identity |
| `hXs : (Xs a).IsSymm` | blocks are symmetric operators on $V_a$ | yes, gives `hSs`, `hMs` for L226's two bridges |
| `hK : K a b = K b a` | $K_{ab}$ indexed by the pair $\varphi_{ab}$ | yes, bridges and `sum_ne_eq_two_lt` in `E4` |
| `hK0 : K a a = 0` | no diagonal in the record, a `blockOp` convention | yes, the bridges |

- None vacuous: $X_a=0$, $t=0$, $K=0$ satisfies them all.
- `L228_item1_norm_poly` takes no symmetry of `K` and needs none, and `L228_item1_poly` takes no symmetry of the blocks and needs none. Both are general, and neither generality is claimed as more than it is.

## (5) Hand checks

- **`trace_adj_shift`.** For $3\times3$ $M$, $\operatorname{adj}M=M^2-(\operatorname{tr}M)M+e_2(M)I$. At $M=tI+A$, $\operatorname{tr}A=0$: $\operatorname{tr}M=3t$, $M^2=t^2I+2tA+A^2$, $e_2=\tfrac12(9t^2-3t^2-\operatorname{tr}A^2)=3t^2-\tfrac12\operatorname{tr}A^2$, so $\operatorname{adj}M=A^2-tA+(t^2-\tfrac12\operatorname{tr}A^2)I$, the record's formula. Then $\operatorname{tr}((B+cI)\operatorname{adj}M)=\operatorname{tr}(BA^2)-t\operatorname{tr}(BA)+c(\operatorname{tr}A^2+3t^2-\tfrac32\operatorname{tr}A^2)$ using $\operatorname{tr}B=\operatorname{tr}A=0$, which is the Lean statement.
- **`cubicJ_shift`.** $\operatorname{tr}(A+cI)^3=\operatorname{tr}A^3+3c\operatorname{tr}A^2+3c^3$ and $\det(A+cI)=\det A-\tfrac12c\operatorname{tr}A^2+c^3$ with $\det A=\tfrac13\operatorname{tr}A^3$ (Cayley–Hamilton at trace zero), so the sum is $2\operatorname{tr}A^3+\tfrac32c\operatorname{tr}A^2+6c^3$. At $c=-\tfrac12\mu$ it is the record's $2\operatorname{tr}X^3-\tfrac34\mu\lvert X\rvert^2-\tfrac34\mu^3$.
- `cube_shift`, `trace_mul_shift`, `sq_shift` are the binomial expansions at trace zero, correct.
- **The $\lvert X_a\rvert^2$ cancellation.** With $\lvert X\rvert^2=\sum_{a,b}\operatorname{tr}(X_aX_b)$ the diagonal coefficient is $\tfrac32c$ (from `cubicJ_shift`) $+3t_a$ (from `cube_shift`) $-3t_a$ (from $-3t_a\operatorname{tr}(XX_a)$) $-\tfrac32c$ (from $3c\cdot(-\tfrac12\lvert X_a\rvert^2)$) $=0$.
- **The cross coefficient.** Over an ordered pair $a\ne b$: $\tfrac32c$ from $\lvert X\rvert^2$, $-\tfrac32(t_a+t_b)$ from symmetrising $-3t_a\operatorname{tr}(X_aX_b)$ over the two orders, and $\tfrac32K_{ab}$ from $3K_{ab}\operatorname{tr}(X_aX_b)$ over $a<b$ halved onto ordered pairs. Total $\tfrac32(K_{ab}-t_a-t_b-\tfrac12\mu)=\beta_{ab}$. This is exactly the split of `E3` (the $K$ part and the $c-t_a-t_b$ part), `E4` (the halving, via `sum_ne_eq_two_lt` and `hK`) and `E5` (the diagonal removed by `hne`, the $t_b$ half moved by `hswap`).
- `sum_ne_eq_two_lt` is sound: trichotomy splits `a ≠ b` into `a < b` or `b < a`, and `sum_comm` with the symmetry maps the second to the first.

## (6) The INDEX row

- The new L228 row text claims `L228_item1` with its hypotheses written out, including $S=X-\tfrac12\mu I$ as given, and `S_of_ricci`, `N_shift` as the step from Ricci-flatness on $J$. That is what is typed.
- The owed list drops "a bridge from `cubicX` to L226's `blockP`, so item 1 in full", which this file discharges. What remains (item 2's Gram and norm expansions, item 4, the rotation to a coordinate-diagonal tensor, L57) matches the record's own list less item 1.
- The status stays **partial**, which is right.

## (7) The L217Op follow-ups against r1742

- **r1742 O1 closed.** `hγ0` is removed from both signatures and derived as `have hγ0 : 0 ≤ γ := by linarith` from `hs0 : 0 ≤ s` and `hs : s ≤ 3 * γ`. Sound. The call in `L217_op_eq` drops the argument accordingly.
- **r1742 O3 closed.** The header now says `L217_op`'s $W^\ast$ "value bounds $P$ on the unit Weyl sphere", and reserves "maximises $P$ there" for `L217_op_eq`, where $u$ Weyl makes $W^\ast$ a unit Weyl operator. Exact.
- **r1742 O2** is closed in the L217 INDEX row, whose owed list now names "the $O(n)$-equivariance carrying criticality and the gap from $u$ to $u'$".

## Observations

- **O1 (record stale).** The **Lean.** paragraph of Lemma L228 in [second-order.md](../findings/second-order.md) still reads "`cubicX` is item 1's cubic part by definition, with no bridge to L226's `blockP`. Item 1's reduction of L226's item 3 … outside the file." After this file it should name [L228Item1.lean](../lean/HamiltonsCubic/Results/L228Item1.lean) and move item 1 out of the owed list. The same downstream sweep applies to the record's header sentence listing what is kernel-checked.
- **O2 (duplicate).** `S_of_ricci` restates what [L226Mixed.lean](../lean/HamiltonsCubic/Results/L226Mixed.lean)'s `ricciJ_inverse` with `Ric_blockOp_J` already give (and `Pcubic_ricciFlat` states at a fully Ricci-flat operator, with the coefficient written `(1 / 2 : ℝ) * tr N`). Harmless. Citing or reusing it would keep one statement of the fact.
- **O3 (composition left to the reader).** No theorem takes an arbitrary `S` with `Ric (blockOp S (t I + X) K)` zero on the $J$ rows and concludes item 1 for it. `L228_item1` fixes $S$ syntactically and the docstring cites `S_of_ricci` and `N_shift` for the step. The corollary is two rewrites. Typing it would make the record's hypothesis "$W\in\mathcal S_J\cap\mathcal W_n$" the literal hypothesis.

## Summary table

| question | answer |
|---|---|
| (1) `L228_item1` is item 1 | yes, on the $J$-Ricci-flat superset, norm is L226's trace norm at symmetric blocks |
| (2) $P_0$, $N_0$ scalar only, $\beta$ | yes by signature, formulas match the record's proof |
| (3) `S_of_ricci`, `N_shift` | sound, and outer Ricci ties $t$ to $K$, item 1 does not need it |
| (4) hypotheses | the record's, all used, none vacuous |
| (5) hand checks | `trace_adj_shift`, `cubicJ_shift`, diagonal cancellation, $\beta_{ab}$ all check |
| (6) INDEX row | claims only what is typed, owed list right |
| L217Op | r1742 O1, O3 closed in the file, O2 in the row |
| observations | O1 record's Lean paragraph stale, O2 `S_of_ricci` duplicates `ricciJ_inverse`, O3 Ricci-flat corollary uncomposed |
