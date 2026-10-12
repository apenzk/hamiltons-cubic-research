# Verifier v251, Lemma L94: the frame-wise bound $t_F\le2\lVert M\rVert_F^2$, its equality case, the $\kappa$ form and its equality clause, and the Lean statement

*The brief ([BRIEF_L94.md](BRIEF_L94.md)) was read cold. No numerical work was done: every value below is exact and derived by hand, no scripts were written, and no Lean build was run (the Lean chain was read link by link as mathematics). Log: [agent_logs/verify-L94-v251.log](../agent_logs/verify-L94-v251.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | Per-frame bound $t_F\le2\lVert M\rVert_F^2$ (Passage B, (3)), at every $n$ and without normalisation | CONFIRMED |
| 2 | Per-frame equality: $t_F=2\lVert M\rVert_F^2$ iff $W$ coordinate-diagonal in $F$ | CONFIRMED |
| 3 | The $\kappa$ form $\kappa^2\le2\lVert M\rVert_F^2$ (Passage A) | CONFIRMED |
| 4 | $W$ coordinate-diagonal in some frame $\Rightarrow\kappa^2=2\lVert M\rVert_F^2$ | CONFIRMED |
| 5 | $\kappa^2=2\lVert M\rVert_F^2\Rightarrow W$ coordinate-diagonal in some frame | HYPOTHESIS-DEBT |
| 6 | $\kappa$ is $O(n)$-invariant (review paragraph as Passage C's docstring quotes it, outside the heading and consumed by neither clause) | HYPOTHESIS-DEBT |
| 7 | Lean `kappa_sq_le_and_equality` and `kappaSq_le` (Passage C) are correct as mathematics, using only the two pair antisymmetries | CONFIRMED |
| 8 | Passage C is Passage A's claim | GAP |

Summary: the bound and the per-frame equality case are proved on file and correct in full generality. The one open link is that $\max_F t_F$ is attained, which the "$\Rightarrow$" direction of the equality clause needs and which no quoted passage argues and the Lean file (by its own disclosure) does not type.

## 0. Conventions, fixed once

- $W$ is a $4$-tensor on $\mathbb R^n$ with $W_{abcd}=-W_{bacd}=-W_{abdc}$, $W_{abcd}=W_{cdab}$, first Bianchi, and $\sum_aW_{abad}=0$ (Weyl).
- $\Lambda^2$ carries the inner product in which $\{e_a\wedge e_b\}_{a<b}$ is orthonormal for every orthonormal frame, and $M_{(ab),(cd)}=\pm W_{abcd}$ in that basis (one global sign, irrelevant to every square below). This is the identification Passage B's first link $t_F=2\sum_{a<b}M_{(ab),(ab)}^2$ writes, and the one Passage C's `normM2` encodes.
- $\lVert M\rVert_F^2=\sum_{a<b}\sum_{c<d}W_{abcd}^2$. $\lvert W\rvert^2=\sum_{a,b,c,d}W_{abcd}^2$ is the $4$-tensor norm. With the antisymmetries, $\lvert W\rvert^2=4\lVert M\rVert_F^2$ (each term with $a\ne b$, $c\ne d$ lies in exactly one of the four order classes, and terms with $a=b$ or $c=d$ vanish).
- A frame $F$ is an orthonormal basis $(e_a)$, equivalently $R\in O(n)$ with rows $e_a$. $W^F_{abcd}=\sum R_{ai}R_{bj}R_{ck}R_{dl}W_{ijkl}$. $K(F)_{ab}=W^F_{abab}$, hollow since $W^F_{aaaa}=0$.
- $t_F=\lVert K(F)\rVert_F^2=\sum_{a\ne b}K_{ab}^2$. $\kappa(W)=\max_F\lVert K(F)\rVert_F$, so $\kappa^2=\max_Ft_F$.
- $W$ is coordinate-diagonal in $F$ when $W^F_{abcd}=0$ unless $\{a,b\}=\{c,d\}$, equivalently $M$ is diagonal in the pair basis of $F$.

Quotations were checked at source: [findings/bispectral.md](../findings/bispectral.md) lines 217, 480, 484 and 493 were displayed alone and match Passages A and B (the only difference is Passage B's anchor link, relative in the source and prefixed with the file path in the brief). Passage C matches [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) byte for byte except one trailing blank line (the file has 469 lines, the brief says 470). Lean line numbers below are the file's.

## Hypothesis inventory

| Hypothesis | Where stated | Checked against the object | Used by |
|---|---|---|---|
| $W_{abcd}=-W_{bacd}$, $W_{abcd}=-W_{abdc}$ | $W\in\mathrm{Weyl}_n$ (A, B), and `antisym12`, `antisym34` (C) | holds for Weyl | $K$ hollow, $K_{ba}=K_{ab}$ (via $W_{baba}=-W_{abba}=W_{abab}$), $\lvert W\rvert^2=4\lVert M\rVert_F^2$ in C's invariance route, and coordinate-diagonal as a $4$-tensor condition |
| Pair symmetry | Weyl (A, B), and `pairSym` (C) | holds | not used by the bound or the equality. It makes $M$ self-adjoint, which no link consumes |
| First Bianchi | Weyl, and `bianchi` (C) | holds | not used |
| Tracelessness | Weyl, and `traceless` (C) | holds | not used (grep of the Lean file: `pairSym`, `bianchi`, `traceless` occur only in the structure and the zero-tensor example) |
| $n\ge4$ | Passage B | on $\mathrm{Weyl}_n$ nontrivial only there | not used by any link of (3) |
| $\lVert M\rVert_F=1$ | Passage B | normalisation | used only in the last link "$=2$", the chain before it being homogeneous of degree $2$ |
| $F$ orthonormal | all | $R\in O(n)$ | pair basis of $F$ orthonormal in $\Lambda^2$, so $\lVert M\rVert_F$ is the same in every frame |
| Convention $M_{(ab),(cd)}=\pm W_{abcd}$, $e_a\wedge e_b$ of unit norm | used, stated only through Passage B's first equality and C's `normM2` | see withdrawn candidate W1 | the constant $2$ |
| $\max_F t_F$ is attained | presupposed by "$\max$" in the definition of $\kappa$ and by B's "the maximum of this over frames" | no argument on file | claim 5 only |

Imported facts: none beyond linear algebra. The Frobenius norm of an operator is independent of the orthonormal basis ($\lVert M\rVert_F^2=\operatorname{tr}M^{\mathsf T}M$), which is what makes $\lVert M\rVert_F$ in the definition well defined, and which Passage C proves for its coordinate `normM2` (row 7).

## 1. Per-frame bound

Passage B, (3), line 493: "$t_F=2\sum_{a<b}M_{(ab),(ab)}^2\le2\lVert M\rVert_F^2=2$".

Link by link, in the frame $F$:
- $t_F=\sum_{a\ne b}(W^F_{abab})^2=2\sum_{a<b}(W^F_{abab})^2$, because $W^F_{baba}=W^F_{abab}$ by the two antisymmetries. With $M_{(ab),(ab)}=\pm W^F_{abab}$ this is the first equality.
- $\sum_{a<b}M_{(ab),(ab)}^2\le\sum_{(ab),(cd)}M_{(ab),(cd)}^2=\lVert M\rVert_F^2$: the diagonal squares are a subfamily of nonnegative terms.
- $\lVert M\rVert_F^2$ computed in the pair basis of $F$ equals the frame-free $\lVert M\rVert_F^2$, since that basis is orthonormal.
- "$=2$" is the normalisation. Without it the chain ends at $2\lVert M\rVert_F^2$, which is Passage A's right-hand side.

No link uses $n\ge4$, pair symmetry, Bianchi, tracelessness, or the normalisation before the last equality. No finding: the bound holds as written for every $n$ and every $W$ with the pair antisymmetries.

## 2. Per-frame equality

Passage B, line 493: "with equality exactly when every off-diagonal entry of $M$ in the pair basis of $F$ vanishes, which is $W$ coordinate-diagonal in $F$".

$2\lVert M\rVert_F^2-t_F=2\sum_{(ab)\ne(cd)}M_{(ab),(cd)}^2$, a sum of squares, zero iff every off-diagonal entry vanishes. That is the definition of coordinate-diagonal in $F$ (as an operator statement). As a $4$-tensor statement, $W^F_{abcd}$ with $a<b$, $c<d$, $(a,b)\ne(c,d)$ zero gives every $W^F_{abcd}$ with $\{a,b\}\ne\{c,d\}$ zero by the antisymmetries. No finding.

Non-vacuity of the equality case at $n=4$ (a screen, closed form): $W_{abcd}=K_{ab}(\delta_{ac}\delta_{bd}-\delta_{ad}\delta_{bc})$ with $K$ symmetric hollow. The Bianchi sum collects to $\delta_{ac}\delta_{bd}(K_{ab}-K_{ad})+\delta_{ad}\delta_{bc}(K_{ac}-K_{ab})+\delta_{ab}\delta_{cd}(K_{ad}-K_{ac})$, each bracket zero on its support. $\sum_aW_{abad}=\delta_{bd}\sum_aK_{ab}$. Take $K_{12}=K_{13}=K_{24}=K_{34}=1$, $K_{14}=K_{23}=-2$: row sums $0$, so $W\in\mathrm{Weyl}_4\setminus\{0\}$. $M=\operatorname{diag}(1,1,-2,-2,1,1)$, $\lVert M\rVert_F^2=12$, $t_F=24=2\cdot12$.

## 3. The $\kappa$ form of the bound

Passage B, line 493: "Lemma L94 is the maximum of this over frames." Since $t_F\le2\lVert M\rVert_F^2$ for every $F$ and the right side is frame-free, every value of $F\mapsto t_F$ is at most $2\lVert M\rVert_F^2$, hence so is the maximum (and so would be the supremum). Attainment is not needed for this direction. No finding.

## 4. Coordinate-diagonal in some frame implies equality

If $W$ is coordinate-diagonal in $F_0$ then $t_{F_0}=2\lVert M\rVert_F^2$ by section 2, so $\kappa^2\ge t_{F_0}=2\lVert M\rVert_F^2$, and section 3 gives equality. This needs only that $\kappa^2$ dominates each $t_F$, true of a supremum. The quoted text writes it as "the maximum of this over frames" together with (3). No finding.

## 5. Equality implies coordinate-diagonal in some frame

The chain needed: $\kappa^2=2\lVert M\rVert_F^2$, so some frame $F^\ast$ has $t_{F^\ast}=\kappa^2$, so $t_{F^\ast}=2\lVert M\rVert_F^2$, so (section 2) $W$ is coordinate-diagonal in $F^\ast$. The middle link is attainment of $\max_Ft_F$.

**Candidate H1 (recorded).**
1. Location: Passage A, line 217, "equality exactly when $W$ is coordinate-diagonal in some frame", with $\kappa=\max_F\lVert K(F)\rVert_F$ (Definitions) and Passage B, line 493, "*Lemma L94 is the maximum of this over frames.*" No quoted line argues that the maximum exists. The block under Passage A's heading writes no proof (brief's location facts). Passage C, lines 46 to 48, states that attainment "is not needed here and is not typed".
2. Concrete failure: the step fails exactly for an object $W$ with $\sup_Ft_F=2\lVert M\rVert_F^2$ and $t_F<2\lVert M\rVert_F^2$ at every frame. No such object is exhibited, and I exhibit none. The finding is the absence of an argument, which the rules classify as debt and not as refutation.
3. Charitable reading: "$\max$" in the definition asserts attainment, and under that reading the chain above is complete. The assertion is still a claim with no argument on file. What would have to be proved: *the function $O(n)\to\mathbb R$, $R\mapsto t_{F(R)}$, attains its supremum*. The standard route is that $O(n)$ is a closed bounded subset of $\mathbb R^{n\times n}$ and $t$ is a polynomial in the entries of $R$. It is written nowhere quoted.

Verdict HYPOTHESIS-DEBT, naming that attainment statement. The claim is not refuted.

## 6. $O(n)$-invariance of $\kappa$

Source: the review paragraph as quoted in Passage C's docstring (file lines 10 to 14), "$\kappa(W):=\max_F\lVert K(F)\rVert_F$ over orthonormal frames is $O(n)$-invariant". I could not check this quotation against the findings file because the lines around line 217 are closed to me. It is outside Passage A's heading and neither the bound nor the equality consumes it.

**Candidate H2 (recorded).**
1. Location: the quoted phrase "is $O(n)$-invariant".
2. Concrete failure: none exhibited. No argument is on file in any quoted passage.
3. Charitable reading: the property follows once one shows that $g\cdot$ permutes the frames and $K_{g\cdot W}(F)=K_W(g^{-1}F)$. That argument is what would have to be proved, and it is not written.

Verdict HYPOTHESIS-DEBT, peripheral to L94's heading.

## 7. Passage C as mathematics

Read by hand, not built. Each link:
- `IsFrame` (line 75): rows orthonormal. `cols_of_rows` (129): $RR^{\mathsf T}=I\Rightarrow R^{\mathsf T}R=I$ for square $R$. `norm_preserved` (140): $\sum_a(\sum_iR_{ai}x_i)^2=\sum_{i,j}(\sum_aR_{ai}R_{aj})x_ix_j=\sum_ix_i^2$. Correct.
- `rot1`..`rot4`, `rotate_eq` (210): nesting the four one-slot actions gives $\sum R_{ai}R_{bj}R_{ck}R_{dl}W_{ijkl}$. `full4_rot1`..`4`: each slot acts on the vector in that slot with the other three fixed, so `norm_preserved` applies. `full4_rotate`: $\lvert W^F\rvert^2=\lvert W\rvert^2$. Correct.
- `rotate_antisym12/34` (223, 231): renaming $i\leftrightarrow j$ (resp. $k\leftrightarrow l$). Correct.
- `normM2_quarter` (241): $X_{abcd}^2$ splits into the four order indicators, the degenerate cases being zero, and each indicator sum equals `normM2` by renaming and $(-x)^2=x^2$. So $4\,\mathrm{normM2}=\mathrm{full4}$. Correct.
- `frobK_eq` (283): $X_{aaaa}=0$, $X_{baba}=X_{abab}$, so $\mathrm{frobK}=2\sum_{a<b}X_{abab}^2$. `diag_le_normM2` (304): the $(c,d)=(a,b)$ term of a nonnegative sum. `frame_bound` (323): $\mathrm{frobK}\le2\,\mathrm{normM2}(W^F)=2\,\mathrm{normM2}(W)$ by the two quarter identities and `full4_rotate`. Correct.
- `normM2_split` (334): diagonal plus off-diagonal indicator sums. `coordDiag_of_offDiag_zero` (365): nine order cases. I checked each case's witness for $\neg(c=a\wedge d=b)$: in the $(b<a,\,c<d)$ case it is $a=d\wedge b=c$ from $d=a$, $c=b$, and in the $(b<a,\,d<c)$ case it is $a=c\wedge b=d$. Correct.
- `equality_iff` (381). ($\Rightarrow$) Equality forces the off-diagonal sum to be $0$, a sum of nonnegative terms, so each vanishes. ($\Leftarrow$) Coordinate-diagonal kills every off-diagonal term, the case $a=d$, $b=c$ being excluded by $a<b=c<d=a$. Correct.
- `kappaSq` (98) is `sSup` of the frame values. `kappaSq_le_of_forall` (118) is `csSup_le` with the identity frame as the nonempty witness. The set is bounded above by `frame_bound`, so the junk value of `sSup` on an unbounded set does not arise, and `kappaSq_le` (450) needs no boundedness anyway.
- Hypothesis use: `kappa_sq_le_and_equality` (443) passes `hW.toIsAlgCurv`, and the only fields read are `antisym12` and `antisym34` (lines 229, 237, 328, 386).

Verdict CONFIRMED as mathematics. The kernel check and `#print axioms` output (line 469) were not run by me.

## 8. Passage C against Passage A

| Item | Passage A | Passage C | Match |
|---|---|---|---|
| $\lVert K\rVert_F^2$ | $\sum_{a\ne b}K_{ab}^2$ | `frobK`, all ordered $(a,b)$ including $a=b$ | yes, the $a=b$ terms are $0$ |
| $\lVert M\rVert_F^2$ | operator on $\Lambda^2$ | `normM2`, $a<b$ and $c<d$, standard frame | yes, frame-independence proved (`key`, line 384) |
| $\kappa^2$ | $\max_Ft_F$ | `kappaSq`, a supremum | same value where the max exists. Attainment untyped |
| Bound | $\kappa^2\le2\lVert M\rVert_F^2$ | per frame (443) and `kappaSq_le` (450) | yes |
| Equality | $\kappa^2=2\lVert M\rVert_F^2\iff\exists F$ coordinate-diagonal | $(\exists R,\ \mathrm{frobK}\,R\,W=2\,\mathrm{normM2}\,W)\iff\exists R$ coordinate-diagonal | **no** |
| Hypotheses | $W\in\mathrm{Weyl}_n$ | `IsWeyl W`, any $n$ | C's hypotheses are Passage A's. No $n\ge4$ and no normalisation, so nothing is excluded |

**Candidate L1 (recorded).**
1. Location: line 445, `((∃ R, IsFrame R ∧ frobK R W = 2 * normM2 W) ↔ ∃ R, IsFrame R ∧ CoordinateDiagonal (rotate R W))`, against Passage A's "equality exactly when". No theorem in the file mentions `kappaSq` in an equality.
2. Concrete failure: the typed left side is "some frame attains $2\lVert M\rVert_F^2$". Passage A's left side is "`kappaSq W = 2 * normM2 W`". Getting from the second to the first is exactly the attainment of section 5, and getting from the first to the second needs `le_csSup` with the bound as `BddAbove`. Neither implication is typed, so the file proves neither direction of Passage A's equality clause in the $\kappa$ form.
3. Charitable reading: the docstring (lines 46 to 48) and the theorem's docstring (lines 436 to 442) disclose the existential form and that attainment is untyped. The ($\Leftarrow$) direction in $\kappa$ form is a two-line consequence of what is typed. The disclosure is accurate, but the formal object is still weaker than Passage A in the ($\Rightarrow$) direction by exactly the debt of section 5.

Verdict GAP between the typed statement and the stated one, disclosed in the file. It coincides with row 5.

### Withdrawn candidates

- **W1, the $\Lambda^2$ convention.** (1) Passage B's first link, "$t_F=2\sum_{a<b}M_{(ab),(ab)}^2$". (2) Suppose the operator is normalised as $\hat M=2M$ (the curvature operator acting on $2$-forms with a full double sum over $k,l$). Then $\lVert\hat M\rVert_F^2=4\lVert M\rVert_F^2$ and the true bound reads $t_F\le\tfrac12\lVert\hat M\rVert_F^2$, so the constant $2$ would be wrong. (3) Charitable reading: the record fixes $M_{(ab),(cd)}=\pm W_{abcd}$ with $e_a\wedge e_b$ orthonormal, both through Passage B's own first equality and through `normM2`. The brief's Definitions use the same pair basis. Under the record's convention no line is false. *Withdrawn: fails step 3.*
- **W2, Passage B's scope ($n\ge4$, $\lVert M\rVert_F=1$) against Passage A's generality.** (1) Line 480, "$n\ge4$" and "$\lVert M\rVert_F=1$". (2) An unnormalised or $n<4$ instance where the written proof would not apply: none exists, because no link of (3) before the final "$=2$" uses either hypothesis. (3) The chain as written proves the general statement. *Withdrawn: fails step 2.*
- **W3, `kappaSq` as `sSup` taking a junk value.** (1) Line 98. (2) Lean's `sSup` returns $0$ on sets not bounded above, but the frame set of values is bounded by `frame_bound` and nonempty by `isFrame_id`. (3) `kappaSq_le` is sound regardless. *Withdrawn: fails step 2.*
- **W4, `CoordinateDiagonal` admitting $W_{aaaa}\ne0$ or $W_{aacc}\ne0$.** (1) Line 94, where $a=b=c=d$ satisfies the exempt disjunction. (2) Those components are $0$ for every tensor with `antisym12`, which every rotated `IsWeyl` tensor has. (3) The definition coincides with operator-diagonality on antisymmetric tensors. *Withdrawn: fails step 2.*

## Standing items

1. **Hypothesis inventory.** See the table above. Used: the two pair antisymmetries, orthonormality of $F$, the $\Lambda^2$ convention, and (claim 5 only) attainment. Unused: pair symmetry, Bianchi, tracelessness, $n\ge4$, normalisation. Used but unstated: attainment (H1) and the convention (W1, withdrawn).
2. **Quantifier order and scope.** The bound and its equality are per frame (sections 1 and 2). The maximum is taken over $O(n)$ in the $\kappa$ form. Its attainment is needed only for claim 5 and is argued nowhere quoted (H1). Lean quantifies per frame and existentially and never takes a maximum (L1).
3. **Range edges.** $n=2$: an algebraic curvature tensor is fixed by $k=W_{1212}$, and $\sum_aW_{a1a1}=k$, so Weyl forces $k=0$. $n=3$: with $x_1=W_{2323}$, $x_2=W_{1313}$, $x_3=W_{1212}$, $y=W_{1213}$, $z=W_{1223}$, $w=W_{1323}$, the Ricci contraction is $\mathrm{Ric}_{11}=x_2+x_3$, $\mathrm{Ric}_{22}=x_1+x_3$, $\mathrm{Ric}_{33}=x_1+x_2$, $\mathrm{Ric}_{12}=w$, $\mathrm{Ric}_{13}=-z$, $\mathrm{Ric}_{23}=y$, so Weyl forces $W=0$. $W=0$: $\kappa=0=2\lVert M\rVert_F^2$, coordinate-diagonal in every frame, and the claim holds in both directions. $n=4$: section 2's witness gives a nonzero coordinate-diagonal Weyl tensor at equality. $\ker W\ne0$: no link reads the rank of $M$. A closed-form instance at $n=4$ is section 2's construction with $K_{12}=K_{34}=1$, $K_{13}=K_{24}=-1$, $K_{14}=K_{23}=0$ (row sums $0$). Then $M=\operatorname{diag}(1,-1,0,0,-1,1)$ has a $2$-dimensional kernel, $\lVert M\rVert_F^2=4$ and $t_F=8$, so equality holds. No finding. Lean at $n=2,3$ holds for all tensors with the antisymmetries, which is more than Passage A asks. At $n=0,1$ both sides of every clause are $0$ or vacuous.
4. **Proven against stated.** Proven: rows 1 to 4 on file. Stated but unargued: attainment (row 5) and $O(n)$-invariance (row 6). Lean proves rows 1, 2 and 3, and the existential form of the equality (row 8).
5. **Lean statement.** Binders are `W`, `hW : IsWeyl W` and `n` implicit, with nothing excluded. The norms `frobK` and `normM2` match (section 8). The equality clause is existential, not in the $\kappa$ form (L1). Hypotheses used are only `antisym12` and `antisym34`.
6. **The brief's attack items.**
   1. No proof is written under Passage A's heading. Passage B, in another lemma's block, supplies the per-frame bound and its equality case correctly. The passage to the $\kappa$ form is the single sentence "the maximum of this over frames". That sentence suffices for rows 3 and 4 and leaves attainment unargued for row 5.
   2. Attainment is argued nowhere quoted, and the Lean file declines to type it (H1). $O(n)$-invariance is argued nowhere quoted (H2). The direction that needs an attaining frame is exactly $\kappa^2=2\lVert M\rVert_F^2\Rightarrow$ coordinate-diagonal.
   3. With $\lVert M\rVert_F$ and ordered-pair $t_F$ the bound is $t_F\le2\lVert M\rVert_F^2$. With unordered pairs, $t'_F=\sum_{a<b}K_{ab}^2=t_F/2\le\lVert M\rVert_F^2$, with the same equality case. With the $4$-tensor norm, $\kappa^2\le\tfrac12\lvert W\rvert^2$ is sharp, and $\kappa^2\le2\lvert W\rvert^2$ is true but attained only at $W=0$, a factor $4$ slack, consistent with the quoted warning.
   4. See section 8: `frobK` includes $a=b$ harmlessly, `normM2` is correct, `kappaSq` is a supremum and appears only in the bound, the equality clause is existential (GAP L1), and only the antisymmetries are used.
   5. Neither $n\ge4$ nor $\lVert M\rVert_F=1$ is needed (W2).
   6. $n=2,3$: $\mathrm{Weyl}_n=0$, derived in item 3. $W=0$ satisfies both clauses. $n=4$ has a nonzero equality witness.
7. **Falsifiers.** Row 1: a frame with $t_F>2\lVert M\rVert_F^2$. None can exist, since $2\lVert M\rVert_F^2-t_F$ is a sum of squares. Row 2: an equality frame with a nonzero off-diagonal entry, excluded by the same identity. Rows 3 and 4 inherit these. Row 5: $W$ with $\sup_Ft_F=2\lVert M\rVert_F^2$ approached only along a sequence of frames. I looked for an argument on file excluding it and found none, so the finding is debt. Row 6: $g\in O(n)$ with $\kappa(g\cdot W)\ne\kappa(W)$. None was exhibited, and no argument is on file. Row 7: a false link in the Lean chain. Each was read and none found. Row 8: the typed left side differs from Passage A's, as exhibited in L1.

## Overall verdict

**HYPOTHESIS-DEBT.** The bound $\kappa^2\le2\lVert M\rVert_F^2$ and the direction "coordinate-diagonal in some frame $\Rightarrow$ equality" are proved on file, in full generality and with only the pair antisymmetries. The direction "$\kappa^2=2\lVert M\rVert_F^2\Rightarrow$ coordinate-diagonal in some frame" rests on the attainment of $\max_Ft_F$ over $O(n)$, which no quoted passage argues and the Lean statement does not type. That attainment statement is what would have to be proved. The $O(n)$-invariance in the review paragraph is a second, peripheral unargued claim.
