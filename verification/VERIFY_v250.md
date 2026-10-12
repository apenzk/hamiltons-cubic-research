# Verifier v250, L94: the frame-wise bound and its equality case, the κ form of both, and the Lean statement

*Brief read cold ([BRIEF_L94.md](BRIEF_L94.md)), no other round, ledger, review or verifier file opened. No numerical work: no scripts, no computations, every value below exact and written by hand. Log: [agent_logs/verify-L94-v250.log](../agent_logs/verify-L94-v250.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | Frame-wise bound $t_F\le2\lVert M\rVert_F^2$ (Passage B item 3, read for every $n$ and every $W$) | CONFIRMED |
| 2 | Frame-wise equality: $t_F=2\lVert M\rVert_F^2$ iff $W$ is coordinate-diagonal in $F$ | CONFIRMED |
| 3 | κ form of the bound, $\kappa^2\le2\lVert M\rVert_F^2$ | CONFIRMED |
| 4a | κ form of equality, direction "coordinate-diagonal in some frame $\Rightarrow\kappa^2=2\lVert M\rVert_F^2$" | CONFIRMED |
| 4b | κ form of equality, direction "$\kappa^2=2\lVert M\rVert_F^2\Rightarrow$ coordinate-diagonal in some frame" | HYPOTHESIS-DEBT |
| 5 | $\kappa=\max_F\lVert K(F)\rVert_F$ is attained (used by 4b) | HYPOTHESIS-DEBT |
| 6a | Lean: `kappa_sq_le_and_equality` part 1 and `kappaSq_le` are claims 1 and 3 | CONFIRMED |
| 6b | Lean: the equality clause of `kappa_sq_le_and_equality` is claim 2 in frame-existential form, and equals Passage A's clause only through claim 5 | CONFIRMED AS ALGEBRA |

**Summary: the frame-wise statement and the κ-form bound are proven on file and in Lean. The one open piece is that the maximum defining κ is attained, which 4b needs and no quoted passage argues.**

## 0. Conventions, fixed once

- $W$ has components $W_{abcd}$ in an orthonormal frame $F=(e_1,\dots,e_n)$. $M$ is the operator on $\Lambda^2$ with matrix $M_{(ab),(cd)}=\pm W_{abcd}$ ($a<b$, $c<d$) in the orthonormal pair basis $\{e_a\wedge e_b\}_{a<b}$. The sign is a convention and every quantity below is a square, so it plays no role. The scale factor is $1$: this is fixed by Passage B's own first equality $t_F=2\sum_{a<b}M_{(ab),(ab)}^2$ and by the factor-$4$ remark quoted in Passage C (see 7.1).
- $\lVert M\rVert_F^2=\sum_{a<b}\sum_{c<d}W_{abcd}^2$. The full $4$-tensor norm is $\lvert W\rvert^2=\sum_{a,b,c,d}W_{abcd}^2=4\lVert M\rVert_F^2$ under the two antisymmetries.
- $K(F)_{ab}=W_{abab}$, $t_F=\sum_{a\ne b}K_{ab}^2=\lVert K(F)\rVert_F^2$ (the diagonal $K_{aa}=W_{aaaa}=0$ contributes nothing).
- $D_F=\sum_{a<b}W_{abab}^2$ and $O_F=\sum_{a<b,\,c<d,\,(a,b)\ne(c,d)}W_{abcd}^2$, so $\lVert M\rVert_F^2=D_F+O_F$.
- Coordinate-diagonal in $F$: $O_F=0$ termwise, that is $W_{abcd}=0$ for $a<b$, $c<d$, $(a,b)\ne(c,d)$.
- Quotation check: [findings/bispectral.md](../findings/bispectral.md) lines 217, 480, 484, 493 match Passages A and B verbatim, except that the anchor `#lemma-l94-...` in line 493 appears in the brief as `../findings/bispectral.md#lemma-l94-...` (a path rewrite, same target). [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) is 469 lines and matches Passage C exactly, the brief's block carrying one extra trailing blank line (hence "470").

## Hypothesis inventory

| Hypothesis | Where stated | Checked against the object | Used by the proof |
|---|---|---|---|
| $W_{abcd}=-W_{bacd}$, $W_{abcd}=-W_{abdc}$ | $\mathrm{Weyl}_n$, Lean `IsAlgCurv` | holds for Weyl | yes: $K_{ba}=K_{ab}$ (factor 2), $W_{aacd}=0$, and in Lean the quarter identity |
| pair symmetry, first Bianchi | $\mathrm{Weyl}_n$, Lean `IsAlgCurv` | holds | no |
| tracelessness | $\mathrm{Weyl}_n$, Lean `IsWeyl.traceless` | holds | no |
| $n\ge4$ | Passage B statement | not in Passage A | no |
| $\lVert M\rVert_F=1$ | Passage B statement | not in Passage A | only in the last "$=2$" of B(3), removable by homogeneity of degree 2 on both sides |
| $F$ orthonormal | all passages, Lean `IsFrame` (rows orthonormal) | yes | yes: the pair basis of $F$ is orthonormal in $\Lambda^2$, so $\lVert M\rVert_F$ is computed in it |
| Frobenius norm of $M$ independent of the orthonormal basis | used silently in B(3), proved in Lean (`full4_rotate`, `normM2_quarter`) | standard, and machine-checked here | yes |
| scale factor $1$ between $M$ and $W$ | fixed by B(3)'s first equality | see 7.1 | yes |
| $\max_F t_F$ attained | inside the definition $\kappa=\max_F$ | no argument quoted | yes, by 4b only |

**Imported facts, read at source** (Mathlib under [lean/.lake/packages/mathlib](../lean/.lake/packages/mathlib)): `csSup_le (h₁ : s.Nonempty) (h₂ : ∀ b ∈ s, b ≤ a) : sSup s ≤ a` at Mathlib/Order/ConditionallyCompleteLattice/Basic.lean:201, which needs only nonemptiness and is supplied `isFrame_id`. `mul_eq_one_comm` at Mathlib/Algebra/Group/Defs.lean:373, used for square real matrices. `single_le_prod'` and `prod_eq_one_iff_of_one_le'` at Mathlib/Algebra/Order/BigOperators/Group/Finset.lean:225 and :193, the multiplicative forms whose additive duals `Finset.single_le_sum`, `Finset.sum_eq_zero_iff_of_nonneg` the proof calls, each with a nonnegativity hypothesis the proof discharges. The build artifact `L94Statement.olean` (02:27:35) is newer than the source (02:24:51) and the source contains no `sorry`, `admit` or `axiom` in code. The compiler was not rerun (no computations), and the Lean proof was read by hand as well.

## 1. Claim 1, the frame-wise bound

**Derivation, link by link (B(3)).**

1. $t_F=\sum_{a\ne b}W_{abab}^2$. By the two antisymmetries $W_{baba}=(-1)^2W_{abab}$, so the $(a,b)$ and $(b,a)$ terms agree and $t_F=2D_F$.
2. $D_F=\sum_{a<b}M_{(ab),(ab)}^2$ by §0. This is B's "$t_F=2\sum_{a<b}M_{(ab),(ab)}^2$".
3. $D_F\le D_F+O_F=\lVert M\rVert_F^2$ since $O_F\ge0$, the norm computed in the orthonormal pair basis of $F$ being the basis-free $\lVert M\rVert_F$.
4. Hence $t_F\le2\lVert M\rVert_F^2$, and B's "$=2$" is the normalisation.

Every link holds. Nothing beyond the two antisymmetries and orthonormality of $F$ is used, so the bound holds for every $n$ and every $W$ (normalised or not). **CONFIRMED.**

**Lean.** `frobK_eq` is link 1 (with $a=b$ included and killed by `hz`), `diag_le_normM2` is link 3 in the rotated coordinates, `normM2_quarter` with `full4_rotate` is basis independence, `frame_bound` combines them linearly. Read by hand, each step is correct.

## 2. Claim 2, the frame-wise equality case

$t_F=2\lVert M\rVert_F^2\iff O_F=0\iff$ each term of $O_F$ vanishes (a sum of real squares) $\iff$ every off-diagonal pair-basis entry of $M$ in $F$ vanishes, which is the definition of coordinate-diagonal in $F$. **CONFIRMED.**

**Screen, exact, hand-built.** $n=4$, $W$ coordinate-diagonal with $K_{12}=K_{34}=1$, $K_{13}=K_{24}=-1$, $K_{14}=K_{23}=0$. Row sums of $K$ are $0$, which is tracelessness for a coordinate-diagonal tensor ($W_{abad}=0$ for $b\ne d$, and $\sum_aK_{ab}=0$ for $b=d$). Bianchi holds because in each nonzero case exactly two terms are $\pm K$ with opposite signs. Then $\lVert M\rVert_F^2=4$, $t_F=8=2\cdot4$. Here $\ker M=\mathrm{span}\{e_1\wedge e_4,e_2\wedge e_3\}\ne0$, so equality is compatible with a kernel. Reported as a screen only.

## 3. Claim 3, the κ form of the bound

$\kappa^2=(\max_F\lVert K(F)\rVert_F)^2=\sup_Ft_F$ (squaring is monotone on $[0,\infty)$), and every $t_F\le2\lVert M\rVert_F^2$ with the right side frame-free. So $\kappa^2\le2\lVert M\rVert_F^2$. This needs no attainment: a supremum of quantities bounded by a constant is bounded by it. Passage B's sentence "L94 is the maximum of this over frames" names exactly this step. **CONFIRMED.**

Lean: `kappaSq` is `sSup` of $\{t_R\}$ over frames, `kappaSq_le_of_forall` applies `csSup_le` with nonemptiness from `isFrame_id`, and `kappaSq_le` is the κ-form bound. Correct as read.

## 4. Claim 4, the κ form of the equality case

**4a.** If $W$ is coordinate-diagonal in $F_0$, claim 2 gives $t_{F_0}=2\lVert M\rVert_F^2$, so $\kappa^2\ge t_{F_0}=2\lVert M\rVert_F^2\ge\kappa^2$ by claim 3. Uses only $\kappa^2\ge t_{F_0}$, true of a supremum. **CONFIRMED.**

**4b.** From $\kappa^2=2\lVert M\rVert_F^2$ one needs a frame $F_0$ with $t_{F_0}=2\lVert M\rVert_F^2$, then claim 2 applies. That frame exists exactly when the supremum is attained, which is claim 5. **HYPOTHESIS-DEBT**, inherited from claim 5 and nothing else.

## 5. Claim 5, attainment of the maximum

**Three-step record.**

1. *Location.* The definition "$\kappa(W):=\max_F\lVert K(F)\rVert_F$ over orthonormal frames" (quoted in Passage C lines 31–32) and B(3)'s "*Lemma L94 is the maximum of this over frames.*" Passage A's block, by the brief's location fact, "writes no proof". Passage C's docstring: "the attainment of the record's `max` by compactness of the frame group is not needed here and is not typed."
2. *Failure of the written chain, closed form.* The inference "$\sup_{x\in S}f(x)=c\Rightarrow\exists x\in S,\ f(x)=c$", which is what 4b performs, fails for $S=(0,1)$, $f(x)=x$, $c=1$. What makes it valid for L94 is a property of the frame set and of $F\mapsto t_F$, and no quoted passage states or proves one.
3. *Most charitable reading.* Writing "max" asserts attainment inside the definition, and a reader who grants the definition gets 4b at once. This does not discharge the debt: the definition's well-posedness is itself the unproved statement, and the Lean file explicitly declines to type it.

**What would have to be proved:** for each $W\in\mathrm{Weyl}_n$ there is an orthonormal frame $F_0$ with $t_{F_0}=\sup_Ft_F$. The Lean docstring names compactness of the frame group with continuity of $F\mapsto t_F$ as the intended route, and no argument is written. **HYPOTHESIS-DEBT.** The finding is narrow: the statement is standard and nothing in L94 depends on it except 4b.

## 6. Claim 6, the Lean statement against Passage A

- **Binders.** `{n : ℕ}` implicit and unrestricted (so $n=0,1,2,3$ are included, where the claims hold trivially). `W : Tensor4 n` real coordinates on the standard orthonormal basis. `R` ranges over all real $n\times n$ arrays with `IsFrame R` (rows orthonormal), which is all of $O(n)$, orientation-reversing frames included, matching "orthonormal frames".
- **Norms.** `frobK R W` sums all ordered $(a,b)$ including $a=b$, equal to $t_F$ because `rotate R W a a a a = 0` (`hz`). `normM2` sums $a<b$, $c<d$, which is $\lVert M\rVert_F^2$ at scale $1$ and *not* the $4$-tensor norm, as the record's warning demands (`normM2_quarter` records the factor $4$).
- **`CoordinateDiagonal`** requires $X_{abcd}=0$ whenever $\{a,b\}\ne\{c,d\}$ as ordered-or-swapped pairs, over all indices. For a tensor with both antisymmetries this is equivalent to the brief's pair-basis definition: the extra instances have $a=b$ or $c=d$ (zero by antisymmetry) or are sign-flips of pair-basis entries. `coordDiag_of_offDiag_zero` proves the direction needed, the reverse direction in `equality_iff` handles $(a=d\wedge b=c)$ with $a<b$, $c<d$ by the contradiction $a<b=c<d=a$. Correct as read.
- **Equality clause.** Typed as $(\exists R,\ t_R=2\lVert M\rVert_F^2)\iff(\exists R,\ W\text{ coordinate-diagonal in }R)$. Passage A states $\kappa^2=2\lVert M\rVert_F^2\iff(\exists F,\ \text{coordinate-diagonal})$. The left sides agree exactly when the supremum is attained (claim 5), so 6b is **CONFIRMED AS ALGEBRA**: it is claim 2 quantified existentially, and it is Passage A's clause modulo the untyped attainment, which the docstring discloses.
- **Hypotheses.** `IsWeyl` is inhabited (the zero tensor, and the $n=4$ screen of §2 is another), excludes nothing relevant, and the proof consumes only `antisym12`, `antisym34`, as the docstring says.
- **Bound.** Part 1 is claim 1 for every frame and `kappaSq_le` is claim 3. **6a CONFIRMED.**

## 7. The standing list, item by item

1. **Hypothesis inventory.** Table above. Used but unstated: attainment of the max (claims 4b, 5). The scale-1 convention is used and fixed by the record's own equalities (7.1, withdrawn).
2. **Quantifier order and scope.** Claims 1–2 are per frame, with the right side frame-free because $\lVert M\rVert_F$ is basis independent. Claim 3 quantifies over all frames through a supremum, attainment not needed. The maximum is taken in the definition of κ, and its attainment is used only in 4b and is unargued (claim 5).
3. **Edges.** $n=2$: an algebraic curvature tensor has the single component $W_{1212}$ and tracelessness gives $\sum_aW_{a1a1}=W_{2121}=0$, so $W=0$. $n=3$: $\mathrm{Weyl}_3=0$ (a standard fact, not needed since the argument is dimension-free). $W=0$: $t_F=0=2\lVert M\rVert_F^2$ at every frame and $W$ is coordinate-diagonal in every frame, so both sides of each equivalence are true. Passage B's $\lVert M\rVert_F=1$ excludes $W=0$, but its chain before "$=2$" is valid there. $n=4$: nothing changes, the §2 screen realises equality. $\ker W\ne0$: plays no role, and the §2 screen has $\dim\ker M=2$ with equality. No finding.
4. **Proven against stated or used.** Proven on file: claims 1, 2, 3, 4a (Passage B plus one-line passages to the sup). Stated but unargued: attainment, hence 4b. Lean proves 1, 2 (existential form), 3. No other gap found.
5. **Lean statement.** §6. No finding beyond 6b, which is disclosed.
6. **Brief's attack items.**
   1. Passage A's block writes no proof. Passage B supplies the per-frame bound and equality case in full (claims 1, 2) and a one-sentence passage to the κ form, which suffices for claim 3 and 4a and falls short for 4b by attainment. **Finding: claim 5 HYPOTHESIS-DEBT.**
   2. Attainment is not argued anywhere quoted (claim 5). $O(n)$-invariance of κ is asserted in the review sentence quoted by Passage C, is not part of Passage A's heading, is argued nowhere quoted, and is not typed in Lean, whose "Invariance" bullet concerns $\lVert M\rVert_F$ only. Since the heading does not claim it, no finding against L94 (7.2). The direction $\kappa^2=2\lVert M\rVert_F^2\Rightarrow$ coordinate-diagonal needs an attaining frame, and that is not argued (4b).
   3. With $\lVert M\rVert_F$ and ordered-pair $t_F$ the bound is $t_F\le2\lVert M\rVert_F^2$ and sharp (§2 screen). With the $4$-tensor norm it reads $\kappa^2\le\frac12\lvert W\rvert^2$, and writing $\kappa^2\le2\lvert W\rvert^2$ is true but slack by the factor $4$, never attained for $W\ne0$. With unordered pairs $t'_F=\sum_{a<b}K_{ab}^2=t_F/2$ it reads $t'_F\le\lVert M\rVert_F^2$ with the same equality case. If $\lVert M\rVert_F^2$ were replaced by the unordered-pair-of-2-forms sum $U_F=D_F+\frac12O_F$, then $t_F=2D_F\le2U_F$ still holds with the same equality case. No finding.
   4. §6: `frobK` includes $a=b$ harmlessly, `normM2` is the operator norm, `kappaSq` is a supremum (correct for the bound), the equality clause is existential (6b), only the two antisymmetries are used.
   5. Neither $n\ge4$ nor $\lVert M\rVert_F=1$ is needed (inventory table, claim 1). No finding.
   6. Boundary: item 3 above. No finding.
7. **Falsifiers named and searched for.**
   - Claim 1: a $W$ and frame with $D_F>\lVert M\rVert_F^2$, impossible since $O_F\ge0$ is a sum of squares. Looked for a hidden normalisation that breaks $t_F=2D_F$ (7.1, withdrawn).
   - Claim 2: a frame with $O_F=0$ but a nonzero off-diagonal pair entry, impossible for real squares. Checked the Lean's all-index `CoordinateDiagonal` against the pair-basis definition for tensors with $a=b$ or $c=d$ (§6).
   - Claims 3, 4a: a frame with $t_F>2\lVert M\rVert_F^2$, excluded by claim 1.
   - Claims 4b, 5: a $W$ whose $\sup_Ft_F$ equals $2\lVert M\rVert_F^2$ with no attaining frame. None exhibited, and I did not supply the argument excluding it, which is the debt.
   - Claim 6: an object that `IsWeyl` or `IsFrame` wrongly excludes or admits. `IsFrame` is exactly $O(n)$, `IsWeyl` is exactly $\mathrm{Weyl}_n$, both inhabited.

### 7.1 Withdrawn: the scale between $M$ and $W$ is unstated

1. *Location.* The brief's definition "$W\in\mathrm{Weyl}_n$ acts on $\Lambda^2\mathbb R^n$ as $M$" and B(3)'s "$t_F=2\sum_{a<b}M_{(ab),(ab)}^2$".
2. *Failure.* If $M_{(ab),(cd)}=\lambda W_{abcd}$ then $t_F=(2/\lambda^2)\sum_{a<b}M_{(ab),(ab)}^2$ and the bound reads $t_F\le(2/\lambda^2)\lVert M\rVert_F^2$. With $\lambda=\frac12$ it is $\kappa^2\le8\lVert M\rVert_F^2$.
3. *Charitable reading.* B(3)'s first equality holds only at $\lambda^2=1$, so the record fixes the scale there, and the factor-$4$ warning quoted in Passage C ($\lvert W\rvert^2=4\lVert M\rVert_F^2$) presupposes the same. `normM2` in Lean fixes it too. **Withdrawn**: a convention the record fixes, not a defect.

### 7.2 Withdrawn: $O(n)$-invariance of κ is claimed and not proved

1. *Location.* Passage C lines 31–32, quoting the record: "$\kappa(W):=\max_F\lVert K(F)\rVert_F$ over orthonormal frames is $O(n)$-invariant".
2. *Failure.* No quoted argument, and no Lean theorem mentions `kappaSq (rotate g W)`.
3. *Charitable reading.* The claim sits in a review sentence, not in L94's heading (Passage A), which is the statement under check. The Lean docstring's "Invariance" bullet is explicitly about `normM2`. **Withdrawn** as out of scope for L94, and noted for whoever owns that sentence.

## Overall verdict

**HYPOTHESIS-DEBT.** The frame-wise bound and equality case, the κ-form bound and the reverse direction of the κ-form equality are proven, on file and in Lean. The forward direction "$\kappa^2=2\lVert M\rVert_F^2\Rightarrow W$ coordinate-diagonal in some frame" rests on the maximum over frames being attained, which no quoted passage argues and the Lean file declines to type. Discharging that one statement would make the verdict PROVEN.
