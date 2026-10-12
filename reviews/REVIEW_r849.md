# REVIEW r849, the I36 projection-identity block: the restated step three is false, and the record's own witness refutes it

Reviewer `r849`, cold brief, Gate 2 on the three blockquotes at [diagonal-half.md:1108](../findings/diagonal-half.md#L1108), [diagonal-half.md:1110](../findings/diagonal-half.md#L1110) and [diagonal-half.md:1112](../findings/diagonal-half.md#L1112). I worked from the definitions in [conventions.md](../findings/conventions.md) and from the statement of [L180](../findings/diagonal-half.md#L895) as quoted in the brief, and I derived every value in closed form before looking at any figure the record carries. Numerical work was confined to screening claims I had already derived and am recording here, reported as screens in section 10. The standing analysis-only rule was inherited and observed: no search, no sweep, no census, no falsifier hunt.

The headline is that the block's own two-sentence sequence contradicts itself. Claim (C) says the projection identity forces the planes into a common frame. Claim (E), eight lines above, says the collapse works because the degenerate eigenspace lets other planes **be chosen**. The record's own $n=4$ witness, at the record's own derived Ricci-flat weight $(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$, satisfies the identity with six nonzero weights over six planes that admit no common frame. That is a closed-form counterexample to (C) as written, built entirely from material already on the record.

## CLAIM TABLE

| # | Claim | Verdict | Reason |
|---|---|---|---|
| 1 | (A) the algebra: $\omega\omega^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_P$ at a decomposable $\omega=u\wedge v$ | **CONFIRMED AS ALGEBRA** | true for exactly one normalisation, $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$, which is the record's own $\varphi_{ab}=E_{ba}-E_{ab}$, and the trace-$2$ clause of L180 is what pins it |
| 2 | (A) as a new specialisation of L180 | **GAP** | the same two sentences are the first paragraph of [L185](../findings/diagonal-half.md#L662)'s proof, and the identity is restated at [diagonal-half.md:788](../findings/diagonal-half.md#L788) and [INDEX-results.md:204](../findings/INDEX-results.md#L204) |
| 3 | (A)'s scope under zero eigenvalues | **CONFIRMED**, with the citation over-tight | L180(1)'s proof spends no nonvanishing at all, so (A) survives $\lambda_\alpha=0$ and padding, and the hypothesis is inherited without need |
| 4 | (A) read as an equivalence ("reads") | **CONFIRMED** | L180(1) is an iff and the substitution $\omega_\alpha^2=-\Pi_{P_\alpha}$ is an identity, so the two conditions are the same equation |
| 5 | (B) "an off-diagonal entry is a frame-mixing detector and nothing else" | **REFUTED** | it is the converse of what [diagOp_ric](../lean/HamiltonsCubic/Base/Families.lean) gives, and it fails at a one-plane exhibit whose planes lie in a common frame with a nonzero $(2,3)$ entry |
| 6 | (B) the value $\tfrac12\sin2t\,(\lambda_1-\lambda_2)$ at $(2,3)$, and its uniqueness among off-diagonal entries | **CONFIRMED** | derived in section 5, and it is the only nonzero off-diagonal entry at every $n$, which is more than the block claims |
| 7 | (C) the restated obligation, that the identity forces a common frame | **REFUTED** | the record's own witness at its own Ricci-flat weight satisfies the identity over six planes with no common frame |
| 8 | (C) as stronger than the refuted (D) | **REFUTED** | it is the same defect at a different address, both asserting a property of the GIVEN eigenbasis where the truth concerns the operator up to reselection inside degenerate eigenspaces |
| 9 | (C)'s step four, "free" | **REFUTED AS STATED** | at the collapse the eigenspace has dimension four and no "own plane", and the true content is a decomposition into $u\wedge V$ blocks that must be simultaneously frame-compatible |
| 10 | (D) the four-cycle refutation of the earlier step three | **CONFIRMED**, and strengthened | it is coordinate-diagonal, Ricci-flat at $(1,-1,1,-1)$, and the eigenvalues are $1$ and $0$, and an adjacent-edge pair at $1$ and $-1$ does the same job without touching L180's nonvanishing hypothesis |
| 11 | (E) the mixed-frame family is an orthonormal decomposable basis of $\Lambda^2\mathbb R^n$ | **CONFIRMED** | the count is $\binom n2$ and the cross terms vanish identically, derived in section 9 |
| 12 | (E) every Ricci-flat direction has $\mu_1=\mu_2$, offered as a screen | **CONFIRMED AS DERIVATION** | the $(2,3)$ entry alone gives it in two lines at every $n$, so the screen is replaceable and should be |
| 13 | (E) the Ricci-flat dimension, $8$ at $n=6$ against $1$ at $n=4$ | **CONFIRMED**, and generalised | the dimension is exactly $\binom n2-n-1$, which derives both recorded figures and $4$ at $n=5$ |
| 14 | (E) the collapse to a coordinate-diagonal point | **CONFIRMED at every $n$** | the rechosen basis is the full standard basis, and nothing else obstructs |
| 15 | the route's step two feeding step three | **GAP** | step two delivers decomposability at SIMPLE eigenvalues only, and the collapse mechanism lives at degenerate ones, so the hypothesis of step three is undelivered exactly where the route needs it |

## ONE-LINE ACTIONABLE SUMMARY

Delete (C) and replace it with the operator-level obligation, that the identity forces SOME orthonormal decomposable eigenbasis into a common frame, then move the load from step four to that repair and cite [L185](../findings/diagonal-half.md#L662) for (A).

## CONVENTIONS, QUOTED FROM THE BRIEF

- The inner product on $\Lambda^2$ is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $\varphi_{ab}=E_{ba}-E_{ab}$.
- "Diagonal" means diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame, and not diagonal as an operator on $\Lambda^2$.
- A $2$-form is decomposable iff $\omega\wedge\omega=0$ iff $\omega=u\wedge v$, and its support is the plane $\langle u,v\rangle$.
- **L180**, the statement as quoted: for $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$ a nonzero element of $\mathcal W_n$ in spectral form with the $\omega_i$ orthonormal and every $\lambda_i\ne0$, and with $A_i=-\omega_i^2=\omega_i\omega_i^{\mathsf T}$, Ricci-flatness is exactly $\sum_i\lambda_i\,\omega_i^2=0$ in $S^2(\mathbb R^n)$, equivalently $\sum_i\lambda_iA_i=0$ with every $A_i$ positive semidefinite of trace $2$. Its proof: the Ricci contraction is $\sum_bW_{abcb}=\sum_i\lambda_i\sum_b(\omega_i)_{ab}(\omega_i)_{cb}=(\sum_i\lambda_i\omega_i\omega_i^{\mathsf T})_{ac}$.
- **[diagOp_ric](../lean/HamiltonsCubic/Base/Families.lean)**: the Ricci contraction of a diagonal operator is the row sum, on the diagonal and nowhere else.
- **[L177](../findings/diagonal-half.md)**: the four-cycle is the minimal coordinate-diagonal support graph, weight $(1,-1,1,-1)$ on its four edges.
- Indices run from $e_1$, so the entry the block calls $(2,3)$ is the one in the row of $e_2$ and the column of $e_3$. I used that convention throughout, and it is the one under which the block's value is correct.
- **The route's four steps**, for context: (1) the test forces $\mathfrak b(P_\mu)=0$ at every eigenprojector, (2) at a simple $\mu$ that is decomposability of $\omega_\mu$, (3) is claim (C), (4) an eigenspace with equal eigenvalues is frame-independent inside its plane.

## HYPOTHESIS INVENTORY, CHECKED AGAINST THE OBJECTS

| Hypothesis | Where it comes from | The object it is checked against | Status |
|---|---|---|---|
| $W$ nonzero and in $\mathcal W_n$ in spectral form | L180 | the $n=4$ witness at $(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$: trace $4\cdot\tfrac12-2=0$, Ricci-flat by section 6, first Bianchi free on the all-decomposable set | **holds** |
| every $\lambda_i\ne0$ | L180 | the same witness has all six weights $\pm$ nonzero, so my counterexample to (C) satisfies L180's hypothesis in full | **holds** |
| the same, at the four-cycle | L180 | $\lambda_{13}=0$ there, so the pair the block names sits OUTSIDE L180's hypothesis | **fails for the named pair, repaired in section 8 by an adjacent-edge pair** |
| the $\omega_i$ orthonormal | L180 | verified for the $n=4$ witness and for the general mixed-frame family in section 9, cross terms included | **holds** |
| $u,v$ orthonormal in $\omega=u\wedge v$ | claim (A) | holds for every plane of the family, since each plane is spanned by two members of an orthonormal frame | **holds** |
| $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$, with no $1/\sqrt2$ | forced by $\varphi_{ab}=E_{ba}-E_{ab}$ in [conventions.md](../findings/conventions.md) | section 1: under any other scaling $\Pi_P$ acquires a factor and the trace-$2$ clause fails | **holds, and is load-bearing** |
| $w$ symmetric, hollow, zero row sums | [diagOp_ric](../lean/HamiltonsCubic/Base/Families.lean) and diagOp_isWeyl | the four-cycle: symmetric and hollow by construction, row sums $0$ by section 8 | **holds** |
| $\sin2t\ne0$ | the witness family | needed both for the $(2,3)$ entry to be a live constraint and for the no-common-frame count of section 7, which uses $\sin t\ne0$ AND $\cos t\ne0$ | **holds on the admissible set, and both halves are used** |
| $\mu$ simple | route step two | the collapse in (E) produces $\mu$ of multiplicity four at $n=4$, so step two says nothing there | **fails, which is item 15** |
| the eigenspace has an "own plane" | route step four | the $\tfrac12$-eigenspace of the collapsed witness is $e_1\wedge\langle e_2,e_3\rangle\oplus\langle e_2,e_3\rangle\wedge e_4$, of dimension four | **fails, which is section 9** |

## 1. (A)'s one-line specialisation, and the normalisation that makes it true

Fix the record's convention. $\varphi_{ab}=E_{ba}-E_{ab}$, so the wedge of two frame vectors carries no factor and $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$. Then for $u,v$ orthonormal, $\omega=vu^{\mathsf T}-uv^{\mathsf T}$ is skew and

$$\omega^2=(vu^{\mathsf T}-uv^{\mathsf T})(vu^{\mathsf T}-uv^{\mathsf T})=v(u^{\mathsf T}v)u^{\mathsf T}-v(u^{\mathsf T}u)v^{\mathsf T}-u(v^{\mathsf T}v)u^{\mathsf T}+u(v^{\mathsf T}u)v^{\mathsf T}=-vv^{\mathsf T}-uu^{\mathsf T},$$

using $u^{\mathsf T}v=0$ and $u^{\mathsf T}u=v^{\mathsf T}v=1$. Since $\omega^{\mathsf T}=-\omega$ this gives $\omega\omega^{\mathsf T}=-\omega^2=uu^{\mathsf T}+vv^{\mathsf T}$, which is the orthogonal projection onto $\langle u,v\rangle$ because $u,v$ are an orthonormal basis of that plane. So the algebra of (A) is right.

**The normalisation is the whole content, and the trace clause is the check.** Under this convention $\lVert\omega\rVert^2=\tfrac12\operatorname{tr}(\omega^{\mathsf T}\omega)=\tfrac12\cdot2=1$, so $\omega$ is a unit $2$-form and $\operatorname{tr}(\omega\omega^{\mathsf T})=2$, matching L180's trace-$2$ clause exactly. Under the competing convention $u\wedge v=\tfrac1{\sqrt2}(vu^{\mathsf T}-uv^{\mathsf T})$ the same computation returns $\omega\omega^{\mathsf T}=\tfrac12\Pi_P$ of trace $1$, and L180's clause fails, so the identity $\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0$ would be off by a global factor of two. That global factor is harmless for the vanishing statement, and it is fatal for any argument that reads absolute values off the diagonal, such as the row-sum reading in section 5. The block does not name the normalisation, and it should, because the record's convention is the one that works and a reader who imports the more common $1/\sqrt2$ wedge gets a projection multiple rather than a projection.

**Verdict: CONFIRMED AS ALGEBRA**, with the normalisation clause owed.

## 2. (A) is already on the record, at three sites

[L185](../findings/diagonal-half.md#L662)'s proof opens with the identical two sentences: *"Ricci-flatness of $W$ is $\sum\lambda_i\omega_i\omega_i^{\mathsf T}=0$ (L180(1)), and a unit decomposable $\omega_i$ is the area form of a plane $P_i$ with $\omega_i\omega_i^{\mathsf T}=\Pi_i$, the orthogonal projection. So Ricci-flatness reads $\sum\lambda_i\Pi_i=0$."* The same identity is restated at [diagonal-half.md:788](../findings/diagonal-half.md#L788) and in the ledger row at [INDEX-results.md:204](../findings/INDEX-results.md#L204), and the general projection fact is the part [L185Statement.lean](../lean/HamiltonsCubic/Results/L185Statement.lean) already carries. L185 was Gate-2 confirmed by [r798](REVIEW_r798.md) and [r799](REVIEW_r799.md), so this is settled material and not a fresh specialisation.

**Verdict: GAP.** The block should cite [L185](../findings/diagonal-half.md#L662) rather than derive the step, and its "the specialisation is one line" is accurate about the length and wrong about the novelty. The one thing the block adds over L185 is scope: L185 uses the identity at rank three, and the block uses it at full rank over a whole eigenbasis, which is a genuine extension of the site of application even though the algebra is the same.

## 3. (A)'s scope when some $\lambda_\alpha=0$

L180's statement carries "every $\lambda_i\ne0$", and its proof of (1) spends that hypothesis nowhere: the contraction $\sum_bW_{abcb}=(\sum_i\lambda_i\omega_i\omega_i^{\mathsf T})_{ac}$ is an identity in the coefficients, valid for any real $\lambda_i$. The nonvanishing is consumed by L180(3), where the sign pattern and the range additivity need it, and by (2) only through the trace bookkeeping. So (A) holds verbatim with zero eigenvalues present, the vanishing terms simply dropping out of the sum, and a zero-padded object is covered.

Two consequences the block should carry. First, the all-decomposable eigenbasis in (A) may include forms at eigenvalue zero, and the identity is then a sum over the nonzero part alone, which is what the four-cycle in (D) needs and what L180's stated hypothesis would appear to forbid. Second, the block's use stays inside L180's hypotheses at the objects it actually names, because the $n=4$ witness at the derived weight has all six eigenvalues nonzero. The four-cycle in (D) does not, and section 8 handles that.

**Verdict: CONFIRMED**, with the observation that L180(1) is stated under a hypothesis its proof does not use, which is worth a note at [L180](../findings/diagonal-half.md#L895) itself.

## 4. (A) as an equivalence

L180(1) says "Ricci-flatness is exactly", an iff. Section 1 gives $\omega_\alpha^2=-\Pi_{P_\alpha}$ as an identity at every decomposable $\omega_\alpha$ with orthonormal spanning pair. Substituting an identity into an iff preserves it, so on the all-decomposable set

$$\mathrm{Ric}(W)=0\iff\sum_\alpha\lambda_\alpha\,\omega_\alpha^2=0\iff\sum_\alpha\lambda_\alpha\,\Pi_{P_\alpha}=0,$$

and "reads" is the right word. One clause is needed for the equivalence to be about a Weyl tensor rather than about a symmetric operator: the first Bianchi identity must also hold, and on the all-decomposable set it does identically, since every $\omega_\alpha\wedge\omega_\alpha=0$ makes $\mathrm{Alt}(W)=\tfrac16\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha$ vanish. The record has that at [diagonal-half.md:1102](../findings/diagonal-half.md#L1102), so nothing is owed.

**Verdict: CONFIRMED.**

## 5. (B)'s inference is a converse, and it fails

**What [diagOp_ric](../lean/HamiltonsCubic/Base/Families.lean) gives.** For $w$ symmetric, $\mathrm{Ric}(\mathrm{diagOp}\,w)_{ab}=0$ whenever $a\ne b$. The contrapositive is: if the Ricci matrix of $W$, written in the frame $f$, has a nonzero off-diagonal entry, then $W$ is not coordinate-diagonal in the frame $f$. That is a statement about ONE frame, because "off-diagonal entry" is a frame-dependent notion and $\mathrm{diagOp}$ is defined relative to a fixed frame.

**What (B) claims.** That a nonzero off-diagonal entry is a frame-mixing detector "and nothing else", which reads as: nonzero off-diagonal entry $\Rightarrow$ the planes admit no common frame. That is the converse of the frame-relative statement quantified over frames, and it is false.

**Closed-form refutation.** Take $n=4$, $t$ with $\sin2t\ne0$, $g_2=\cos t\,e_2+\sin t\,e_3$, and the single-plane object $W=\Pi_{\langle e_1,g_2\rangle}$-weighted sum with one term, $\lambda_1=1$ on the plane $\langle e_1,g_2\rangle$ and nothing else. Then

$$\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=e_1e_1^{\mathsf T}+g_2g_2^{\mathsf T},\qquad(2,3)\ \text{entry}=\cos t\sin t=\tfrac12\sin2t\ne0,$$

and the collection of planes is the single plane $\langle e_1,g_2\rangle$, which lies in the common frame $\{e_1,g_2,g_3,e_4\}$ trivially. A nonzero off-diagonal entry, and a common frame. The same works with any number of planes taken from the rotated frame. So a nonzero off-diagonal entry detects non-diagonality in the STANDARD frame and says nothing whatever about whether a common frame exists.

**And "and nothing else" fails a second way, which is the more damaging one.** Section 6 shows the entry is $\tfrac12\sin2t\,(\lambda_1-\lambda_2)$, a product of a mixing factor and an eigenvalue gap. It vanishes at $\lambda_1=\lambda_2$ for every $t$, including maximal mixing at $t=\pi/4$. So the entry is not a function of the frame data alone, and it detects neither the mixing nor the gap in isolation. Calling it a frame-mixing detector misattributes half of its content.

**The brief's own point, which is decisive.** In the intended application the object IS Ricci-flat, so every off-diagonal entry is zero by hypothesis. There is nothing to detect. What the route needs is the opposite implication, that vanishing off-diagonal entries force a common frame, and that is exactly obligation (C). So the detector language is either empty in the application or a restatement of the thing still to be proved, and in neither reading is it a "handle".

**Verdict: REFUTED.** The salvageable sentence is: the off-diagonal entries of $\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}$, read in a fixed frame, vanish identically when the planes are that frame's coordinate planes, so their vanishing is a necessary condition that a candidate frame must pass. That is true, it is what the witness computation uses, and it claims no converse.

## 6. (B)'s witness value, derived

The six planes and weights of the witness at [diagonal-half.md:1096](../findings/diagonal-half.md#L1096), with $c=\cos t$ and $s=\sin t$:

$$P_1=\langle e_1,g_2\rangle,\ P_2=\langle e_1,g_3\rangle,\ P_3=\langle e_1,e_4\rangle,\ P_4=\langle e_2,e_3\rangle,\ P_5=\langle e_2,e_4\rangle,\ P_6=\langle e_3,e_4\rangle.$$

The projections are $\Pi_1=e_1e_1^{\mathsf T}+g_2g_2^{\mathsf T}$, $\Pi_2=e_1e_1^{\mathsf T}+g_3g_3^{\mathsf T}$, and $\Pi_j=E_{ii}+E_{kk}$ for the four standard planes. In the $\langle e_2,e_3\rangle$ block, $g_2g_2^{\mathsf T}=\begin{pmatrix}c^2&cs\\cs&s^2\end{pmatrix}$ and $g_3g_3^{\mathsf T}=\begin{pmatrix}s^2&-cs\\-cs&c^2\end{pmatrix}$. Every other summand is diagonal in the standard frame, so the only off-diagonal entry of $\sum_\alpha\lambda_\alpha\Pi_\alpha$ is

$$\Big(\sum_\alpha\lambda_\alpha\Pi_\alpha\Big)_{23}=\lambda_1cs-\lambda_2cs=\tfrac12\sin2t\,(\lambda_1-\lambda_2),$$

which is the block's value at the block's index convention, rows and columns indexed from $e_1$. It is the unique off-diagonal entry, as claimed. The diagonal entries are

$$(1,1)=\lambda_1+\lambda_2+\lambda_3,\quad(2,2)=\lambda_1c^2+\lambda_2s^2+\lambda_4+\lambda_5,\quad(3,3)=\lambda_1s^2+\lambda_2c^2+\lambda_4+\lambda_6,\quad(4,4)=\lambda_3+\lambda_5+\lambda_6.$$

Imposing all five conditions with $\sin2t\ne0$: the off-diagonal gives $\lambda_1=\lambda_2=:a$, then $(1,1)$ gives $\lambda_3=-2a$, the pair $(2,2)$ and $(3,3)$ give $\lambda_5=\lambda_6=-a-\lambda_4$, and $(4,4)$ gives $-2a+2(-a-\lambda_4)=0$, hence $\lambda_4=-2a$ and $\lambda_5=\lambda_6=a$. The solution space is the line through $(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$ at $a=\tfrac12$, which is one-dimensional and is exactly the vector the record carries at [diagonal-half.md:1106](../findings/diagonal-half.md#L1106) as a screened figure attributed to [r846](REVIEW_r846.md). So that screen is also replaceable by the five lines above.

**Verdict: CONFIRMED**, and the record's screened spanning vector is now derived.

## 7. (C) is FALSE, and the counterexample is the record's own witness

**The claim.** *"What is owed is that $\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0$, over the planes of an orthonormal basis of decomposable forms, forces those planes into a common frame."*

**The counterexample.** Take the six planes above with weights $\lambda=(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$ and any $t$ with $\sin2t\ne0$.

*It is an orthonormal basis of decomposable forms.* The six forms $e_1\wedge g_2$, $e_1\wedge g_3$, $e_1\wedge e_4$, $e_2\wedge e_3$, $e_2\wedge e_4$, $e_3\wedge e_4$ are decomposable by construction, pairwise orthonormal by the formula $\langle u\wedge v,p\wedge q\rangle=(u\cdot p)(v\cdot q)-(u\cdot q)(v\cdot p)$ derived in section 9, and six orthonormal vectors in the six-dimensional $\Lambda^2\mathbb R^4$ are a basis. The record has the same fact at [diagonal-half.md:1096](../findings/diagonal-half.md#L1096) via $e_2\wedge e_3=g_2\wedge g_3$.

*The identity holds.* By section 6 the $(2,3)$ entry is $\tfrac12\sin2t\,(\tfrac12-\tfrac12)=0$, the only off-diagonal entry, and the four diagonal entries are $\tfrac12+\tfrac12-1=0$, $\tfrac12(c^2+s^2)-1+\tfrac12=0$ twice, and $-1+\tfrac12+\tfrac12=0$. So $\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0$ identically in $t$.

*Every weight is nonzero,* so the exhibit satisfies L180's hypothesis in full and cannot be dismissed on that ground.

*The planes admit no common frame.* Suppose an orthonormal frame $f_1,\dots,f_4$ had every $P_\alpha$ of the form $\langle f_i,f_j\rangle$. There are six such coordinate planes and six $P_\alpha$, so the two collections coincide, and each line $\mathbb Rf_i$ lies in exactly three of them. Enumerate the fifteen pairwise intersections. The three planes through $e_1$ meet pairwise in $\mathbb Re_1$. The three planes through $e_4$, namely $P_3,P_5,P_6$, meet pairwise in $\mathbb Re_4$. Then $P_1\cap P_4=\mathbb Rg_2$ and $P_2\cap P_4=\mathbb Rg_3$, since $g_2,g_3\in\langle e_2,e_3\rangle$, while $P_4\cap P_5=\mathbb Re_2$ and $P_4\cap P_6=\mathbb Re_3$. The remaining five intersections are zero: $P_3\cap P_4=0$, and for $P_1\cap P_5$ a vector $ae_1+bg_2=ae_1+bc\,e_2+bs\,e_3$ lies in $\langle e_2,e_4\rangle$ only if $a=0$ and $bs=0$, hence $b=0$ because $s\ne0$, and the three cases $P_1\cap P_6$, $P_2\cap P_5$, $P_2\cap P_6$ go the same way using $c\ne0$ or $s\ne0$. So the lines lying in three of the six planes are exactly $\mathbb Re_1$ and $\mathbb Re_4$, two of them, and a frame needs four. No common frame exists.

That is (C) refuted as written, with the identity satisfied. This reproduces the record's own count at [diagonal-half.md:1100](../findings/diagonal-half.md#L1100), which is stated there for the same six planes, so the block asserts (C) fifteen lines below an argument that its own witness violates (C).

**The block refutes itself in its own next sentence.** (E) at [diagonal-half.md:1108](../findings/diagonal-half.md#L1108) says the collapse works because "the eigenspace becomes $e_1\wedge\langle e_2,e_3\rangle$ ... so $e_1\wedge e_2$ and $e_1\wedge e_3$ **may be chosen**". The word "chosen" concedes that the GIVEN planes are not in a common frame and that a different basis of the same eigenspace is. (C) asserts a property of the given planes. (E) uses a property of the operator. They are different statements, and only the second is true here.

**The repair, and where it moves the load.** The true obligation is at the operator: $\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0$ over an orthonormal decomposable eigenbasis forces the existence of SOME orthonormal decomposable eigenbasis whose planes lie in a common frame. That is what coordinate-diagonality means and it is what the witness satisfies. The repair is not cosmetic, because the whole content of the route then sits in reselecting bases inside degenerate eigenspaces, which is step four, the step the block calls free. Section 9 shows step four is where the difficulty is.

**Verdict: REFUTED.** The route is not dead, and its step three is, in the form recorded.

## 8. (C) has the same defect as the refuted (D), and (D)'s own witness checks out

**(D)'s witness, verified independently.** Take the four-cycle on $\{1,2,3,4\}$ with edges $\{1,2\},\{2,3\},\{3,4\},\{4,1\}$ at weights $1,-1,1,-1$, which is [L177](../findings/diagonal-half.md)'s minimal coordinate-diagonal support graph.

*Coordinate-diagonal:* it is $\mathrm{diagOp}\,w$ for $w$ supported on those four unordered pairs, symmetric and hollow by construction.

*Ricci-flat:* the row sums are $w_{12}+w_{14}=1-1=0$ at vertex $1$, $w_{12}+w_{23}=1-1=0$ at vertex $2$, $w_{23}+w_{34}=-1+1=0$ at vertex $3$, and $w_{34}+w_{14}=1-1=0$ at vertex $4$, and [diagOp_ric](../lean/HamiltonsCubic/Base/Families.lean) makes the Ricci matrix exactly the row sums on the diagonal and zero off it. Equivalently in the projection language, $1\cdot\Pi_{12}-1\cdot\Pi_{23}+1\cdot\Pi_{34}-1\cdot\Pi_{14}$ has diagonal $(1-1,1-1,-1+1,1-1)=0$ and no off-diagonal part.

*First Bianchi:* every eigenform is a coordinate plane form, hence decomposable, so $\mathrm{Alt}(W)=\tfrac16\sum\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$. So it is a genuine element of $\mathcal W_4$.

*The eigenvalues:* $e_1\wedge e_2$ carries $1$ because $\{1,2\}$ is a cycle edge, and $e_1\wedge e_3$ carries $0$ because $\{1,3\}$ is a diagonal of the cycle and absent from the support. They share $\mathbb Re_1$. So the earlier step three, that sharing a line forces equal eigenvalues, is refuted.

*And the refutation does not need the zero.* L180 assumes every $\lambda_i\ne0$, and the block's chosen pair sits exactly outside that hypothesis, which is an avoidable weakness in a self-refutation. The pair $e_1\wedge e_2$ and $e_2\wedge e_3$ does the same work: they share $\mathbb Re_2$ and carry $1$ and $-1$, both nonzero. The block should name that pair instead, or name both.

**Verdict on (D): CONFIRMED**, and strengthened by the adjacent-edge pair.

**Is (C) stronger than (D)?** No. Both assert a property of the eigenbasis handed to them. (D) asserted it of a pair, and a coordinate-diagonal Ricci-flat object with unequal weights on two adjacent edges refutes it. (C) asserts it of the whole collection of planes, and the mixed-frame witness at its Ricci-flat weight refutes it. The block's stated reason for preferring (C), *"which is why the obligation is stated at the projection identity and not at a pair"*, identifies the wrong axis of the earlier error: the error was not the arity of the object but the confusion of a property of a chosen basis with a property of the operator, and (C) repeats it.

**Verdict: REFUTED**, on the comparative claim.

## 9. (E)'s construction, the derivation that replaces its screen, and why step four is not free

**The wedge inner product, derived once.** With $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$ and $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$,

$$\langle u\wedge v,p\wedge q\rangle=\tfrac12\operatorname{tr}\big((uv^{\mathsf T}-vu^{\mathsf T})(qp^{\mathsf T}-pq^{\mathsf T})\big)=\tfrac12\big[(v\cdot q)(p\cdot u)-(v\cdot p)(q\cdot u)-(u\cdot q)(p\cdot v)+(u\cdot p)(q\cdot v)\big],$$

which is $(u\cdot p)(v\cdot q)-(u\cdot q)(v\cdot p)$. At $u=p$, $v=q$ orthonormal this is $1$, confirming section 1's unit norm.

**The count.** The family takes $e_1\wedge g_2$, $e_1\wedge g_3$ and $e_1\wedge e_k$ for $4\le k\le n$, which is $2+(n-3)=n-1$ forms, together with $e_i\wedge e_j$ for $2\le i<j\le n$, which is $\binom{n-1}2$. The total is $(n-1)+\binom{n-1}2=\binom n2$, as the brief says. At $n=5$ that is $4+6=10$ and at $n=6$ it is $5+10=15$, both correct.

**Pairwise orthogonality, including the cross terms.** Within the second group these are distinct standard basis forms, orthonormal. Within the first group, every member is $e_1\wedge x$ with $x$ running over the orthonormal set $\{g_2,g_3,e_4,\dots,e_n\}$, and the formula gives $\langle e_1\wedge x,e_1\wedge y\rangle=(e_1\cdot e_1)(x\cdot y)-(e_1\cdot y)(x\cdot e_1)=x\cdot y$, since $x,y\perp e_1$. So they are orthonormal exactly because $\{g_2,g_3,e_4,\dots,e_n\}$ is. For the cross terms, with $2\le i<j$,

$$\langle e_1\wedge x,e_i\wedge e_j\rangle=(e_1\cdot e_i)(x\cdot e_j)-(e_1\cdot e_j)(x\cdot e_i)=0,$$

both products vanishing because $i,j\ge2$. So the $\binom n2$ forms are orthonormal, hence a basis, and every one is decomposable. At $n=4$ the family is exactly the recorded witness.

**Verdict on the construction: CONFIRMED at every $n\ge3$.**

**The screen "every direction has $\mu_1=\mu_2$" is a two-line derivation.** In the standard frame, $\Pi_{\langle e_1,g_2\rangle}=e_1e_1^{\mathsf T}+g_2g_2^{\mathsf T}$ and $\Pi_{\langle e_1,g_3\rangle}=e_1e_1^{\mathsf T}+g_3g_3^{\mathsf T}$ contribute $cs$ and $-cs$ at the $(2,3)$ entry, and every other member of the family is a plane of two standard frame vectors, so its projection is diagonal. Hence at every $n$

$$\Big(\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}\Big)_{23}=\tfrac12\sin2t\,(\lambda_1-\lambda_2),$$

and this is the ONLY nonzero off-diagonal entry of the whole sum. With $\sin2t\ne0$, Ricci-flatness forces $\lambda_1=\lambda_2$ on every direction of the solution space, at every $n$, by that entry alone. **Verdict: CONFIRMED AS DERIVATION**, and the screen should be replaced by these two lines.

**The dimension is $\binom n2-n-1$, which derives both recorded figures.** Once $\lambda_1=\lambda_2=a$, the two rotated terms combine as

$$a\big(2e_1e_1^{\mathsf T}+g_2g_2^{\mathsf T}+g_3g_3^{\mathsf T}\big)=a\big(2E_{11}+E_{22}+E_{33}\big)=a\,\Pi_{\langle e_1,e_2\rangle}+a\,\Pi_{\langle e_1,e_3\rangle},$$

using $g_2g_2^{\mathsf T}+g_3g_3^{\mathsf T}=E_{22}+E_{33}$. So the identity becomes the standard-frame coordinate-diagonal Ricci-flatness condition on edge weights of $K_n$, subject to the extra linear condition $\lambda_{12}=\lambda_{13}$. The row-sum map from edge weights to vertex values is the unsigned incidence map of $K_n$, of rank $n$ for $n\ge3$ because $K_n$ is connected and non-bipartite, so the coordinate-diagonal Ricci-flat weights form a space of dimension $\binom n2-n$. The condition $\lambda_{12}=\lambda_{13}$ is independent on that space for $n\ge4$, the four-cycle $\{1,2\},\{2,3\},\{3,4\},\{4,1\}$ at $(1,-1,1,-1)$ lying in it with $\lambda_{12}=1$ and $\lambda_{13}=0$. Hence

$$\dim=\binom n2-n-1,$$

giving $1$ at $n=4$, $4$ at $n=5$, $8$ at $n=6$ and $13$ at $n=7$. Both of the record's screened figures follow. **Verdict: CONFIRMED and generalised.**

**The collapse holds at every $n$.** With $\lambda_1=\lambda_2=a$, the forms $e_1\wedge g_2$ and $e_1\wedge g_3$ span $e_1\wedge\langle g_2,g_3\rangle=e_1\wedge\langle e_2,e_3\rangle$ inside the $a$-eigenspace, so $e_1\wedge e_2$ and $e_1\wedge e_3$ are an orthonormal decomposable basis of that same two-dimensional subspace with the same eigenvalue. Replacing them and keeping every other member of the family yields the set $\{e_1\wedge e_j\}_{j\ge2}\cup\{e_i\wedge e_j\}_{2\le i<j}$, which is the complete standard basis of $\Lambda^2\mathbb R^n$, orthonormal by inspection and decomposable, and consisting of eigenforms with unchanged eigenvalues. So the point is coordinate-diagonal in the standard frame at every $n$, and nothing else obstructs, because every other eigenform was already a standard-frame plane form. **Verdict: CONFIRMED at every $n$.**

**Step four is not free, and "its own plane" is undefined where it is used.** At $n=4$, the collapsed weight is $(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$, so the eigenvalue $\tfrac12$ has multiplicity FOUR and its eigenspace is

$$\mathrm{span}\{e_1\wedge g_2,\ e_1\wedge g_3,\ e_2\wedge e_4,\ e_3\wedge e_4\}=e_1\wedge\langle e_2,e_3\rangle\ \oplus\ \langle e_2,e_3\rangle\wedge e_4,$$

which has no "own plane" of any kind. So the record's sentence at [diagonal-half.md:1106](../findings/diagonal-half.md#L1106), *"the eigenspaces are $e_1\wedge\langle e_2,e_3\rangle$ and $\langle e_2,e_3\rangle\wedge e_4$, each frame-independent inside its plane"*, mis-describes the object: the derived weight makes those two subspaces one eigenspace of dimension four, and they are eigenSPACES only if $\lambda_1\ne\lambda_5$, which Ricci-flatness forbids on this family. The conclusion survives, and the reason given for it does not.

Two further limits on the step-four sentence. First, for an eigenspace of the shape $u\wedge V$ with $\dim V=k$ the claim is true, any orthonormal basis of $V$ giving an orthonormal decomposable basis of $u\wedge V$, and that is the only case where "its own plane" makes sense as "the space $V$". Second, at dimension two the claim already fails outside that shape: $\mathrm{span}\{e_1\wedge e_2,e_3\wedge e_4\}$ is two-dimensional with a decomposable orthonormal basis, and the rotated basis $\tfrac1{\sqrt2}(e_1\wedge e_2\pm e_3\wedge e_4)$ is NOT decomposable, since its self-wedge is $\pm e_1\wedge e_2\wedge e_3\wedge e_4\ne0$. So a degenerate eigenspace does not come with free reselection, and what step four actually needs is that the eigenspace decompose as an orthogonal sum of $u_r\wedge V_r$ blocks whose frames are simultaneously compatible. The collapsed witness satisfies that by luck of the construction, $\{e_1,e_2,e_3,e_4\}$ serving both blocks.

**Verdict: REFUTED AS STATED.** Step four is the load-bearing step of the repaired route, and the block's "free" is the reverse of the truth.

## 10. The screens, reported as screens

I screened the four closed-form results of sections 1, 6, 7 and 9 with a fifteen-line numpy script on objects I constructed for the purpose, at $t=0.7$ and $n=4,5,6,7$. Every one agreed exactly: the projection identity of section 1 to $0$; the Gram matrix of the six witness forms to the identity to $0$; the witness sum at $(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$ to $0$; the $(2,3)$ entry against $\tfrac12\sin2t\,(\lambda_1-\lambda_2)$ to sixteen digits; the mixed-frame family orthonormal at $n=4,5,6,7$ with $\binom n2$ members; the solution dimensions $1,4,8,13$ against $\binom n2-n-1$; $\lambda_1-\lambda_2$ zero to $10^{-16}$ on every basis direction of every solution space; and the four-cycle sum to $0$. **None of this is evidence for anything.** Every claim in this review is derived in closed form above, and the screens exist only so that a transcription slip would have surfaced.

## 11. Arguing the opposite of each defect

**Against my refutation of (C).** The strongest defence is that (C) implicitly inherits step two's simplicity hypothesis, so that "an orthonormal basis of decomposable forms" means an eigenbasis at a simple spectrum, and my exhibit has eigenvalues of multiplicity four and two. I do not think this saves the block, and the reason is structural rather than verbal. On the simple reading, step two of the route delivers decomposability only at simple eigenvalues, so at the collapsed witness, where the spectrum is $\{\tfrac12^{(4)},-1^{(2)}\}$, the route has no decomposability hypothesis at all and step three has no input. The mechanism (E) names as the one I36b needs at every dimension is precisely the degenerate case. So on the literal reading (C) is false and on the simple reading (C) is silent exactly where the route needs it, and I record both. That fork is item 15 in the table and it is the one thing I would put highest for repair. **Not withdrawn.**

**Against my refutation of (B).** The defence is that "off-diagonal" was always meant relative to the standard frame and that "frame-mixing detector" was shorthand for "detects that this frame is not adapted". That reading is true and is the sentence I offer at the end of section 5. It does not rescue the words as written, because "and nothing else" is an explicit exclusivity claim, and because the entry demonstrably also carries the eigenvalue gap, vanishing at $\lambda_1=\lambda_2$ under maximal mixing. A second defence is that the sentence is only motivational and carries no weight in the argument. That is nearly right, and it is why I report the sentence rather than the route as broken on this count. **Not withdrawn, downgraded in severity.**

**Against my GAP on (A).** The defence is that L185 uses the identity at rank three with three forms, and the block uses it at full rank over an entire eigenbasis, which is a new site. I accept that the site is new. The algebra, the sentence and the projection reading are not, and the block presents them as a fresh one-line specialisation of L180 with no citation of L185, which is the thing the record's own five-re-derivations problem is about. **Not withdrawn, and narrowed to the algebra.**

**Against my refutation of step four.** The defence is that "its own plane" was written about the $n=4$ witness where the intended eigenspace is $e_1\wedge\langle e_2,e_3\rangle$, of the right shape. Section 9 shows that at the derived Ricci-flat weight that space is not an eigenspace, the eigenvalue $\tfrac12$ having multiplicity four, so the defence relies on a description of the witness that Ricci-flatness contradicts. **Not withdrawn.**

**Withdrawn candidates.** I considered and dropped three. First, that the equivalence in (A) needs first Bianchi as a side condition and so is not an equivalence for Weyl tensors: the all-decomposable set satisfies first Bianchi identically, which the record already carries, so nothing is owed. Second, that the block's index convention for $(2,3)$ might be off by one against a zero-indexed Lean convention: the record indexes from $e_1$ and the value is correct there, so there is no discrepancy. Third, that $\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0$ might be unsolvable over a full decomposable basis for trivial reasons of trace: the trace is $2\sum_\alpha\lambda_\alpha$, which vanishes on a hyperplane, and section 9 exhibits solution spaces of dimension $\binom n2-n-1$, so the condition is far from vacuous.

## 12. A byproduct worth a line on the record

For ANY orthonormal basis $\{\omega_\alpha\}$ of $\Lambda^2\mathbb R^n$ consisting of decomposable forms,

$$\sum_\alpha\Pi_{P_\alpha}=(n-1)\,\mathrm{Id}_{\mathbb R^n},$$

because $\sum_\alpha\omega_\alpha\otimes\omega_\alpha=\mathrm{Id}_{\Lambda^2}$ makes $\sum_\alpha\omega_\alpha\omega_\alpha^{\mathsf T}$ a basis-independent contraction, evaluated on the standard basis as $\sum_{i<j}(E_{ii}+E_{jj})=(n-1)\mathrm{Id}$. So the equal-weight direction is never Ricci-flat, the identity $\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0$ always excludes the constant vector, and the solution space of section 9 sits inside a hyperplane for a reason that is one line rather than a computation. I did not find this on the record, and it is the kind of constraint a repaired step three would spend.

## 13. What would break the route, and what I did to look for it

**What breaks it.** An orthonormal basis of decomposable $2$-forms of $\Lambda^2\mathbb R^n$, with a weight vector making $\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0$, such that NO orthonormal decomposable eigenbasis of the resulting operator lies in a common frame. That is the operator-level negation of the repaired step three, and it would kill I36b's route for $n\ge5$ outright. The exhibit in section 7 is one level weaker: it breaks (C) as written, and its operator is coordinate-diagonal, so it leaves the repaired obligation open.

**What I did.** I derived the full off-diagonal structure of the mixed-frame family at every $n$ and found that its entire content is the single $(2,3)$ entry, which forces $\lambda_1=\lambda_2$ and collapses the family into the standard frame at every $n$. So the record's one construction of a non-common-frame decomposable basis cannot supply the breaker, and it cannot supply it at any dimension rather than merely at $n=4,5,6$ where it was screened. I did not construct a second family, because building one is a search and the standing rule forbids it. What I can say from the derivation is where a breaker would have to live: in a decomposable orthonormal basis carrying at least two independent frame mixings, so that the off-diagonal entries form a system with a nontrivial solution rather than the single equation this family produces. That is the shape of the next construction, and naming it is the analytical part of the work.

**What computation would decide, if the parent chooses to approve it.** Whether an orthonormal decomposable basis of $\Lambda^2\mathbb R^6$ built from two independent rotations, one on $\langle e_2,e_3\rangle$ for the planes through $e_1$ and one on $\langle e_5,e_6\rangle$ for the planes through $e_4$, admits a Ricci-flat weight with both mixings live. A yes would break the repaired step three and end the route. A no at $n=6$ would be evidence that the collapse mechanism is general and would suggest the shape of its proof. **I did not run it.**

## OVERALL VERDICT

**REFUTED on the load-bearing claim.** (A) is correct algebra under the record's own normalisation and is already recorded at [L185](../findings/diagonal-half.md#L662), so it is a `GAP` rather than a step. (B)'s exclusivity clause is a false converse, and the honest version of it claims nothing the route can spend. (C), the restated step three, is FALSE as written, refuted by the record's own $n=4$ witness at the record's own derived Ricci-flat weight, over six planes with all weights nonzero and no common frame, and it fails for the same reason the block's own (D) identifies in its predecessor, namely confusing a property of a chosen eigenbasis with a property of the operator. (D)'s self-refutation is sound and is strengthened by moving to an adjacent-edge pair that avoids L180's nonvanishing hypothesis. (E) is entirely correct and is better than it claims: its construction, its equal-eigenvalue screen, its dimension figures and its collapse are all derivable in closed form, the dimension being $\binom n2-n-1$ at every $n$ and the collapse holding at every $n$.

What survives is a route with a correctly stated step three still to be written, at the operator rather than at the planes, and with step four carrying the weight the block assigned to step three.
