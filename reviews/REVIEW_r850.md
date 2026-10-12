# REVIEW_r850: I36's projection-identity crux, cold

**Reviewer r850, cold brief, arguing from the definitions.** The brief quoted [L180](../findings/diagonal-half.md#L895), the [diagOp_ric](../lean/HamiltonsCubic/Base/Families.lean#L203) docstring, the decomposability criterion and the $\Lambda^2$ conventions, and nothing else of the record. Everything below is derived here. Two closed forms and one identity were screened for sign slips after derivation and are reported as screens, never as evidence.

## Claim table

| Claim | Verdict | Reason |
| --- | --- | --- |
| (A) $\omega\omega^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_{P}$ at a decomposable $\omega$ | CONFIRMED AS ALGEBRA | true for $\omega=uv^{\mathsf T}-vu^{\mathsf T}$ with $u,v$ orthonormal, and [L180](../findings/diagonal-half.md#L895)'s trace-$2$ clause pins exactly that normalisation |
| (A) is already on the record | GAP | it is [L185](../findings/diagonal-half.md#L662)'s own proof line, recorded 2026-09-09 and Gate-2 landed, cited nowhere in the block |
| (A) inside L180's hypotheses | GAP | L180 assumes every $\lambda_i\ne0$ while the block sums over a full eigenbasis carrying zeros, so the citation reaches past its stated hypothesis, and the extension costs one line and is owed in writing |
| (A) as an equivalence ("reads") | CONFIRMED | $\mathrm{Ric}_{ac}$ is that matrix's $(a,c)$ entry, so the identity and Ricci-flatness are the same equation in both directions |
| (B) an off-diagonal entry is a frame-mixing detector "and nothing else" | REFUTED | that is the converse of [diagOp_ric](../lean/HamiltonsCubic/Base/Families.lean#L203) and it fails: $\varphi_{12}\otimes\varphi_{12}$ is coordinate-diagonal and its Ricci has $(2,3)$ entry $-\tfrac12\sin2t$ in the frame rotated by $t$ |
| (B) as the handle on step three | REFUTED AS STATED | Ricci-flatness is frame-independent, so at the point step three quantifies over every off-diagonal entry in every frame is zero and the detector reads nothing |
| (B) the value $\tfrac12\sin2t\,(\lambda_1-\lambda_2)$ at $(2,3)$, and sole off-diagonal | CONFIRMED | derived in closed form: only $g_2g_2^{\mathsf T}$ and $g_3g_3^{\mathsf T}$ leave the standard diagonal, with coefficient $\cos t\sin t(\lambda_{12}-\lambda_{13})$ |
| (C) the identity forces THOSE planes into a common frame | REFUTED | the block's own $n=4$ witness at weights $(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$ satisfies the identity with all weights nonzero, and its six planes lie in no common frame at any $\sin2t\ne0$ |
| (C) repaired existentially, over eigenbases rather than a given one | CONFIRMED AT $n=4$ | proved in §6 through the $\Lambda^\pm$ split: all-decomposable plus Ricci-flat at $n=4$ is exactly coordinate-diagonal. Open at $n\ge5$, where the proof has no analogue |
| (C) step four is free | REFUTED AS STATED | "its own plane" names nothing above dimension two, and the two-dimensional eigenspace $\langle e_1\wedge g_2,\,e_4\wedge g_3\rangle$ has exactly two decomposable directions and no plane of its own. Step four carries the whole repair |
| (D) the four-cycle refutes the earlier step three | CONFIRMED | coordinate-diagonal, row sums zero, eigenvalues $1$ on $e_1\wedge e_2$ and $0$ on $e_1\wedge e_3$ |
| (D) survives the zero-eigenvalue objection | CONFIRMED, STRENGTHENED | the weights $(2,1,-3,-3,1,2)$ on $K_4$ give the same refutation with all six eigenvalues nonzero, so [L180](../findings/diagonal-half.md#L895)'s hypothesis is met |
| (E) the mixed-frame family is an orthonormal decomposable basis at every $n$ | CONFIRMED | count $\binom{n-1}1+\binom{n-1}2=\binom n2$, and every cross term vanishes because $e_1$ is orthogonal to the second group |
| (E) every Ricci-flat direction has $\mu_1=\mu_2$ | CONFIRMED AS ALGEBRA | the $(2,3)$ entry alone gives it at every $n$, so the screen is replaceable by two lines and should be |
| (E) dimension $8$ at $n=6$ against $1$ at $n=4$ | CONFIRMED, AND DERIVABLE | the solution space is $\{w$ hollow symmetric, zero row sums, $w_{12}=w_{13}\}$, of dimension $\binom n2-n-1$, which is $1,4,8$ at $n=4,5,6$ |
| (E) the collapse to coordinate-diagonal at every $n$ | CONFIRMED | the rest of the basis is standard-frame and the equal-weight pair spans $e_1\wedge\langle e_2,e_3\rangle$ |

**Actionable summary.** Keep (A), (D) and (E), fix (A)'s two citation debts (it is [L185](../findings/diagonal-half.md#L662)'s recorded line, and L180's nonzero hypothesis needs the one-line padding remark), delete (B)'s "and nothing else" clause together with its role as the handle, and restate the crux (C) existentially over decomposable eigenbases, at which point step four stops being free and becomes the statement.

## Conventions, as quoted in the brief

- The inner product on $\Lambda^2$ is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal with $\varphi_{ab}=E_{ba}-E_{ab}$.
- "Diagonal" means diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame, and not diagonal as an operator on $\Lambda^2$.
- A $2$-form is decomposable iff $\omega\wedge\omega=0$ iff $\omega=u\wedge v$, and its support is the plane $\langle u,v\rangle$.
- [L180](../findings/diagonal-half.md#L895)(1): with $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$ in spectral form, the $\omega_i$ orthonormal and every $\lambda_i\ne0$, Ricci-flatness is $\sum_i\lambda_i\omega_i^2=0$, equivalently $\sum_i\lambda_iA_i=0$ with $A_i=\omega_i\omega_i^{\mathsf T}$ positive semidefinite of trace $2$.
- [diagOp_ric](../lean/HamiltonsCubic/Base/Families.lean#L203): the Ricci contraction of a diagonal operator is the row sum, on the diagonal and nowhere else.
- Indices run from $e_1$. Entry $(2,3)$ below is the $e_2$-$e_3$ entry of a symmetric $n\times n$ matrix.
- Throughout, $c=\cos t$, $s=\sin t$, $g_2=c\,e_2+s\,e_3$, $g_3=-s\,e_2+c\,e_3$, and $g_j=e_j$ for $j\ge4$.

## Hypothesis inventory, checked against the objects

| Hypothesis | Where it is spent | Status against the objects |
| --- | --- | --- |
| $u,v$ orthonormal in $\omega=u\wedge v$ | (A)'s identity | met by the area form of a plane, and load-bearing: for merely independent $u,v$ the product is the Gram-weighted $\Pi$ and has trace $\lVert u\rVert^2+\lVert v\rVert^2$ |
| $\omega$ normalised as the matrix $uv^{\mathsf T}-vu^{\mathsf T}$ | (A)'s identity | met, and forced by the trace-$2$ clause. Under the alternating-tensor normalisation $\tfrac12(u\otimes v-v\otimes u)$ the product is $\tfrac14\Pi_P$ and (A) is false by a factor of four |
| every $\lambda_i\ne0$ | L180's statement, spent in its (3) | NOT met by the block's use: the all-decomposable eigenbasis is the full $\binom n2$ and a padded object has zeros. (1)'s proof never touches the hypothesis, so the extension is free, and it is unstated |
| $\{\omega_\alpha\}$ an orthonormal basis of $\Lambda^2$ of decomposable forms | (A), (C), (E) | met by the witness family, verified in §9 |
| $\sin2t\ne0$ | (B)'s value, (E)'s collapse, the failure of a common frame | met by hypothesis. At $\sin2t=0$ the family is standard-frame outright and every claim about it degenerates rather than failing |
| first Bianchi | nowhere in this block | free on the all-decomposable set, since $\omega\wedge\omega=0$ termwise. So Weyl and Ricci-flat coincide here, which is what makes the weight space a linear space |
| eigenvalues distinct | the witness of (iii) above line 1102 | violated by every Ricci-flat member of the family, which is (E)'s own point and the reason the collapse exists |
| $A=\omega\omega^{\mathsf T}$ positive semidefinite | not used in this block | available, and unused: the block's crux is a linear-algebra statement about frames rather than a range statement |

## 1. (A)'s one-line specialisation, and the normalisation that makes it true

Take $u,v$ orthonormal and $\omega=u\wedge v$ realised as the skew matrix $uv^{\mathsf T}-vu^{\mathsf T}$. Then

$$\omega^2=(uv^{\mathsf T}-vu^{\mathsf T})(uv^{\mathsf T}-vu^{\mathsf T})=u(v^{\mathsf T}u)v^{\mathsf T}-u(v^{\mathsf T}v)u^{\mathsf T}-v(u^{\mathsf T}u)v^{\mathsf T}+v(u^{\mathsf T}v)u^{\mathsf T}=-\big(uu^{\mathsf T}+vv^{\mathsf T}\big),$$

using $u^{\mathsf T}v=0$ and $\lVert u\rVert=\lVert v\rVert=1$. Since $\omega^{\mathsf T}=-\omega$, this is $\omega\omega^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_{P}$, the orthogonal projection onto $P=\langle u,v\rangle$: it is symmetric, idempotent by orthonormality, and has range $P$. So (A)'s identity is correct.

**Which normalisation.** The record's inner product is the half-trace, and $\lVert\omega\rVert^2=\tfrac12\operatorname{tr}(\omega^{\mathsf T}\omega)=\tfrac12\operatorname{tr}\Pi_P=1$, so this $\omega$ is a unit $2$-form and agrees with $\pm\varphi_{ab}$ in a frame adapted to $P$: for $u=e_1,v=e_2$ the matrix is $E_{12}-E_{21}=-\varphi_{12}$, and the sign is invisible to $\omega\omega^{\mathsf T}$. The trace-$2$ clause of L180 is the check the brief asks for and it is decisive, a rank-two orthogonal projection being the only positive semidefinite matrix of trace $2$ with a two-dimensional range: under the alternating-tensor convention $u\wedge v=\tfrac12(u\otimes v-v\otimes u)$ one gets $\omega\omega^{\mathsf T}=\tfrac14\Pi_P$ of trace $\tfrac12$, and (A) would be a multiple of a projection rather than one. So (A) is true under exactly one of the two conventions in circulation, and the record's own trace-$2$ clause selects it. **CONFIRMED AS ALGEBRA.**

**Arguing the opposite.** No defect is available here. The only way to break the identity is to change the normalisation, and L180's own trace clause forbids that, so nothing is withdrawn and nothing is charged.

## 2. (A)'s scope: L180 assumes every $\lambda_i\ne0$

L180's statement carries "every $\lambda_i\ne0$", and the block applies (1) to the full eigenbasis of an all-decomposable point, which has $\binom n2$ members and, at any Ricci-flat member of the witness family or at any padded object, weights that vanish. The block's use is therefore outside L180's stated hypotheses.

The mathematics survives, and cheaply. L180(1)'s proof is the contraction $\sum_bW_{abcb}=\sum_i\lambda_i\sum_b(\omega_i)_{ab}(\omega_i)_{cb}=\big(\sum_i\lambda_i\omega_i\omega_i^{\mathsf T}\big)_{ac}$, which never touches the hypothesis: a term with $\lambda_\alpha=0$ contributes zero to $W$ and zero to the sum, so adjoining zero-weight eigenforms changes neither side. The nonzero hypothesis is spent in L180(3), where the sign pattern of a rank-three spectrum is the whole argument, and nowhere in (1).

So the block owes one sentence, and the honest form of it is positive rather than defensive: *(1) holds over any orthonormal family with any real weights, the zero terms contributing zero on both sides, and L180 states it over the nonzero spectrum because (3) needs that.* **GAP**, at [diagonal-half.md:1110](../findings/diagonal-half.md#L1110), repairable in place.

**Arguing the opposite.** One could read the block's $\sum_\alpha$ as running over the nonzero spectrum alone, which stays inside L180. That reading breaks (A)'s own use: $\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0$ is quoted as the whole content of Ricci-flatness "on the all-decomposable set", and the all-decomposable set is defined by every eigenform being decomposable, zero-weight ones included. It also breaks (E), whose weight space is a linear space in all $\binom n2$ coordinates and whose boundary strata have zeros. So the wider reading is the intended one and the gap is real.

## 3. (A) as an equivalence

Ricci-flatness is $\mathrm{Ric}=0$ with $\mathrm{Ric}_{ac}=\sum_bW_{abcb}$, and §2's contraction shows $\mathrm{Ric}=\sum_\alpha\lambda_\alpha\omega_\alpha\omega_\alpha^{\mathsf T}$ identically, for every symmetric $W$ written in spectral form. With §1 this is $\mathrm{Ric}=\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}$ on the all-decomposable set. The two conditions are therefore the same equation entry by entry, and "reads" is exact rather than one-directional. **CONFIRMED.**

One caution worth writing down, since it is where §6's refutation lives. The map from configurations to the identity forgets: $\Pi_{P_\alpha}$ sees the plane and not the form, and the eigen-*basis* is not determined by $W$ inside a degenerate eigenspace. The equation is equivalent to Ricci-flatness at fixed eigen-data, and a conclusion drawn about "those planes" is a conclusion about the chosen basis rather than about $W$.

## 4. (B)'s inference is a converse, and it fails

[diagOp_ric](../lean/HamiltonsCubic/Base/Families.lean#L203) states, for $w$ symmetric, $\mathrm{Ric}(\mathrm{diagOp}\,w)_{ab}=\big(\sum_cw_{ac}-w_{aa}\big)\delta_{ab}$. Its contrapositive is: *if the Ricci matrix computed in a frame $F$ has a nonzero off-diagonal entry, then $W$ is not diagonal in the coordinate $2$-planes of $F$.* The block's "a frame-mixing detector and nothing else" asserts more, that a nonzero off-diagonal entry certifies the planes admit no common frame. That is the converse and it is false, because the Ricci matrix is a tensor and its entries are frame-dependent while the existence of a common frame is not.

**Closed-form refutation.** Let $n=4$ and $W=\varphi_{12}\otimes\varphi_{12}$, that is $\mathrm{diagOp}\,w$ with $w_{12}=w_{21}=1$ and every other entry zero. $W$ is coordinate-diagonal by construction: its six eigenforms are the coordinate $2$-forms of the standard frame, at weights $(1,0,0,0,0,0)$. By §1, $\mathrm{Ric}=\Pi_{\langle e_1,e_2\rangle}=\operatorname{diag}(1,1,0,0)$, which agrees with the row sums. Now read the same tensor in the frame $\{e_1,g_2,g_3,e_4\}$: conjugating by the rotation gives

$$\mathrm{Ric}'_{23}=\cos t\sin t\,\big(r_2-r_3\big)\cdot(\pm1)=\mp\tfrac12\sin2t\ne0,\qquad r_2=1,\ r_3=0.$$

So a nonzero off-diagonal entry coexists with a $W$ whose planes do share a frame. The detector detects "not diagonal in the frame you computed in", which is strictly weaker than "diagonal in no frame", and it is the latter that step three needs. **REFUTED.**

**And the detector is silent where step three lives.** Ricci-flatness is $\mathrm{Ric}=0$, a frame-independent statement, so at every point of the intended application every off-diagonal entry in every frame vanishes. The off-diagonal entries carry exactly zero information about a Ricci-flat configuration, and the crux (C) is a question about the joint content of the vanishing diagonal *and* the vanishing off-diagonal. Calling the off-diagonal "the handle" inverts this. **REFUTED AS STATED.**

**What survives, stated positively.** The off-diagonal entries are the obstruction a candidate must kill in order to be Ricci-flat at all, and killing them is a set of weight equalities. That is exactly [r846](REVIEW_r846.md)'s use at the witness and exactly the mechanism (E) then exploits in §10, where the single off-diagonal entry forces $\mu_1=\mu_2$. So the block should keep the entry and drop the epistemology around it.

**Arguing the opposite.** One might defend "and nothing else" by fixing the frame in advance, reading the sentence as "relative to the frame of computation the off-diagonal entries measure exactly the mixing". That reading is true and useless: the frame of computation is the one in which the mixed configuration was written down, so the entry then measures a mixing that was put in by hand, and it still says nothing about the existence of another frame. Both readings leave the block's inference unsupported, so nothing here is withdrawn.

## 5. (B)'s witness value, in closed form

Work with (E)'s family at general $n$, which at $n=4$ is the witness of (iii) verbatim: planes $\langle e_1,g_j\rangle$ for $j=2,\dots,n$ with weights $\lambda_{1j}$, and $\langle e_j,e_k\rangle$ for $2\le j<k\le n$ with weights $\mu_{jk}$. By §1,

$$S:=\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=\Big(\sum_j\lambda_{1j}\Big)e_1e_1^{\mathsf T}+\sum_j\lambda_{1j}\,g_jg_j^{\mathsf T}+\sum_{j<k}\mu_{jk}\big(e_je_j^{\mathsf T}+e_ke_k^{\mathsf T}\big).$$

Every term is diagonal in the standard frame except $g_2g_2^{\mathsf T}$ and $g_3g_3^{\mathsf T}$, and

$$g_2g_2^{\mathsf T}=c^2e_2e_2^{\mathsf T}+cs\big(e_2e_3^{\mathsf T}+e_3e_2^{\mathsf T}\big)+s^2e_3e_3^{\mathsf T},\qquad g_3g_3^{\mathsf T}=s^2e_2e_2^{\mathsf T}-cs\big(e_2e_3^{\mathsf T}+e_3e_2^{\mathsf T}\big)+c^2e_3e_3^{\mathsf T}.$$

Hence the only off-diagonal entry of $S$ is

$$S_{23}=cs\,\big(\lambda_{12}-\lambda_{13}\big)=\tfrac12\sin2t\,\big(\lambda_{12}-\lambda_{13}\big),$$

at every $n$, and it is unique as an unordered pair of indices. This is the block's value with $\lambda_1=\lambda_{12}$ the weight of $e_1\wedge g_2$ and $\lambda_2=\lambda_{13}$ that of $e_1\wedge g_3$, and it agrees with [r846](REVIEW_r846.md)'s $\mathrm{Ric}_{23}=\tfrac12\sin2t\,(\mu_1-\mu_2)$. **CONFIRMED.**

**Index convention, since the brief asks.** $(2,3)$ indexes vectors of $\mathbb R^n$ counted from $e_1$, so it is the $e_2$-$e_3$ entry. $\lambda_1$ and $\lambda_2$ index *forms* in the block's own ordering of the eigenbasis, so the same sentence carries two different index sets three symbols apart. Writing $\lambda_{e_1\wedge g_2}$ and $\lambda_{e_1\wedge g_3}$, or $\mu_1,\mu_2$ as the witness paragraph does, removes the hazard.

*Screen, reported as a screen.* The family was built at $n=4,5,6$ with $t=0.7$, orthonormality and rank two confirmed for every member, and $S$ evaluated at the weight vectors below: it matched the closed forms to $10^{-16}$.

## 6. (C) is false as stated, refuted by the block's own witness

(C) reads: *$\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0$, over the planes of an orthonormal basis of decomposable forms, forces those planes into a common frame.* Take the block's own $n=4$ witness, which is (E)'s family at $n=4$: the six planes

$$\langle e_1,g_2\rangle,\quad\langle e_1,g_3\rangle,\quad\langle e_1,e_4\rangle,\quad\langle e_2,e_3\rangle,\quad\langle e_2,e_4\rangle,\quad\langle e_3,e_4\rangle$$

with weights $\lambda=(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$ in that order. From §5's display, with $\lambda_{12}=\lambda_{13}=\tfrac12$, $\lambda_{14}=-1$, $\mu_{23}=-1$, $\mu_{24}=\mu_{34}=\tfrac12$:

- $e_1$: $\tfrac12+\tfrac12-1=0$.
- $e_2$: $c^2\cdot\tfrac12+s^2\cdot\tfrac12+\mu_{23}+\mu_{24}=\tfrac12-1+\tfrac12=0$.
- $e_3$: $s^2\cdot\tfrac12+c^2\cdot\tfrac12+\mu_{23}+\mu_{34}=0$.
- $e_4$: $-1+\tfrac12+\tfrac12=0$.
- $(2,3)$: $cs(\tfrac12-\tfrac12)=0$, and every other off-diagonal entry is zero by §5.

So $\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0$ with all six weights nonzero, which also puts the configuration inside L180's hypotheses.

**Those planes are in no common frame.** A frame whose six coordinate planes are these six would have each of its four vectors lying in three of them, since a frame vector lies in exactly three coordinate planes. Count the lines lying in three or more of the six: $\mathbb Re_1$ lies in the first three, $\mathbb Re_4$ in the third, fifth and sixth, $\mathbb Re_2$ in the fourth and fifth only, $\mathbb Re_3$ in the fourth and sixth only, $\mathbb Rg_2$ in the first and fourth only, $\mathbb Rg_3$ in the second and fourth only, and any further line lies in an intersection of two distinct planes and so is one of these. The remaining pairwise intersections are zero: $\alpha e_1+\beta g_2\in\langle e_2,e_4\rangle$ forces $\alpha=0$ and $\beta s=0$, and $\alpha e_1+\beta g_2\in\langle e_3,e_4\rangle$ forces $\alpha=0$ and $\beta c=0$, both impossible for $\sin2t\ne0$. So exactly two lines lie in three planes and a frame needs four. **(C) as stated is REFUTED**, by the record's own witness, at the same parameter range the block relies on elsewhere. This reproduces [r846](REVIEW_r846.md)'s line count independently, and here it is turned against (C) rather than against the diagonality of a non-flat member.

**What is true instead, and it is a different statement.** The identity does not constrain the *chosen* eigenbasis into a frame, it constrains $W$. Where eigenvalues repeat the eigenbasis is not determined, and the witness has $\tfrac12$ with multiplicity four. Re-choosing $e_1\wedge e_2,e_1\wedge e_3$ inside $e_1\wedge\langle e_2,e_3\rangle$ turns the same $W$ into the coordinate-diagonal operator with weights $w_{12}=w_{13}=w_{24}=w_{34}=\tfrac12$ and $w_{14}=w_{23}=-1$, whose row sums vanish. So the crux has to be stated as: *there EXISTS an orthonormal decomposable eigenbasis whose planes lie in a common frame*, equivalently $W$ is coordinate-diagonal. This is precisely (E)'s collapse argument, promoted from a remark about one family to the statement of step three, and it swallows step four.

### 6b. The repaired crux, proved at $n=4$

**Theorem (r850).** *Let $\{\omega_\alpha\}_{\alpha=1}^{6}$ be an orthonormal basis of $\Lambda^2\mathbb R^4$ of decomposable forms and $\lambda\in\mathbb R^6$ with $\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0$. Then $W=\sum_\alpha\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$ is coordinate-diagonal.*

*Set-up.* Write $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ and fix the unit bases $\sigma_i=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34}),\ \tfrac1{\sqrt2}(\varphi_{13}+\varphi_{42}),\ \tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23})$ and $\bar\sigma_i$ with the minus signs. Then $\sigma_i^2=\bar\sigma_i^2=-\tfrac12\mathrm{Id}$, distinct $\sigma$'s anticommute, and every $\sigma_i$ commutes with every $\bar\sigma_j$. Write $\omega=\tfrac1{\sqrt2}(a,b)$ for $\omega=\tfrac1{\sqrt2}\big(\sum a_i\sigma_i+\sum b_i\bar\sigma_i\big)$. Decomposability is $\lVert\omega^+\rVert=\lVert\omega^-\rVert$, so a unit decomposable form has $a,b$ unit vectors of $\mathbb R^3$, and orthogonality of two of them is $\langle a,a'\rangle+\langle b,b'\rangle=0$.

*Step 1, the identity in these coordinates.* Expanding $\omega^2$ and using the three relations above,

$$\Pi_P=-\omega^2=\tfrac12\mathrm{Id}-\sum_{i,j}a_ib_j\,\sigma_i\bar\sigma_j .$$

The nine $\sigma_i\bar\sigma_j$ are symmetric, traceless and linearly independent, being an orthogonal basis of $S^2_0(\mathbb R^4)$. Hence, with $M(\lambda)=\sum_\alpha\lambda_\alpha\,a_\alpha b_\alpha^{\mathsf T}$,

$$\sum_\alpha\lambda_\alpha\Pi_{P_\alpha}=0\iff\sum_\alpha\lambda_\alpha=0\ \text{ and }\ M(\lambda)=0 .$$

*Step 2, what $M=0$ says.* $M(\lambda)=0$ is exactly the vanishing of $W$'s $\Lambda^+\otimes\Lambda^-$ block, so $W=A\oplus C$ with $A$ on $\Lambda^+$ and $C$ on $\Lambda^-$, and $\operatorname{tr}A=\operatorname{tr}C=0$ by $\sum\lambda_\alpha=0$ together with $\lVert a_\alpha\rVert=\lVert b_\alpha\rVert$. Each $\omega_\alpha$ is an eigenform of $W$ at $\lambda_\alpha$, and both halves are nonzero by decomposability, so $Aa_\alpha=\lambda_\alpha a_\alpha$ and $Cb_\alpha=\lambda_\alpha b_\alpha$ for every $\alpha$. Orthonormality of the basis gives $\sum_\alpha\omega_\alpha\otimes\omega_\alpha=\mathrm{Id}$, whose diagonal blocks read $\sum_\alpha a_\alpha a_\alpha^{\mathsf T}=\sum_\alpha b_\alpha b_\alpha^{\mathsf T}=2\,\mathrm{Id}_3$.

*Step 3, the case split on $A$.* $A$ is symmetric and traceless on $\mathbb R^3$.

- **Three distinct eigenvalues** $p_1,p_2,p_3$ with unit eigenvectors $u_i$. Every $a_\alpha$ is one of $\pm u_i$, and $\sum_\alpha\langle a_\alpha,u_i\rangle^2=2$ forces each direction to occur exactly twice. So each $p_i$ occurs exactly twice among the $\lambda_\alpha$, hence lies in $\operatorname{spec}C$, hence $C$ also has three distinct simple eigenvalues with unit eigenvectors $v_i$. The two forms with $a=\pm u_i$ have $b=\pm v_i$, and orthogonality $\langle a,a'\rangle+\langle b,b'\rangle=0$ forces the two signs opposite. So the basis is $\big\{\tfrac1{\sqrt2}(u_i,\pm v_i)\big\}$ up to individual signs.
- **One repeated eigenvalue**, $\operatorname{spec}A=\{\mu,\mu,\nu\}$ with $2\mu+\nu=0$ and $\mu\ne\nu$, plane $\Pi^A$ and axis $u_3$. Projecting $\sum a_\alpha a_\alpha^{\mathsf T}=2\,\mathrm{Id}_3$ onto $u_3$ gives exactly two $\alpha$ with $\lambda_\alpha=\nu$, and the other four have $a_\alpha\in\Pi^A$. Both $\mu$ and $\nu$ lie in $\operatorname{spec}C$, and $\operatorname{tr}C=0$ excludes the splitting $\{\mu,\nu,\nu\}$ (which with $2\mu+\nu=0$ forces $\mu=\nu=0$), so $\operatorname{spec}C=\{\mu,\mu,\nu\}$ with plane $\Pi^C$ and axis $v_3$.
- **All eigenvalues equal**, hence $A=0$ and every $\lambda_\alpha=0$, so $W=0$.

*Step 4, exhibiting the frame.* In the first case take $u_i,v_i$ as they stand. In the second take any orthonormal $u_1,u_2$ of $\Pi^A$ and $v_1,v_2$ of $\Pi^C$, together with $u_3,v_3$. In both cases the six forms $\tfrac1{\sqrt2}(u_i,\pm v_i)$ are unit, decomposable, pairwise orthogonal, and eigenforms of $W=A\oplus C$, since $Au_i$ and $Cv_i$ carry the same eigenvalue by construction. A configuration of that shape is the coordinate $2$-form basis of an orthonormal frame: $SO(4)\to SO(3)\times SO(3)$ is onto, so once both triples are positively oriented there is $R\in SO(4)$ carrying the standard configuration $\big\{\tfrac1{\sqrt2}(\epsilon_i,\pm\epsilon_i)\big\}$ to it, and if a triple comes out negatively oriented, replacing $u_1$ by $-u_1$ fixes the orientation while permuting the pair $\tfrac1{\sqrt2}(u_1,\pm v_1)$ within its own two lines. Hence the coordinate $2$-forms of the frame $\{Re_i\}$ are eigenforms of $W$, which is coordinate-diagonality. $\square$

So at $n=4$ the all-decomposable Ricci-flat locus is exactly the coordinate-diagonal locus, which is an independent confirmation of [r847](REVIEW_r847.md)'s affirmative answer at $n=4$ restricted to this branch, reached without the $\mathfrak b$ test. **The repaired crux is CONFIRMED AT $n=4$.** At $n\ge5$ it is open, and the proof gives nothing there: every step above runs on the $\Lambda^\pm$ splitting, which exists only at $n=4$.

*Screen, reported as a screen.* Step 1's identity was checked against three random decomposable forms at $10^{-16}$, and the nine $\sigma_i\bar\sigma_j$ were confirmed symmetric, traceless and of rank nine.

## 7. (C)'s step four is not free

"An eigenspace with equal eigenvalues is frame-independent inside its own plane" is well posed only when the eigenspace has the shape $u\wedge V$ for a line $\mathbb Ru$ and a subspace $V$, which is the witness's $e_1\wedge\langle e_2,e_3\rangle$: there "its own plane" is $\langle e_2,e_3\rangle$, every element is decomposable, and any orthonormal pair of $V$ gives a decomposable orthonormal basis of the eigenspace. That much is true.

Above dimension two, and even at dimension two off that shape, the phrase names nothing. Two examples, both of them two-dimensional eigenspaces.

- $E=\langle e_1\wedge g_2,\ e_4\wedge g_3\rangle$, the two planes being orthogonal complements. A general element $\alpha\,e_1\wedge g_2+\beta\,e_4\wedge g_3$ has rank four unless $\alpha\beta=0$, so $E$ contains exactly two decomposable lines and admits no re-choosing at all. It has no plane of its own.
- The four-dimensional $\mu$-eigenspace of §6b's second case is $\Pi^A\oplus\Pi^C$ in the $\Lambda^\pm$ coordinates, whose decomposable elements form a two-torus of lines rather than a pencil through a line, and picking a frame-compatible orthonormal quadruple inside it is exactly the work of §6b's step 4, including the surjectivity of $SO(4)\to SO(3)\times SO(3)$.

So step four is where the content of the repaired step three sits, and describing it as free is the same error as (C)'s quantifier: it presumes the eigenspace already has the witness's pencil shape. **REFUTED AS STATED.**

**Arguing the opposite.** If step three were true as written, then step four would indeed be a formality, since the given planes would already be a frame's coordinate planes and there would be nothing to re-choose. That defence is unavailable precisely because §6 refutes step three, and the two errors are one error counted twice: the route splits into "get a frame for these planes" and "the planes were flexible anyway", and the truth is a single existential statement.

## 8. (D)'s witness, checked rather than assumed

Let $w$ be the weight matrix of the four-cycle $1$–$2$–$3$–$4$–$1$ on $\mathbb R^4$: $w_{12}=1$, $w_{23}=-1$, $w_{34}=1$, $w_{41}=-1$, all other entries zero, and $W=\mathrm{diagOp}\,w$.

- **Coordinate-diagonal.** By construction, its eigenform at $\varphi_{ab}$ has eigenvalue $w_{ab}$, so the coordinate $2$-forms of the standard frame are eigenforms.
- **Ricci-flat.** $w$ is symmetric and hollow with row sums $r_1=1+0-1=0$, $r_2=1-1+0=0$, $r_3=0-1+1=0$, $r_4=-1+0+1=0$, so [diagOp_ric](../lean/HamiltonsCubic/Base/Families.lean#L203) gives $\mathrm{Ric}=0$. It is a Weyl tensor, the weight matrix satisfying the hollow, symmetric, zero-row-sum conditions.
- **The eigenvalues.** $e_1\wedge e_2$ carries $w_{12}=1$ and $e_1\wedge e_3$ carries $w_{13}=0$, and the two planes meet in $\mathbb Re_1$.

So Ricci-flatness does not force equal eigenvalues on two decomposable eigenforms whose planes share a line, and (D)'s refutation of the earlier step three is sound. **CONFIRMED.**

**The zero-eigenvalue objection, and its closure.** The brief is right that L180 assumes nonzero eigenvalues and that this witness has $\lambda=0$ on $\varphi_{13}$, so a reader could rescue the earlier step three by restricting it to nonzero eigenvalues. That rescue fails too, in closed form. On $\mathbb R^4$ solve the zero-row-sum conditions with $w_{12}=2$ and $w_{13}=1$ prescribed: $w_{14}=-3$ from row $1$, and then rows $2,3,4$ give $w_{23}=-3$, $w_{24}=1$, $w_{34}=2$. Every row sum is zero, the six weights $(2,1,-3,-3,1,2)$ are nonzero, and $e_1\wedge e_2$ and $e_1\wedge e_3$ share $\mathbb Re_1$ at eigenvalues $2$ and $1$. So the refuted step three fails on a rank-six Ricci-flat Weyl tensor inside L180's hypotheses, and (D) is stronger than the block claims. **CONFIRMED, STRENGTHENED.** The solution's pattern, opposite edges equal, is [r847](REVIEW_r847.md)'s recorded consequence of Ricci-flatness on the coordinate-diagonal locus, and it is what makes the system solvable at all.

## 9. (E)'s construction is an orthonormal basis of decomposable forms

Take $\{e_1\wedge g_j\}_{j=2}^{n}$ and $\{e_j\wedge e_k\}_{2\le j<k\le n}$, with $g_2,g_3$ the rotated pair and $g_j=e_j$ for $j\ge4$.

- **Count.** $(n-1)+\binom{n-1}2=\binom n2$, since $\binom{n-1}1+\binom{n-1}2=\binom n2$.
- **Decomposable and unit.** Each is a wedge of two orthonormal vectors, so §1 applies and each has norm one and rank two.
- **Orthogonality within the first group.** $\langle e_1\wedge g_j,e_1\wedge g_k\rangle=\langle e_1,e_1\rangle\langle g_j,g_k\rangle-\langle e_1,g_k\rangle\langle g_j,e_1\rangle=0$, the $g_j$ being orthonormal and every one of them orthogonal to $e_1$.
- **Orthogonality within the second group.** Distinct coordinate pairs, orthonormal by convention.
- **The cross terms, which the brief singles out.** $\langle e_1\wedge g_j,\ e_l\wedge e_m\rangle=\langle e_1,e_l\rangle\langle g_j,e_m\rangle-\langle e_1,e_m\rangle\langle g_j,e_l\rangle=0$ for $2\le l<m$, because $e_1$ is orthogonal to both $e_l$ and $e_m$. The rotation never enters.

Orthonormality plus the count gives a basis, at every $n\ge2$ and every $t$. **CONFIRMED**, and at $n=4$ this is the witness of (iii) verbatim, including $e_2\wedge e_3=g_2\wedge g_3$.

*Screen, reported as a screen.* Built at $n=4,5,6$ with $t=0.7$: Gram matrix equal to the identity and every member of rank two.

## 10. (E)'s "every direction has $\mu_1=\mu_2$" is two lines, not a screen

By §5 the only off-diagonal entry of $S$ is $S_{23}=\tfrac12\sin2t\,(\lambda_{12}-\lambda_{13})$. Ricci-flatness includes $S_{23}=0$, and $\sin2t\ne0$ is the family's own admissibility hypothesis, so

$$\lambda_{12}=\lambda_{13},$$

the two weights of $e_1\wedge g_2$ and $e_1\wedge g_3$, at every $n$ and on every Ricci-flat direction. The single off-diagonal entry does it alone, with no other equation consumed. So the screen is replaceable and should be replaced. **CONFIRMED AS ALGEBRA.**

**The dimension figures come from the same two lines.** Once $\lambda_{12}=\lambda_{13}=a$, the rotation drops out of the diagonal as well, since $c^2a+s^2a=a$ in both the $e_2$ and $e_3$ entries. The identity then reads exactly the vanishing-row-sum conditions of the standard-frame weight matrix $w$ with $w_{1j}=\lambda_{1j}$ and $w_{jk}=\mu_{jk}$. So

$$\{\text{Ricci-flat directions}\}=\{w\ \text{hollow symmetric}:\ \text{all row sums}\ 0,\ w_{12}=w_{13}\},$$

of dimension $\binom n2-n-1$: the row-sum map on hollow symmetric matrices is the incidence map of $K_n$, of rank $n$ for $n\ge3$ because $K_n$ is connected and non-bipartite, and the functional $w_{12}-w_{13}$ is independent of it, being nonzero on the four-cycle weight $(1,-1,1,-1)$, which has vanishing row sums. That gives $1$ at $n=4$, $4$ at $n=5$ and $8$ at $n=6$, matching the block's screened $1$ and $8$ exactly. So the whole screened paragraph is a derivation.

*Screen, reported as a screen.* The null space of the linear system was computed at $n=4,5,6$ with $t=0.7$: dimensions $1,4,8$ as predicted, and $\lambda_{12}-\lambda_{13}=0$ on every basis direction to $10^{-16}$.

## 11. (E)'s collapse holds at every $n$

With $\lambda_{12}=\lambda_{13}$ the two forms $e_1\wedge g_2,e_1\wedge g_3$ carry one eigenvalue, so their span $e_1\wedge\langle e_2,e_3\rangle$ is inside a single eigenspace and any orthonormal pair of $\langle e_2,e_3\rangle$ gives an equally valid decomposable eigenbasis of it. Choose $e_1\wedge e_2,e_1\wedge e_3$. Every other member of the family is already a standard-frame coordinate form: $e_1\wedge g_j=e_1\wedge e_j$ for $j\ge4$, and the second group is standard by construction. So the resulting eigenbasis is the coordinate $2$-form basis of the standard frame and the point is coordinate-diagonal there, at every $n$. Nothing else obstructs, and the larger weight space at $n\ge5$ is irrelevant, every one of its directions satisfying the one equality the collapse consumes. **CONFIRMED.**

At $n=4$ the collapsed operator is $w_{12}=w_{13}=w_{24}=w_{34}=\tfrac12$ with $w_{14}=w_{23}=-1$, that is the four-cycle $1$–$2$–$4$–$3$–$1$ at $\tfrac12$ plus the two remaining edges at $-1$, whose row sums vanish. This is the family's Ricci-flat member written in the frame that diagonalises it, and it makes the collapse concrete rather than existential.

## 12. What is already on the record

**GAP, one site, and it is (A) entire.** [L185](../findings/diagonal-half.md#L662)'s proof, recorded 2026-09-09 and Gate-2 landed by r798 and r799, opens: *"Ricci-flatness of $W$ is $\sum\lambda_i\omega_i\omega_i^{\mathsf T}=0$ ([L180](../findings/diagonal-half.md#L895)(1)), and a unit decomposable $\omega_i$ is the area form of a plane $P_i$ with $\omega_i\omega_i^{\mathsf T}=\Pi_i$, the orthogonal projection. So Ricci-flatness reads $\sum\lambda_i\Pi_i=0$."* That is (A)'s specialisation, its conclusion and its notation, one day older than the block and uncited by it. The block's "the specialisation is one line" is right about the length and wrong about the novelty.

Searched by the object rather than by the words: "orthogonal projection" and "$\Pi$" across [findings/](../findings/), "signed sum", "common frame" and "frame-mixing" across [findings/](../findings/) and the two prior reviews, and [L180](../findings/diagonal-half.md#L895) with its neighbours [L181](../findings/diagonal-half.md#L915), [L185](../findings/diagonal-half.md#L662) and [L186](../findings/diagonal-half.md#L670) read in full. Two further partial sites, both weaker than (A) and neither a duplicate of it: [L186](../findings/diagonal-half.md#L670)'s rank note writes Ricci-flatness as $\lvert\lambda_1\rvert\omega_1\omega_1^{\mathsf T}+\lvert\lambda_2\rvert\omega_2\omega_2^{\mathsf T}=\lvert\lambda_3\rvert\Pi_3$, and [L181](../findings/diagonal-half.md#L915) computes $\omega_i\omega_i^{\mathsf T}$ block by block on a plane splitting, which is (A) restricted to a common frame. Nothing on the record states (B), (C) or (E), and the value in (B) is [r846](REVIEW_r846.md)'s, correctly credited by the block.

## 13. Withdrawn candidates

Two defects were proposed during this review and neither survived its own counter-argument, so both are withdrawn rather than reported.

- **"(E)'s family is a rotated frame in disguise, so the collapse is vacuous."** It is not: the six planes lie in no common frame at $\sin2t\ne0$, by §6's line count, so the family genuinely leaves the coordinate-diagonal locus and the collapse is about its Ricci-flat sub-locus alone. Withdrawn.
- **"(C) can be broken by two rotated pairs whose off-diagonal contributions cancel."** Built the candidate: at $n=4$ take $e_1\wedge g_2,e_1\wedge g_3,e_4\wedge h_2,e_4\wedge h_3,e_1\wedge e_4,e_2\wedge e_3$ with $h$ the rotation by $u$ in $\langle e_2,e_3\rangle$, which is an orthonormal decomposable basis for every $t,u$. The $\langle e_2,e_3\rangle$ block of $S$ is $\tfrac{p-q}2\,n(2t)+\tfrac{r-s}2\,n(2u)$ plus a multiple of the identity, with $n(\theta)$ the unit traceless direction at angle $\theta$. Cancellation with $p\ne q$ needs $n(2u)=-n(2t)$, that is $u=t+\tfrac\pi2$, and then $h_2=g_3$ and $h_3=-g_2$, so the configuration is the coordinate basis of the single rotated frame $\{e_1,g_2,g_3,e_4\}$ and has a common frame after all. Withdrawn, and §6b then closes the whole $n=4$ case, so no such construction exists there.

## 14. What would break the route, and how I looked

**The route dies if there is an all-decomposable Ricci-flat point that is coordinate-diagonal in no frame.** That is the negation of the repaired crux, and it is what a falsifier has to be. Note the literal (C) is already false and its failure does not kill the route, which is the distinction §6 turns on.

Where I looked, analytically and within the standing rule.

- **At $n=4$, exhaustively.** §6b proves no such point exists, by the $\Lambda^\pm$ reduction and a three-case split on the spectrum of $A$. The $n=4$ instance of the crux is therefore closed in the affirmative, and closed independently of the $\mathfrak b$ test.
- **Inside the two-orthonormal-triples family at $n=4$.** In the $S^2\times S^2$ coordinates a decomposable orthonormal basis is six unit $a_\alpha$ with $\sum a_\alpha a_\alpha^{\mathsf T}=2\,\mathrm{Id}_3$ together with the complementary $b$. Taking the $a$'s to be two orthonormal triples related by $Q$ gives $M(\lambda)=D-QD'Q^{\mathsf T}$, so the identity is $D=QD'Q^{\mathsf T}$ with both diagonal, which forces $Q$ to be a signed permutation when $D$ is simple, and otherwise puts $D$ at a repeated pair, which is the witness. So this family is exhausted and contains no falsifier. It also shows the generic decomposable basis carries no Ricci-flat weight at all: the map $\lambda\mapsto M(\lambda)$ always kills $\mathbf 1$ and generically nothing else, and $\mathbf 1$ fails tracelessness.
- **At $n\ge5$, where the route actually needs the crux.** I did not look by search, the standing rule forbidding it, and I name the shape instead: the $\Lambda^\pm$ splitting has no analogue, the count of orthonormal decomposable bases grows, and a falsifier would need at least two independent frame mixings whose off-diagonal contributions cancel without any weight degeneracy. §13's withdrawn attempt shows why that is hard inside one rotation plane and says nothing about mixings in different planes at $n\ge5$, which is exactly the open direction. The honest state of the route is that step three is proved at $n=4$, unproved at $n\ge5$, and mis-stated everywhere.

**The second thing that would break the route is quieter, and it is already here.** If step three is stated existentially, then the route's steps three and four collapse into one statement, and the block's inventory of "steps one and two are done, three is owed, four is free" over-counts what is finished. Steps one and two are unaffected.

## Overall verdict

**The algebra of the block is sound and its crux is mis-stated.** (A) is correct under the record's own normalisation and is a re-derivation of [L185](../findings/diagonal-half.md#L662)'s recorded proof line, with an unstated extension past L180's nonzero hypothesis. (B)'s "and nothing else" is a converse and is refuted in closed form, and the detector reads identically zero at every Ricci-flat point, which is the only place step three lives. (C) is refuted as stated by the block's own witness, and its repair, quantified over decomposable eigenbases rather than over one of them, is proved here at $n=4$ and remains open at $n\ge5$, where the route needs it. Step four is not free and carries the repair. (D) is sound, and stronger than the block claims, the zero-eigenvalue objection being closed by the weights $(2,1,-3,-3,1,2)$. (E) is correct throughout and every one of its screened figures is derivable in two lines, the equality $\mu_1=\mu_2$ from the single off-diagonal entry and the dimensions from $\binom n2-n-1$.
