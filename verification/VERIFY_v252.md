# Verifier v252, L94: the frame-wise bound $t_F\le2\lVert M\rVert_F^2$, its equality case, the $\kappa$ form with its equality clause, and the Lean statement

*Cold brief ([BRIEF_L94.md](BRIEF_L94.md)). No numerical work: every value below is exact, no script was written and no computation was run, the Lean file included (read by hand, not built). Log: [agent_logs/verify-L94-v252.log](../agent_logs/verify-L94-v252.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | Per-frame bound $t_F\le2\lVert M\rVert_F^2$ (Passage B (3), read without its normalisation) | CONFIRMED |
| 2 | Per-frame equality: $t_F=2\lVert M\rVert_F^2$ iff $W$ coordinate-diagonal in $F$ | CONFIRMED |
| 3 | $\kappa$ form of the bound, $\kappa^2\le2\lVert M\rVert_F^2$ (Passage A) | CONFIRMED |
| 4a | Passage A equality, direction "coordinate-diagonal in some frame $\Rightarrow\kappa^2=2\lVert M\rVert_F^2$" | CONFIRMED |
| 4b | Passage A equality, direction "$\kappa^2=2\lVert M\rVert_F^2\Rightarrow$ coordinate-diagonal in some frame" | HYPOTHESIS-DEBT |
| 5 | $\kappa$ is $O(n)$-invariant (the review paragraph quoted in Passage C's docstring) | HYPOTHESIS-DEBT |
| 6a | Lean: kappa_sq_le_and_equality's bound clause and kappaSq_le are Passage A's bound | CONFIRMED |
| 6b | Lean: the equality clause is Passage A's equality clause | GAP |

**Summary.** Every written link checks, and the chain uses only the two antisymmetries of $W$. The one unwritten step is that $F\mapsto t_F$ attains its supremum over orthonormal frames, on which the direction 4b rests, and which the Lean file declines to type, as its docstring says.

## 0. Conventions, fixed once

- $W$ is a $4$-tensor on $\mathbb R^n$ with $W_{abcd}=-W_{bacd}=-W_{abdc}$, pair symmetry, first Bianchi, Ricci-traceless (Weyl). A frame $F=(e_1,\dots,e_n)$ is an orthonormal basis, and $W_{abcd}$ means $W(e_a,e_b,e_c,e_d)$ in $F$.
- $M$ is the operator on $\Lambda^2$ with $\langle M(e_a\wedge e_b),e_c\wedge e_d\rangle=W_{abcd}$ for $a<b$, $c<d$, in the orthonormal pair basis $\{e_a\wedge e_b\}_{a<b}$. This is the brief's "one term per ordered pair of basis $2$-forms", so $\lVert M\rVert_F^2=\sum_{a<b,\,c<d}W_{abcd}^2$. A sign convention $M=-W$ changes no square and so nothing below.
- $K(F)_{ab}=W_{abab}$, $t_F=\sum_{a\ne b}K_{ab}^2=\lVert K(F)\rVert_F^2$ (the diagonal $K_{aa}=W_{aaaa}=0$). $\kappa(W)=\max_F\lVert K(F)\rVert_F$, so $\kappa^2=\max_Ft_F$ where the maximum exists.
- Coordinate-diagonal in $F$: $M_{(ab),(cd)}=0$ whenever $a<b$, $c<d$, $(a,b)\ne(c,d)$.
- $D_F:=\sum_{a<b}M_{(ab),(ab)}^2$, $O_F:=\sum_{a<b,\,c<d,\,(a,b)\ne(c,d)}M_{(ab),(cd)}^2$, so $\lVert M\rVert_F^2=D_F+O_F$.

**Quotation check.** Lines 217, 480, 484 and 493 of [findings/bispectral.md](../findings/bispectral.md) were displayed alone and match Passages A and B, with one cosmetic difference: line 493's link reads `(#lemma-l94-...)` at source and `(../findings/bispectral.md#lemma-l94-...)` in the brief, the same target. [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) is identical to Passage C (469 lines at source, the brief's block carries one extra blank line before its closing fence). The location facts of Passage A (the block under the heading writes no proof, [results.md](../results.md) has no canonical entry) were taken from the brief, since the block is off limits. A grep of results.md finds one mention of L94, inside a non-heading paragraph at line 1082, consistent with the second fact.

## 1. Hypothesis inventory

| Hypothesis | Where stated | Checked against the object | Used by the proof on file |
|---|---|---|---|
| $W_{abcd}=-W_{bacd}$, $W_{abcd}=-W_{abdc}$ | Weyl$_n$ (Passage B), IsAlgCurv.antisym12/34 (Passage C) | holds for Weyl tensors | yes: $K$ symmetric, $K_{aa}=0$, $M$ well defined on $\Lambda^2$, Lean's normM2_quarter and rotate_antisym |
| Pair symmetry $W_{abcd}=W_{cdab}$ | Weyl$_n$, IsAlgCurv.pairSym | holds | no (Lean's hsym derives $W_{baba}=W_{abab}$ from the two antisymmetries) |
| First Bianchi | Weyl$_n$, IsAlgCurv.bianchi (cyclic in the last three slots, the standard form) | holds | no |
| Ricci-traceless | Weyl$_n$, IsWeyl.traceless ($\sum_aW_{abad}=0$) | holds | no |
| $n\ge4$ | Passage B's statement | Passage A carries none | no link of (3) uses it |
| $\lVert M\rVert_F=1$ | Passage B's statement | Passage A is unnormalised | only in the closing "$=2$" of (3) |
| $\{e_a\wedge e_b\}_{a<b}$ orthonormal in $\Lambda^2$ and $\lVert M\rVert_F$ basis-free | implicit in Passage B's "$\le2\lVert M\rVert_F^2$" read at every frame | standard for the induced inner product | yes, for the passage to the $\kappa$ form, and Lean proves it as key/full4_rotate |
| Entries of $M$ in the pair basis equal $\pm W_{abcd}$ with coefficient $1$ | implicit in "$t_F=2\sum_{a<b}M_{(ab),(ab)}^2$", explicit in the brief's definition and Lean's normM2 | consistent with the brief's definition | yes |
| $\max_Ft_F$ exists | the definition $\kappa=\max_F$ | no argument on file | yes, in direction 4b |
| Weyl$_n=0$ for $n=2,3$ | brief item 6 (parenthetical) | imported, not read at source | no: the chain holds for every $W$, so Passage A at $n=2,3$ needs no case split |

Used but unstated: the attainment of the maximum (row 9). The two implicit conventions of rows 7 and 8 are fixed by the brief's Definitions, so they are stated there.

## 2. Claims 1 and 2, the per-frame bound and its equality case

**The written chain** (line 493): "$t_F=2\sum_{a<b}M_{(ab),(ab)}^2\le2\lVert M\rVert_F^2=2$, with equality exactly when every off-diagonal entry of $M$ in the pair basis of $F$ vanishes, which is $W$ coordinate-diagonal in $F$."

Link by link:

1. $t_F=2D_F$. $K_{ba}=W_{baba}=-W_{abba}=W_{abab}=K_{ab}$ by the two antisymmetries, and $K_{aa}=0$ by either. So $\sum_{a\ne b}K_{ab}^2=2\sum_{a<b}K_{ab}^2$, and $K_{ab}=W_{abab}=M_{(ab),(ab)}$ for $a<b$. Checks.
2. $2D_F\le2\lVert M\rVert_F^2$, since $\lVert M\rVert_F^2=D_F+O_F$ with $O_F\ge0$ a sum of real squares. Checks. The Frobenius norm is computed in the pair basis of $F$, which is orthonormal, so this is the basis-free $\lVert M\rVert_F$.
3. "$=2$" uses $\lVert M\rVert_F=1$ and nothing else. Links 1 and 2 use neither $\lVert M\rVert_F=1$ nor $n\ge4$, so the chain as written delivers $t_F\le2\lVert M\rVert_F^2$ for every doubly antisymmetric $W$ at every $n$.
4. Equality. Link 1 is an identity, so $t_F=2\lVert M\rVert_F^2$ iff $O_F=0$ iff every $M_{(ab),(cd)}$ with $(a,b)\ne(c,d)$ vanishes, which is the definition of coordinate-diagonal in $F$. Checks in both directions.

The equality case is non-vacuous at $n=4$. The Weyl tensor of the product of unit spheres $S^2\times S^2$ in a product frame has, by the Kulkarni–Nomizu decomposition with $\mathrm{Ric}=g$, $\mathrm{scal}=4$, the sectional values $W_{abab}=R_{abab}-\tfrac12(R_{aa}+R_{bb})+\tfrac{\mathrm{scal}}6$, that is $K_{12}=K_{34}=\tfrac23$ and $K_{13}=K_{14}=K_{23}=K_{24}=-\tfrac13$, and it is coordinate-diagonal because $R$, $\mathrm{Ric}\owedge g$ and $g\owedge g$ all are in that frame. Then $\lVert M\rVert_F^2=\tfrac49+\tfrac49+4\cdot\tfrac19=\tfrac43$ and $t_F=2\cdot\tfrac43$. This is a screen of the edge, not evidence for the claim.

**Verdicts: claim 1 CONFIRMED, claim 2 CONFIRMED.**

## 3. Claim 3, the $\kappa$ form of the bound

The passage on file is the sentence closing line 493: "Lemma L94 is the maximum of this over frames." The right side $2\lVert M\rVert_F^2$ is frame-independent (link 2 above), so a bound holding at every frame bounds $\max_Ft_F$, and equally $\sup_Ft_F$ if the maximum were not known to exist. **CONFIRMED.** Lean's kappaSq_le_of_forall types exactly this step with csSup_le over the nonempty frame set (isFrame_id), and it needs no BddAbove hypothesis.

## 4. Claim 4, the equality clause of Passage A

**4a.** If $W$ is coordinate-diagonal in $F_0$, then $t_{F_0}=2\lVert M\rVert_F^2$ by claim 2, so $\kappa^2\ge t_{F_0}=2\lVert M\rVert_F^2\ge\kappa^2$ by claim 3. The chain "is the maximum of this over frames" carries this. **CONFIRMED.**

**4b.** Candidate HYPOTHESIS-DEBT, three-step record.

1. *Location.* Passage A: "with equality exactly when $W$ is coordinate-diagonal in some frame". The only argument on file is line 493's "Lemma L94 is the maximum of this over frames", and the brief's Definitions give "$\kappa(W)=\max_F\lVert K(F)\rVert_F$". No quoted passage argues that the maximum exists.
2. *The failure of the written chain, concretely.* From $\kappa^2=2\lVert M\rVert_F^2$ the per-frame equality case yields a coordinate-diagonal frame only through a frame $F^*$ with $t_{F^*}=\kappa^2$. The inference $\sup_{x\in X}f(x)=s\Rightarrow\exists x,\,f(x)=s$ is false without a property of $(X,f)$: $X=[0,\infty)$, $f(x)=1-e^{-x}$ has supremum $1$ and no point with $f=1$. So the step needs a property of the frame set and of $F\mapsto t_F$, and no quoted passage names one.
3. *The charitable reading.* The record writes $\max$, which asserts that a maximiser exists, and under that assertion 4b follows at once from claim 2 at the maximiser. This relocates the obligation into the definition of $\kappa$ without discharging it: the assertion itself has no argument on file. The candidate survives.

**What would have to be proved:** that $F\mapsto t_F=\lVert K(F)\rVert_F^2$ attains its supremum on the set of orthonormal frames of $\mathbb R^n$. **Verdict 4b: HYPOTHESIS-DEBT.** The debt is narrow: once it is paid, 4b is claim 2 read at the maximiser.

## 5. Claim 5, $O(n)$-invariance of $\kappa$

The review paragraph quoted in Passage C's docstring (lines 31 to 35 of the Lean file) asserts that $\kappa$ "is $O(n)$-invariant". No quoted passage argues it, and Passage A's statement neither states nor uses it: the bound needs only the frame-independence of $\lVert M\rVert_F$, which Passage B's norm carries and Lean proves (key in equality_iff). **What would have to be proved:** $\kappa(g\cdot W)=\kappa(W)$ for $g\in O(n)$. **HYPOTHESIS-DEBT, outside Passage A and unused by it.**

## 6. Claim 6, Passage C against Passage A

The proofs were read by hand, lemma by lemma. The file was not built, so its compilation is not certified here.

**Definitions.**

- IsFrame R: rows orthonormal, so the rows are an orthonormal basis, and every orthonormal basis arises. rotate R W a b c d is $W(e_a,e_b,e_c,e_d)$ with $e_a$ the row $a$. Matches.
- frobK sums all ordered $(a,b)$, $a=b$ included. The $a=b$ terms are $W'_{aaaa}{}^2=0$ (hz in frobK_eq), so frobK is $t_F$. Matches.
- normM2 sums $W_{abcd}^2$ over $a<b$, $c<d$ in the ambient basis: the brief's $\lVert M\rVert_F^2$ with entry convention of row 8 of the inventory, computed in one frame. Its frame-independence is proved (key: normM2_quarter twice and full4_rotate). Matches.
- CoordinateDiagonal X quantifies over all index quadruples, zero unless $\{a,b\}$ and $\{c,d\}$ coincide as ordered or swapped pairs. For $X$ with the two antisymmetries this is equivalent to the brief's pair-basis definition: the Lean form restricts to the brief's on $a<b$, $c<d$, and coordDiag_of_offDiag_zero proves the converse. The equality clause applies it to rotate R W, the tensor read in $R$. Matches.
- kappaSq is sSup of $\{t_R\}$ rather than $\max\lVert K\rVert_F$ squared. Squaring is monotone on $[0,\infty)$, so where the record's max exists it equals kappaSq. The real sSup of an unbounded set is $0$ in Mathlib, but the set is bounded (frame_bound) and kappaSq_le uses only csSup_le. Matches for the bound.

**Proofs, link by link.**

- cols_of_rows: $RR^{\mathsf T}=1\Rightarrow R^{\mathsf T}R=1$ for square matrices. Correct.
- norm_preserved: $\sum_a(\sum_iR_{ai}x_i)^2=\sum_{i,j}(\sum_aR_{ai}R_{aj})x_ix_j=\sum_ix_i^2$. Correct.
- rotate_eq: rot1(rot2(rot3(rot4 W))) expands to $\sum_{i,j,k,l}R_{ai}R_{bj}R_{ck}R_{dl}W_{ijkl}$. Correct. full4_rot1 to full4_rot4 apply norm_preserved to one slot with the other three fixed. Correct, so full4_rotate is correct.
- normM2_quarter: for $a\ne b$, $c\ne d$ exactly one of the four sign-pattern indicators is $1$, and the three non-principal sums are carried to normM2 by swapping $a\leftrightarrow b$, $c\leftrightarrow d$, or both, with $(-x)^2=x^2$. So full4 $=4\,$normM2. Correct.
- frobK_eq: $t_F=2\sum_{a<b}W'^2_{abab}$, link 1 of §2. diag_le_normM2: the $(c,d)=(a,b)$ term of each inner double sum, by single_le_sum twice with non-negative terms. Correct. frame_bound combines five linear facts. Correct.
- normM2_split: normM2 $=D+O$, with hdiag collapsing the $c=a$, $d=b$ indicator sum to $[a<b]X_{abab}^2$. Correct.
- equality_iff, forward: $2\,$normM2 W $=t_R=2D$ and normM2 X $=$ normM2 W $=D+O$ give $O=0$, then each term vanishes by sum_eq_zero_iff_of_nonneg four times, then coordDiag_of_offDiag_zero. Backward: CoordinateDiagonal kills every term of $O$ (the swapped case $a=d$, $b=c$ is excluded by $a<b<\dots$, via hab.trans hcd), so $t_R=2D=2\,$normM2 X $=2\,$normM2 W. Correct.
- coordDiag_of_offDiag_zero: all nine trichotomy cases checked. In each strict case the non-equality handed to hoff is the correct component of hnot, with the swaps (Or.inl or Or.inr, .1 or .2, symm) as written. The equal cases vanish by antisymmetry. Correct.

**Hypotheses used.** Only IsAlgCurv.antisym12 and antisym34, as the docstring says. IsWeyl excludes nothing that Passage A covers, and the theorem holds for a wider class, which is harmless. No $n\ge4$ binder, so $n=0,1,2,3$ are included.

**6a.** The first conjunct of kappa_sq_le_and_equality is Passage A's per-frame bound with the unnormalised norm, and kappaSq_le is the $\kappa$ form. **CONFIRMED** (as read, subject to the build note below).

**6b.** Candidate GAP, three-step record.

1. *Location.* Lean lines 466 to 467: `(∃ R, IsFrame R ∧ frobK R W = 2 * normM2 W) ↔ ∃ R, IsFrame R ∧ CoordinateDiagonal (rotate R W)`, against Passage A's "$\kappa^2\le2\lVert M\rVert_F^2$, with equality exactly when $W$ is coordinate-diagonal in some frame".
2. *The difference, concretely.* Passage A's left side is kappaSq W $=2\,$normM2 W. Lean's is the existence of an attaining frame. No declaration in the file derives either from the other. The implication "kappaSq W $=2\,$normM2 W $\Rightarrow\exists$ attaining R" is exactly the attainment of §4 4b, and the converse needs le_csSup with the bound of frame_bound, which is untyped.
3. *The charitable reading.* The docstring (lines 67 to 69) states the choice openly: the equality clause is typed in the frame form and "the attainment of the record's max by compactness of the frame group is not needed here and is not typed". The disclosure is accurate, and the frame form is the mathematical content of claims 2 and 4a. But the theorem is still not Passage A's equality clause, and the missing piece is the same one the prose leaves unwritten. The candidate survives.

**Verdict 6b: GAP** (disclosed): the Lean equality clause is the frame-level statement, and Passage A's $\kappa$-level equality clause follows from it only with attainment and a le_csSup step, neither typed.

**Build and axiom record, a note without a verdict.** The file contains no `sorry` token (its one occurrence of the word is in the docstring at line 55). The axiom record [lean/axioms.json](../lean/axioms.json), last changed in commit 99fd304d on 2026-09-09, lists sorryAx for kappa_sq_le_and_equality and kappaSq_le, and the Lean file was last changed in ff2dd0f3 on 2026-09-14 ("its sorry discharged"). The record on file therefore predates the proof and does not certify it. Whether the file builds and prints axioms without sorryAx was not checked, since the brief forbids running computations.

## 7. The standing list

**Item 1, hypothesis inventory.** §1. Finding: the attainment of $\max_Ft_F$ is used and unstated (4b).

**Item 2, quantifier order and scope.** Passage B's (3) is per frame, and the maximum is taken once, over all orthonormal frames, of a frame-dependent left side against a frame-independent right side. The inequality is sound with sup or max. Where the maximum is taken it is not argued to be attained (4b). Lean's equality clause has the existential over frames on both sides, independently bound, which is the correct reading of "in some frame" on the right. No further finding.

**Item 3, the edge of every range.**

- $n=2,3$: the chain of §2 holds for every doubly antisymmetric $W$, so Passage A holds there whatever Weyl$_n$ is. If Weyl$_n=0$ (brief item 6, not read at source), both sides are $0=0$ and $W=0$ is coordinate-diagonal in every frame. No finding.
- $n=4$: equality attained by a nonzero $W$ (the $S^2\times S^2$ Weyl tensor, §2). No finding.
- $W=0$: $t_F=0=2\lVert M\rVert_F^2$ in every frame, and $W=0$ is coordinate-diagonal, so the clause holds, and attainment is trivial. Lean's closing examples inhabit both IsWeyl and CoordinateDiagonal at $0$. No finding.
- $\ker W\ne0$: no link uses invertibility. Screen of the strict case at $n=4$: $W=2\,\omega_1\otimes\omega_1-\omega_2\otimes\omega_2-\omega_3\otimes\omega_3$ with $\omega_1=(e_{12}+e_{34})/\sqrt2$, $\omega_2=(e_{13}+e_{42})/\sqrt2$, $\omega_3=(e_{14}+e_{23})/\sqrt2$, a traceless self-dual Weyl tensor with $\ker M\supseteq\Lambda^2_-$. In the standard frame $K_{12}=K_{34}=1$, the other four $K_{ab}=-\tfrac12$, so $t_F=2(1+1+4\cdot\tfrac14)=6$ and $\lVert M\rVert_F^2=4+1+1=6$, strict. It is coordinate-diagonal in no frame: if $M(e_a\wedge e_b)=\lambda e_a\wedge e_b$ then the left side lies in the non-killed half of $\Lambda^2$ while $e_a\wedge e_b$ has equal components in both, forcing $\lambda=0$ for all six pairs and $M=0$. Consistent with Passage A. No finding.

**Item 4, proven against stated or used.** Proven on file: claims 1, 2, 3, 4a. Stated and not proven: 4b (attainment). Passage B is stated under $n\ge4$, $\lVert M\rVert_F=1$ while Passage A drops both, and the gap is closed by the chain as written since no link but the final "$=2$" uses them. Stated in the quoted review paragraph and not argued: $O(n)$-invariance of $\kappa$ (claim 5), unused.

**Item 5, the Lean statement.** §6. Binders: $W$ with IsWeyl, $R$ with IsFrame, no $n$ restriction. Norms: frobK is $t_F$, normM2 is $\lVert M\rVert_F^2$ with the operator norm, not the $4$-tensor norm. Equality clause: frame form, GAP against Passage A (6b). No hypothesis excludes a case Passage A covers.

## 8. What to attack, numbered as in the brief

1. **Is a proof of Passage A written?** Under Passage A's heading none, by the brief's location fact. Passage B (3) supplies the per-frame bound and its equality case (§2, confirmed), and its sentence "is the maximum of this over frames" supplies the passage to the $\kappa$ bound and to 4a. It does not supply attainment, so 4b is HYPOTHESIS-DEBT.
2. **$\kappa$ as a maximum.** Attainment is argued in no quoted passage. The Lean docstring names compactness of the frame group as the reason and declines to type it. The direction $\kappa^2=2\lVert M\rVert_F^2\Rightarrow$ coordinate-diagonal needs it (§4). $O(n)$-invariance is asserted in the review paragraph and argued nowhere quoted (§5).
3. **The norm and the pair count.** With the $4$-tensor norm $\lvert W\rvert^2=\sum_{abcd}W_{abcd}^2=4\lVert M\rVert_F^2$ (Lean's normM2_quarter, from the two antisymmetries), the sharp bound reads $t_F\le\tfrac12\lvert W\rvert^2$, and "$t_F\le2\lvert W\rvert^2$" would be true and slack by the factor $4$, with equality only at $W=0$, as the record's warning says. With unordered pairs $t'_F=\sum_{a<b}K_{ab}^2=\tfrac12t_F$ the sharp bound is $t'_F\le\lVert M\rVert_F^2$, with the same equality case. Passage A's pairing, ordered $t_F$ against $\lVert M\rVert_F$, is consistent. No finding.
4. **Passage C against Passage A.** frobK including $a=b$: harmless, the terms vanish. normM2: the operator norm over ordered pairs of $2$-forms with $a<b$, $c<d$, frame-independent by proof. kappaSq as sSup: equals the max where it exists and suffices for the bound. Equality clause: frame form, GAP (6b). Hypotheses used: the two antisymmetries only.
5. **Passage B's scope.** Neither $n\ge4$ nor $\lVert M\rVert_F=1$ is used by any link of (3) except the closing "$=2$" (§2, link 3). No finding.
6. **The boundary.** §7 item 3. No finding.

## 9. Falsifiers named, and the search

| Claim | Object that would falsify it | What was done |
|---|---|---|
| 1 | A doubly antisymmetric $W$ and frame with $t_F>2\lVert M\rVert_F^2$ | The inequality is $O_F\ge0$, a sum of real squares, so none exists. Checked the identity $t_F=2D_F$ from the two antisymmetries |
| 2 | $W$ with $t_F=2\lVert M\rVert_F^2$ and a nonzero off-diagonal pair entry in $F$, or the converse | $O_F=0$ iff all off-diagonal entries vanish. Checked non-vacuity at $n=4$ with $S^2\times S^2$ |
| 3 | $W$ and a frame exceeding $2\lVert M\rVert_F^2$ | reduces to claim 1 plus frame-independence of $\lVert M\rVert_F$ |
| 4a | coordinate-diagonal $W$ with $\kappa^2<2\lVert M\rVert_F^2$ | reduces to claims 2 and 3 |
| 4b | $W$ with $\sup_Ft_F=2\lVert M\rVert_F^2$ and no attaining frame | none exhibited, and none is claimed: the finding is the missing argument, located in §4 |
| 5 | $W$, $g\in O(n)$ with $\kappa(g\cdot W)\ne\kappa(W)$ | none exhibited, and none is claimed: the finding is the missing argument |
| 6a | a Lean definition that differs from the record's object | frobK, normM2, IsFrame, rotate, CoordinateDiagonal, kappaSq each compared (§6) |
| 6b | a $W$ satisfying one side of Passage A's equality clause and not Lean's | the two differ by attainment only (§6), so a falsifier of the equivalence is a falsifier of attainment |
| edge | $n=2,3$, $n=4$, $W=0$, $\ker W\ne0$ | §7 item 3, exact screens only |

### 9.1 Withdrawn candidates

- **Entry-convention factor in $M$.** *Location:* line 493 "$t_F=2\sum_{a<b}M_{(ab),(ab)}^2$". *Exhibit:* under a convention $\langle M(e_a\wedge e_b),e_c\wedge e_d\rangle=\tfrac12W_{abcd}$ (arising from a $\Lambda^2$ inner product with $\lvert e_a\wedge e_b\rvert^2=2$) the identity would read $t_F=8D_F$ and the bound would be $8\lVert M\rVert_F^2$. *Charitable reading:* the brief's Definitions fix $\lVert M\rVert_F$ as the Frobenius norm in an orthonormal basis of $\Lambda^2$ with one term per ordered pair, and Lean's normM2 fixes the entries as $W_{abcd}$. Under the fixed convention the identity holds. **Withdrawn at step 3.**
- **$\kappa$ undefined when the max is not known to exist, spoiling the bound.** *Location:* Passage A "$\kappa^2\le2\lVert M\rVert_F^2$". *Exhibit:* none, since the bound holds for $\sup_Ft_F$ regardless. **Withdrawn at step 2.**
- **Lean forward direction depending on atom identification after `set`.** *Location:* Lean lines 413 to 419, where hk and hfrob mention rotate R W and hsplit mentions X, with only hfrob rewritten by `rw [← hX]`. *Exhibit:* a failure could only be shown by running the checker, which the brief forbids, so none can be exhibited in closed form. *Charitable reading:* X is a let-bound local definitionally equal to rotate R W, and commit ff2dd0f3 records the module as proved. **Withdrawn at step 2.** The build status remains uncertified here (§6 note).
- **Lean CoordinateDiagonal stronger than the pair-basis definition.** *Location:* Lean line 116, quantifying over all quadruples. *Exhibit:* for a tensor without antisymmetry the Lean form constrains entries the pair-basis form does not. *Charitable reading:* the clause is applied only to rotate R W with $W$ doubly antisymmetric, where the two are equivalent (coordDiag_of_offDiag_zero and its trivial converse). **Withdrawn at step 3.**
- **Quotation mismatch at line 493.** *Location:* the link target. *Exhibit:* `#lemma-l94-...` at source against `../findings/bispectral.md#lemma-l94-...` in the brief. *Charitable reading:* the same anchor, relativised for the brief's folder. **Withdrawn at step 3.**

## 10. Overall verdict

**HYPOTHESIS-DEBT.** The bound, per frame and in the $\kappa$ form, and the equality direction from a coordinate-diagonal frame are proven by the chain on file, which uses only the two antisymmetries. The direction $\kappa^2=2\lVert M\rVert_F^2\Rightarrow$ coordinate-diagonal in some frame rests on the attainment of $\max_Ft_F$ over orthonormal frames, argued in no quoted passage. The Lean theorem types the frame-level equality clause and says so, leaving the same step untyped.
