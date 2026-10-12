# r826: Gate 2 on the stabiliser blocks, and an audit of r827's closure of the dimension-two case

*Cold brief. I was given Claim A and Claim B verbatim, read [findings/diagonal-half.md](../findings/diagonal-half.md) at [line 794](../findings/diagonal-half.md#L794) and [line 802](../findings/diagonal-half.md#L802) in context, and read [r824](REVIEW_r824.md) and [r825](REVIEW_r825.md) in full. **The programme is on an analysis-only footing. I ran no computation of any kind, not even a screen**: every bracket, dimension and signature below was worked by hand and is exact. Log: [agent_logs/g2-stabiliser-r826.log](../agent_logs/g2-stabiliser-r826.log).*

**Claim A was reassigned mid-round.** The coordinator narrowed my brief after [r827](REVIEW_r827.md) filed, asking me to spend the round auditing r827's new closure of the dimension-two stabiliser case instead. I had already finished Claim A when the message arrived, so §1 to §3 record what I had, in short form, and §4 onward is the audit that was asked for. **§4 is the part of this report to read.**

| What was checked | Verdict |
|---|---|
| **A1**: the padded family's stabiliser is exactly the maximal $4$ | **CONFIRMED**, by an independent derivation |
| **A2**: its orbit is exactly $11$-dimensional | **CONFIRMED** |
| **A3**: the family is *one orbit times the weight circle*, its image in $M/G$ a curve | **CURVE CONFIRMED, "ONE ORBIT" REFUTED.** At fixed $\lambda$ it is **two** orbits, and the image is two circles. Immaterial to every use made of it |
| **A4**: *a count refuted on one stratum is refuted as a predictor for that space* | **REFUTED.** Counted stratum by stratum a count legitimately survives, and I give a counterexample. Independently, the repair does not make the prediction Claim A attributes to it |
| **A5** (found, not asked): *the finite-stabiliser case cannot occur at all*, [line 790](../findings/diagonal-half.md#L790) and [r825](REVIEW_r825.md) §4 | **REFUTED BY EXHIBIT.** An explicit orthonormal triple with $\mathfrak z(U)=0$, brackets computed by hand. This sentence is in the record as a positive claim and is false |
| **B1**: subalgebra of a compact algebra is reductive, at dimension two abelian, hence a $2$-torus | **CONFIRMED**, with one step skipped that is standard and true |
| **B2**: the roots of $D_3$, and $\mathfrak z(\mathfrak t^2)=\mathfrak t^3$ for regular $\mathfrak t^2$ | **CONCLUSION CONFIRMED, JUSTIFICATION DEFECTIVE.** *"None has two zero coordinates"* proves the statement for coordinate $2$-planes only, and would prove there are no singular $2$-tori, which the same block then contradicts |
| **B3**: $U\subseteq\mathfrak z(\mathfrak z(U))$, and the regular case closes | **CONFIRMED** |
| **B4**: $\mathfrak z(\{(a,a,b)\})=\mathfrak u(2)\oplus\mathfrak u(1)$ of dimension $5$, *leaving room for a $3$-plane* | **CONFIRMED**, and I exhibit such a $3$-plane, so the room is real and not merely dimensional |
| **B5**: *the dimension-two case does not close* | **REFUTED.** It closes. I derived the closure independently before the narrowed brief arrived, and my argument and r827's are the same argument |
| **r827's closure**, the object I was asked to attack | **CONFIRMED as a result, with a GAP IN THE WRITE-UP that must be filled before it is recorded**: the rank-one step has a degenerate branch that the quoted argument does not visibly handle, and it is the only branch that is not immediate |
| **r827's "at any $\dim V$"** | **EARNED**, provided the reduction to $\mathfrak k$ is carried with it. The constraint computation uses no dimension hypothesis at all |

**One line.** *The dimension-two case is closed, and two independent derivations of the closure now exist, but the version quoted to me skips exactly the branch where the argument is tight, and it omits the conjugacy step that makes "$U\subseteq\mathfrak k$" follow from "$\dim\mathfrak z(U)=2$". Fill both and it stands. The live defect in the record is elsewhere: the sentence saying no triple has a finite stabiliser is refuted by a triple I write down.*

## 0. Setting, fixed once

$M$ is the $40$-dimensional space of orthonormal triples $(\omega_1,\omega_2,\omega_3)$ in $\Lambda^2\mathbb R^6$ together with a unit weight vector $\lambda$, $\sum_i\lambda_i=0$, every $\lambda_i\neq0$. $F=(\sum_i\lambda_i\omega_i^2,\ \sum_i\lambda_i\,\omega_i\wedge\omega_i)$ lands in $S^2_0\mathbb R^6\oplus\Lambda^4\mathbb R^6$ of dimension $35$. Under $\Lambda^2\mathbb R^6\cong\mathfrak{so}(6)$ the stabiliser of the triple has Lie algebra $\mathfrak z(U)$ for $U=\operatorname{span}(\omega_i)$. Norms are [L180](../findings/diagonal-half.md)'s, so a unit form has $\omega^2=-\tfrac12\Pi$ on its support when that support is $4$-dimensional and the form is $(anti)$self-dual.

## 1. A1, A2, A3: the padded family's arithmetic

**The stabiliser is exactly $4$, derived here rather than quoted.** With $P$ a $4$-plane and $U=\Lambda^+P$, split $\mathfrak{so}(6)=\mathfrak{so}(P)\oplus\mathfrak{so}(P^\perp)\oplus(P\otimes P^\perp)$, of dimensions $6+1+8=15$. In $\mathfrak{so}(P)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$ the centraliser of $\mathfrak{su}(2)_+=\Lambda^+P$ is $\Lambda^-P$, dimension $3$, because $\mathfrak{su}(2)$ has trivial centre. All of $\mathfrak{so}(P^\perp)=\Lambda^2P^\perp$ centralises, dimension $1$. The cross term $P\otimes P^\perp$ carries no $\mathfrak{su}(2)_+$-invariant vector, since $P$ carries none. So $\mathfrak z(\Lambda^+P)=\Lambda^-P\oplus\Lambda^2P^\perp$, **dimension exactly $4$**, and the orbit is $15-4=\mathbf{11}$. **A1 and A2 CONFIRMED.**

**The image in $M/G$ is a curve, and it is not one orbit.** $G$ fixes $\lambda$, so orbits lie in fixed-$\lambda$ slices and distinct $\lambda$ give distinct points of $M/G$: the image is $1$-dimensional, a **curve**. It is not *one* orbit times the circle. Fix $\lambda$ and $P$. Any $g\in O(6)$ with $g(\Lambda^+P)=\Lambda^+P$ preserves the common support $P$ of that $3$-space, so $g=(h,k)\in O(4)\times O(2)$. If $\det h=-1$ then $h$ carries $\Lambda^+P$ to $\Lambda^-P$, so the subgroup preserving $\Lambda^+P$ is $SO(4)\times O(2)$, whose image in $O(\Lambda^+P)$ is $SO(3)$ and not $O(3)$. **So the two orientation classes of orthonormal basis of $\Lambda^+P$ are two distinct orbits**, and the fixed-$\lambda$ slice is $2$ orbits, the image in $M/G$ two circles. **A3: curve CONFIRMED, "one orbit" REFUTED, and the correction changes nothing**, because a point would refute a prediction of emptiness just as a curve does. The only thing riding on curve-against-point is the size of the miss, $11$ against $10$.

## 2. A4: the inference, which is the item that was said to be most likely to overturn the resolution

**A count does legitimately apply stratum by stratum, so the inference is unsound as a general principle.** Here is the counterexample, closed form. Let $G=SO(3)$ act on $M=\mathbb R^3$ and take $F:\mathbb R^3\to\mathbb R^2$, $F(x)=(\lVert x\rVert^2,\lVert x\rVert^4)$, equivariant into a trivial target. The zero set is the origin. On the **principal** stratum $\mathbb R^3\setminus\{0\}$ the orbits are $2$-dimensional, the quotient is $1$-dimensional, the count reads $1-2=-1$ and predicts emptiness, and the principal stratum contains no solution: **the count is right there.** On the **singular** stratum $\{0\}$ the count is $\dim M^G-\dim N^G=0-2=-2$ and the truth is a point: **the count is wrong there.** One stratum refutes nothing about the other, and the mechanism of the failure, the collapse of the constraints where the symmetry is large, is exactly what the stratification is for.

**And independently of that principle, the repair does not make the prediction Claim A attributes to it.** [r824](REVIEW_r824.md) §6 derives $25$ against $35$ from a tube $G\times_H Z$ at a point with **finite** $H$, and then computes the padded stratum's own count in the same section, $\dim M^H=7$ against $\dim N^H=5$. So on the padded stratum the repair predicts $2$, not $-10$. Claim A's sentence *"the quotient repair predicts the same emptiness on the padded stratum"* is false about the repair. The padded stratum's own count is still wrong, by $2$ rather than by $10$, and that is the honest form of the objection.

**Argue the opposite.** The strongest reading of Claim A is that $\dim(M/G)=25$ is offered as a statement about $M/G$ as one space, in which case a solution anywhere in $M/G$ meets it. I grant that the phrase invites that reading. It is not what r824 wrote, which is stratum-qualified in the same sentence, and the reading that makes Claim A's inference work is the reading that makes r824's count a claim nobody defended. **A4 REFUTED**, and the settlement it carries is unearned. This agrees with [r827](REVIEW_r827.md), reached independently and before I saw it.

## 3. A5: a false sentence in the record, found while checking A4

**Located.** [findings/diagonal-half.md](../findings/diagonal-half.md) at [line 790](../findings/diagonal-half.md#L790): *"the 'finite stabiliser, $15$-dimensional orbit' case the note reasoned about cannot occur at all"*, imported from [r825](REVIEW_r825.md) §4, which states it as *"no triple in $\Lambda^2\mathbb R^6$ has a finite stabiliser"*.

**Exhibited.** Take
$$\omega_1=\tfrac{1}{\sqrt{21}}\big(e^{12}+2e^{34}+4e^{56}\big),\qquad \omega_2=e^{13},\qquad \omega_3=e^{15}.$$
These are orthonormal: each is unit, $\omega_1$ has no $e^{13}$ or $e^{15}$ component, and $e^{13}\perp e^{15}$. And $\dim V=6$, since $\omega_1$ has rank $6$. Now $\omega_1$ is regular, its three coefficients being distinct and nonzero, so $\mathfrak z(\omega_1)=\mathfrak t^3=\operatorname{span}(E_{12},E_{34},E_{56})$. Write $X=\theta_1E_{12}+\theta_2E_{34}+\theta_3E_{56}$. By hand, with $E_{ab}=e_ae_b^{\mathsf T}-e_be_a^{\mathsf T}$,
$$[E_{12},E_{13}]=-E_{23},\qquad [E_{34},E_{13}]=-E_{14},\qquad [E_{56},E_{13}]=0,$$
so $[X,\omega_2]=-\theta_1E_{23}-\theta_2E_{14}=0$ forces $\theta_1=\theta_2=0$, and the same computation on $\omega_3=E_{15}$ gives $[X,\omega_3]=-\theta_1E_{25}-\theta_3E_{16}$, forcing $\theta_1=\theta_3=0$. **Hence $\mathfrak z(U)=0$**, the stabiliser is finite and the orbit is $15$-dimensional.

**So the sentence is false**, and it is false in the direction that matters: the finite-stabiliser stratum is inhabited, indeed generic, which is precisely the stratum r824's repaired count is computed on. Under the charitable reading, *no solution has a finite stabiliser*, the sentence is not false but is unproved anywhere in the record, and it should not be asserted. **Either way it should be struck.** **A5 REFUTED.**

## 4. Claim B, step by step, and then the audit of r827's closure

### 4.1 B1, reductivity: correct, and it needs no closed subgroup

**The theorem, stated precisely.** *A compact Lie algebra is one carrying an $\operatorname{ad}$-invariant positive definite inner product. Every subalgebra of such an algebra inherits that inner product, and a Lie algebra with an invariant positive definite inner product is reductive, since the orthogonal complement of an ideal is an ideal, so the adjoint representation is completely reducible and $\mathfrak h=\mathfrak z(\mathfrak h)\oplus[\mathfrak h,\mathfrak h]$ with $[\mathfrak h,\mathfrak h]$ semisimple.* $\mathfrak{so}(6)$ is compact with the trace form. **No hypothesis that $\mathfrak h$ be the Lie algebra of a closed subgroup is used**, which is worth saying because the brief asks for it: the irrational line in a torus is a subalgebra of a non-closed subgroup and it is still abelian, hence reductive. Here the point is moot anyway, since $\mathfrak z(U)$ is the Lie algebra of the stabiliser of the triple, an algebraically defined and hence closed subgroup of $SO(6)$. **CONFIRMED.**

**Dimension two forces abelian.** $[\mathfrak h,\mathfrak h]$ is semisimple, and a nonzero semisimple Lie algebra has dimension at least $3$, $\mathfrak{su}(2)$ being the smallest. At $\dim\mathfrak h=2$ that forces $[\mathfrak h,\mathfrak h]=0$. **CONFIRMED.**

**Abelian forces toral, and this step is skipped.** *"$\mathfrak z(U)$ at dimension two is therefore a $2$-torus"* needs one more standard fact: in a compact Lie algebra every abelian subalgebra lies in a maximal abelian one, and every maximal abelian subalgebra is a Cartan subalgebra, the Lie algebra of a maximal torus. That is true and it is where compactness is spent, so the step is sound. **It should be written**, because without it "abelian" and "$2$-torus" are not the same statement, and the corresponding subgroup need not be closed even when the subalgebra is toral.

### 4.2 B2 and B3, the roots and the double centraliser

**The roots of $D_3$ are $\pm e_i\pm e_j$ for $1\le i<j\le3$, twelve of them**, and $3+12=15=\dim\mathfrak{so}(6)$. **CONFIRMED.**

**The centraliser formula is right.** For $\mathfrak a\subseteq\mathfrak t^3$, complexifying gives $\mathfrak z(\mathfrak a)_{\mathbb C}=\mathfrak t^3_{\mathbb C}\oplus\bigoplus_{\alpha|_{\mathfrak a}\equiv0}\mathfrak g_\alpha$, so a regular $\mathfrak t^2$, one on which no root vanishes identically, has $\mathfrak z(\mathfrak t^2)=\mathfrak t^3$ of dimension $3$. **CONFIRMED.**

**The stated reason is a non-sequitur, and it is the one defect in Claim B's derivation.** *"No root of $D_3$ vanishes on a regular $\mathfrak t^2$, since the roots are $\pm e_i\pm e_j$ and none has two zero coordinates."* Whether a root has two zero coordinates is a fact about the root's coordinates, and it settles only whether a root vanishes on a **coordinate** $2$-plane $\{x_k=0\}$: a root vanishing there would need $\alpha_i=\alpha_j=0$, which no root of $D_3$ satisfies, though $e_k$ does, which is why the argument would fail in $B_3$. For a general $2$-plane the right statement is that $\alpha$ vanishes on $\mathfrak t^2$ if and only if $\mathfrak t^2=\ker\alpha$, and *regular* already means that no root does, so the conclusion is definitional. **As written the clause would prove that every $\mathfrak t^2$ is regular, which the block's own next sentence contradicts by exhibiting $\{(a,a,b)\}=\ker(e_1-e_2)$.** Replace the clause.

**$U\subseteq\mathfrak z(\mathfrak z(U))$ is correct as used**, and needs nothing: for $u\in U$ and $X\in\mathfrak z(U)$ one has $[u,X]=0$ by definition of $\mathfrak z(U)$, so $u$ centralises $\mathfrak z(U)$. It holds for any subset, subalgebra or not. **CONFIRMED.**

**The regular case therefore closes.** $\mathfrak z(U)=\mathfrak t^2$ regular gives $U\subseteq\mathfrak z(\mathfrak t^2)=\mathfrak t^3$, and $\dim U=3$ gives $U=\mathfrak t^3$, whose centraliser is $\mathfrak t^3$ itself, of dimension $3$ and not $2$. **CONFIRMED**, and it is also the case [L181](../findings/diagonal-half.md) already empties.

### 4.3 B4, the singular torus, its centraliser, and the room inside it

**$\mathfrak z(\{(a,a,b)\})=\mathfrak t^3\oplus\mathfrak g_{\pm(e_1-e_2)}$ has dimension $5$**, since $\beta$ vanishes on $\ker(e_1-e_2)$ only for $\beta=\pm(e_1-e_2)$ in a reduced system. In real terms
$$\mathfrak k=\operatorname{span}\big(e^{12},\,e^{34},\,e^{56},\,e^{13}+e^{24},\,e^{14}-e^{23}\big),$$
and comparing with $\Lambda^-P=\operatorname{span}(e^{12}-e^{34},\,e^{13}+e^{24},\,e^{14}-e^{23})$ for $P=\operatorname{span}(e_1,\dots,e_4)$ gives the clean form
$$\boxed{\ \mathfrak k=\Lambda^-P\ \oplus\ \mathbb R a\ \oplus\ \mathbb R\varepsilon\ },\qquad a=\tfrac{1}{\sqrt2}(e^{12}+e^{34})\in\Lambda^+P,\quad \varepsilon=e^{56},$$
which is $\mathfrak u(2)\oplus\mathfrak u(1)$ with $\mathfrak u(2)=\Lambda^-P\oplus\mathbb Ra$ and centre $\mathbb Ra\oplus\mathbb R\varepsilon=\mathfrak t^2$. **Dimension $5$ CONFIRMED**, the identification CONFIRMED, and the three $5$-dimensional centralisers in $\mathfrak{so}(6)$, at $(c,c,d)$, at $(c,c,0)$ and at $(c,c,-d)$, are this one algebra up to conjugacy, since the Weyl group of $D_3$ is transitive on roots.

**The room is real: a $3$-plane inside $\mathfrak k$ with centraliser exactly $2$-dimensional exists.** Let $(n_1,n_2,n_3)$ be an orthonormal basis of $\Lambda^-P$ and take
$$U=\operatorname{span}\Big(\tfrac{n_1+\kappa a}{\sqrt{1+\kappa^2}},\ n_2,\ n_3\Big),\qquad \kappa\neq0 .$$
It is orthonormal. The Lie algebra it generates contains $[n_2,n_3]\propto n_1$, hence $n_1$, hence $a$, hence all of $\Lambda^-P\oplus\mathbb Ra$, so $\mathfrak z(U)=\mathfrak z(\Lambda^-P)\cap\mathfrak z(a)=(\Lambda^+P\oplus\mathbb R\varepsilon)\cap\mathfrak z(a)=\mathbb Ra\oplus\mathbb R\varepsilon$, of dimension $2$, using that the centraliser of a nonzero element of $\mathfrak{su}(2)\cong\Lambda^+P$ is its own line. **So B4's "leaving room for a $3$-plane inside it" is CONFIRMED and not merely a dimension count.** Note this $U$ has support $P$ and so $\dim V=4$: room in $\mathfrak k$ is not by itself a candidate at $\dim V=6$.

## 5. The audit asked for: r827's closure of the dimension-two case

**I derived this closure independently before the narrowed brief reached me**, in the same coordinates and by the same two steps, so what follows is an audit of r827's *statement* rather than a second opinion on whether the result is true. It is true.

### 5.1 The block decomposition is right and it is exhaustive

$\mathfrak k=\mathbb Ra\oplus\Lambda^-P\oplus\mathbb R\varepsilon$ is §4.3's algebra, the three summands are mutually orthogonal in $\Lambda^2\mathbb R^6$, and $a$ and $\varepsilon$ are unit. So writing $\omega_i=\alpha_ia+m_i+c_i\varepsilon$ with $m_i\in\Lambda^-P$ is a legitimate orthogonal decomposition and orthonormality of the triple reads $MM^{\mathsf T}+\alpha\alpha^{\mathsf T}+cc^{\mathsf T}=I_3$, where $M$ has the coordinate vectors of the $m_i$ as rows. **Exhaustive: CONFIRMED.**

### 5.2 The five equations are exactly the constraints, and no term has been dropped

Identify $\Lambda^\pm P$ with left and right multiplications on $P=\mathbb H$: $a=L_i/\sqrt2$, $m=R_v/\sqrt2$ with $\lVert m\rVert=\lvert v\rvert$. Then, block by block,
$$\omega_i^2=\Big[-\tfrac{\alpha_i^2+\lvert v_i\rvert^2}{2}\,\Pi_P+\alpha_i\,R_{v_i}L_i\Big]\ \oplus\ \big[-c_i^2\,\Pi_{P^\perp}\big],$$
$$\omega_i\wedge\omega_i=(\alpha_i^2-\lvert v_i\rvert^2)\,\mathrm{vol}_P\ +\ 2c_i\,(\alpha_ia+m_i)\wedge\varepsilon .$$
The cross block $P\otimes P^\perp$ of $S^2$ and the $\Lambda^3P\otimes P^\perp$ block of $\Lambda^4$ are absent because every $\omega_i$ is block diagonal, and $\varepsilon\wedge\varepsilon=0$. Ricci therefore contributes $\sum_i\lambda_i(\alpha_i^2+\lvert v_i\rvert^2)=0$, $\sum_i\lambda_i\alpha_iv_i=0$ and $\sum_i\lambda_ic_i^2=0$, using that $v\mapsto R_vL_i$ is injective into $S^2_0P$. Bianchi contributes $\sum_i\lambda_i(\alpha_i^2-\lvert v_i\rvert^2)=0$ and, from the $\Lambda^2P\otimes\Lambda^2P^\perp$ block split into its $\Lambda^+$ and $\Lambda^-$ parts, $\sum_i\lambda_ic_i\alpha_i=0$ and $\sum_i\lambda_ic_iv_i=0$. Adding and subtracting the two scalars gives
$$\alpha^{\mathsf T}\Lambda\alpha=0,\qquad c^{\mathsf T}\Lambda c=0,\qquad \alpha^{\mathsf T}\Lambda c=0,\qquad M^{\mathsf T}(\Lambda\alpha)=0,\qquad M^{\mathsf T}(\Lambda c)=0 .$$
**These are exactly r827's five, and nothing is dropped. CONFIRMED**, with one clarification the write-up owes a reader. The derivation produces a sixth scalar, $\sum_i\lambda_i\lvert v_i\rvert^2=0$, which r827's list omits: it is **implied**, since $\lvert v_i\rvert^2+\alpha_i^2+c_i^2=1$ and $\sum_i\lambda_i=0$ give it from the first two. Nine independent scalar equations either way. A reader counting Ricci's $1+3+1$ and Bianchi's $1+1+3$ against a list of nine will otherwise think a component was lost.

**The sign convention does not matter**, which I checked because it is this record's recurring failure mode. Swapping the roles of $\Lambda^+$ and $\Lambda^-$ flips the sign of the $\mathrm{vol}_P$ equation, and the pair of scalar equations still yields $\sum\lambda_i\alpha_i^2=\sum\lambda_i\lvert v_i\rvert^2=0$ either way.

### 5.3 The signature step: right, and it should say "or $(1,2)$"

$\sum_i\lambda_i=0$ with every $\lambda_i\neq0$ forces the sign pattern to be two of one sign and one of the other, so $\Lambda$ is nondegenerate of signature $(2,1)$ **or** $(1,2)$. The Witt index is $\min(2,1)=1$ in both cases, so a totally isotropic subspace has dimension at most $1$. **CONFIRMED**, and the quoted sentence should carry both signatures, since which one occurs is not fixed by the hypotheses.

### 5.4 The rank-one step: TRUE, but the quoted argument omits the branch where it is tight

This is the finding of the audit. With $\operatorname{span}(\alpha,c)$ at most a line, write $\alpha=pu$, $c=qu$ with $u$ isotropic, $u^{\mathsf T}\Lambda u=0$, and $\gamma^2=p^2+q^2$. Orthonormality becomes $MM^{\mathsf T}=I_3-\gamma^2uu^{\mathsf T}$ and both vector equations collapse to $M^{\mathsf T}(\Lambda u)=0$. **There are two branches and only the first is immediate.**

- **$\gamma^2\lvert u\rvert^2<1$.** Then $MM^{\mathsf T}$ has eigenvalues $1$ and $1-\gamma^2\lvert u\rvert^2>0$, so $M$ is invertible, so $M^{\mathsf T}(\Lambda u)=0$ gives $\Lambda u=0$ and hence $u=0$, the weights being nonzero.
- **$\gamma^2\lvert u\rvert^2=1$.** Here $MM^{\mathsf T}$ is singular and **$M$ is not invertible, so the step above is unavailable.** This is the branch the quoted sentence passes over. It closes as follows. $\lVert M^{\mathsf T}u\rVert^2=u^{\mathsf T}MM^{\mathsf T}u=\lvert u\rvert^2(1-\gamma^2\lvert u\rvert^2)=0$, so $u\in\ker M^{\mathsf T}$, and $\operatorname{rank}M=2$ makes $\ker M^{\mathsf T}=\mathbb Ru$ exactly. Then $\Lambda u\in\mathbb Ru$, so $\lambda_iu_i=\kappa u_i$ for every $i$ and a single scalar $\kappa$, whence $0=u^{\mathsf T}\Lambda u=\kappa\lvert u\rvert^2$ gives $\kappa=0$ and then $\lambda_iu_i=0$ for every $i$, so $u=0$, against $\gamma^2\lvert u\rvert^2=1$.

  Note that $\gamma^2\lvert u\rvert^2\le1$ always, $MM^{\mathsf T}$ being a Gram matrix, so the two branches are exhaustive.

**Verdict on the step: the conclusion is CONFIRMED and the quoted justification is INCOMPLETE.** The omission is not cosmetic. It is the same branch that [r824](REVIEW_r824.md) §7 had to treat separately in the four-dimensional analogue, where it flagged $\lvert b\rvert=1$ as the tight line and told a reader to attack it first. **A version of this closure recorded without the degenerate branch would be a lemma with a hole at exactly the place a reader will look.**

### 5.5 "At any $\dim V$": earned, provided the reduction travels with it

**The constraint computation of §5.2 to §5.4 uses no dimension hypothesis whatsoever.** It uses $U\subseteq\mathfrak k$, orthonormality, $\sum\lambda_i=0$ and $\lambda_i\neq0$, and nothing else. Its conclusion is $\alpha=c=0$, hence $U=\Lambda^-P$, hence $\dim V=4$ and $\dim\mathfrak z(U)=4$, against the hypothesis $\dim\mathfrak z(U)=2$. **So "no solution has a two-dimensional stabiliser at any $\dim V$" is EARNED.**

**What must travel with it is the reduction from the hypothesis to $U\subseteq\mathfrak k$**, and the quoted block does not state it. In full it is this. $\dim\mathfrak z(U)=2$ gives a reductive, hence abelian, hence toral $\mathfrak z(U)$ by §4.1. Either it is regular, and the case closes by §4.2 with no computation, or it is singular, so $\mathfrak z(U)=\ker\alpha$ for a root $\alpha$. All roots of $D_3$ are Weyl-conjugate, and all maximal tori are conjugate, so $\mathfrak z(U)$ is conjugate to $\ker(e_1-e_2)$, and then $U\subseteq\mathfrak z(\mathfrak z(U))=\mathfrak z(\ker(e_1-e_2))=\mathfrak k$. **Without the conjugacy sentence, the computation is about one $\mathfrak k$ and the claim is about all of them.** The constraints are $O(6)$-equivariant, so the conjugation is free.

**Argue the opposite, as the protocol requires.** The best case against the closure is that $\mathfrak k$ might not be the only $5$-dimensional centraliser shape, so that a singular $\mathfrak t^2$ could sit inside something the computation does not cover. I enumerated the centralisers of a nonzero $X\in\mathfrak{so}(6)$ by normal form $c_1\ge c_2\ge c_3\ge0$: $\mathfrak t^3$ at $(c_1,c_2,c_3)$ distinct and at $(c_1,c_2,0)$ with $c_1\neq c_2$, $\mathfrak u(2)\oplus\mathfrak u(1)$ at $(c,c,d)$ and $\mathfrak u(2)\oplus\mathfrak{so}(2)$ at $(c,c,0)$, $\mathfrak{so}(2)\oplus\mathfrak{so}(4)$ at $(c,0,0)$, and $\mathfrak u(3)$ at $(c,c,c)$. Every $5$-dimensional entry is $\mathfrak k$. The second attack is that the isotropy step might not be available if $\Lambda$ were degenerate or definite, which the nonzero weights and $\sum\lambda_i=0$ rule out. **Neither attack lands.**

**A consistency check that the argument is not proving too much.** The padded family satisfies it with $\alpha=c=0$, $MM^{\mathsf T}=I$ and $\sum_i\lambda_i\lvert v_i\rvert^2=\sum_i\lambda_i=0$. So the derivation lands exactly on the record's known inhabited family rather than emptying it, which is the outcome a correct argument must have.

## 6. An increment: dimension one collapses to a single shape, by the same lemma

*This is my own derivation, produced under a Gate 2 brief, and it has had no independent audit. It is recorded as an increment and settles nothing until it is reviewed.*

Suppose $\mathfrak z(U)=\mathbb RX$ is one-dimensional. Then $U\subseteq\mathfrak z(X)$, and §5.5's enumeration gives the possibilities.

- **$\mathfrak z(X)=\mathfrak t^3$.** Then $U=\mathfrak t^3$ and $\mathfrak z(U)=\mathfrak t^3$ has dimension $3$, not $1$.
- **$\mathfrak z(X)=\mathfrak k$**, the $5$-dimensional case. §5 applies verbatim and forces $U=\Lambda^-P$, whose centraliser has dimension $4$, not $1$.
- **$\mathfrak z(X)=\Lambda^2Q\oplus\Lambda^2Q^\perp$** with $\dim Q=2$, the $7$-dimensional case at $X=(c,0,0)$. Write $\omega_i=t_i\varepsilon_Q+\alpha_i+b_i$ with $\alpha_i\in\Lambda^+Q^\perp\leftrightarrow u_i$, $b_i\in\Lambda^-Q^\perp\leftrightarrow v_i$. The same block computation gives $\sum\lambda_it_i^2=\sum\lambda_i\lvert u_i\rvert^2=\sum\lambda_i\lvert v_i\rvert^2=0$, the two cross equations $\sum\lambda_it_iu_i=\sum\lambda_it_iv_i=0$, and the traceless Ricci block $\sum_i\lambda_iu_iv_i^{\mathsf T}=0$, using $S^2_0\mathbb R^4\cong\Lambda^+\otimes\Lambda^-$. Writing $\mathcal U,\mathcal V$ for the matrices with columns $u_i,v_i$, the last reads $\mathcal U\Lambda\mathcal V^{\mathsf T}=0$, so by Sylvester $\operatorname{rank}\mathcal U+\operatorname{rank}\mathcal V\le3$. If $\operatorname{rank}\mathcal U=0$ the triple lies in $\Lambda^-Q^\perp\oplus\mathbb R\varepsilon_Q$ and [r824](REVIEW_r824.md) §7 forces $t=0$, giving $\dim\mathfrak z(U)=4$. If $\operatorname{rank}\mathcal U=1$, then $u_i=p_i\hat u$ and $(p,t)$ is a totally isotropic pair for $\Lambda$, hence a line $p=p\,\xi$, $t=q\,\xi$, and $\mathcal V\mathcal V^{\mathsf T}=I-(p^2+q^2)\xi\xi^{\mathsf T}$ with $\mathcal V^{\mathsf T}(\Lambda\xi)=0$: **§5.4's lemma verbatim**, giving $\xi=0$ and so $\operatorname{rank}\mathcal U=0$. The cases $\operatorname{rank}\mathcal V\le1$ are the same with the orientation of $Q^\perp$ reversed. So this branch is empty.
- **$\mathfrak z(X)=\mathfrak u(3)$**, at $X=(c,c,c)$. **Untouched.** Here $U$ is a $3$-plane of forms all commuting with one complex structure $J$, and Ricci becomes $\sum_i\lambda_iA_i^2=0$ for anti-hermitian $3\times3$ matrices $A_i$ with $\operatorname{tr}A_iA_i^*=1$. I did not attempt it.

**So, subject to audit: at $\dim V=6$ a solution has $\mathfrak z(U)=0$, or $\mathfrak z(U)=\mathbb RJ$ with $U\subseteq\mathfrak u(3)$.** That is a sharper statement than "dimension $0$ or $1$", and the surviving one-dimensional shape is a single named case rather than a family of them.

## 7. Protocol

- **Located exactly.** Claim A is [findings/diagonal-half.md](../findings/diagonal-half.md) at [line 794](../findings/diagonal-half.md#L794), Claim B at [line 802](../findings/diagonal-half.md#L802), the false finite-stabiliser sentence at [line 790](../findings/diagonal-half.md#L790) and in [r825](REVIEW_r825.md) §4, and r824's repaired count in [r824](REVIEW_r824.md) §6, where its stratum qualification and the padded stratum's own $7$-against-$5$ both appear.
- **Exhibited concretely.** §1's centraliser and orbit computation, §1's two-orbit argument, §2's $SO(3)$ counterexample, §3's orthonormal triple with trivial centraliser and its brackets, §4.3's $3$-plane with a $2$-dimensional centraliser, §5.4's degenerate branch in closed form, and §6's disposal of the $7$-dimensional case.
- **Argued the opposite.** §2 gives Claim A its strongest reading and says why that reading defends nobody's count. §5.5 attacks the closure from the two directions it is vulnerable to, an unlisted $5$-dimensional centraliser and a degenerate $\Lambda$, and both fail. §5.5 also checks the closure against the padded family to confirm it does not prove too much.

**Nothing is withdrawn.** Every verdict above cleared all three.

## 8. Falsifiers, and what I did to look for them

| Claim I record | What would falsify it | What I did |
|---|---|---|
| The padded stabiliser is exactly $4$ (§1) | A fixed vector of $\mathfrak{su}(2)_+$ in $P\otimes P^\perp$, or a larger centraliser in $\mathfrak{so}(P)$ | Split $\mathfrak{so}(6)$ into its three blocks and computed the invariants of each separately, checking the total against $15$ |
| The family is two orbits, not one (§1) | An element of $O(6)$ preserving $\Lambda^+P$ and reversing the orientation of a basis of it | Showed any such $g$ preserves the common support $P$, so $g=(h,k)$, and $\det h=-1$ swaps $\Lambda^\pm$, leaving only $SO(4)\times O(2)$ with image $SO(3)$ |
| A stratified count survives a failure on another stratum (§2) | A theorem making an expected-dimension count global over a stratified quotient | Built an equivariant counterexample where the principal count is right and the singular one is wrong, and re-read r824 §6 to see which stratum its number is attached to |
| $\mathfrak z(U)=0$ for the exhibited triple (§3) | A nonzero $X$ commuting with all three | Reduced to $\mathfrak t^3$ by regularity of $\omega_1$, then computed $[E_{12},E_{13}]$, $[E_{34},E_{13}]$ and their $E_{15}$ analogues as matrix products by hand |
| r827's five equations are complete (§5.2) | A component of Ricci or Bianchi with no equation attached to it | Counted blocks on both sides, $1+3+1$ for Ricci and $1+1+3$ for Bianchi against nine independent scalars, and identified the omitted sixth scalar as implied rather than missing |
| The rank-one step needs its degenerate branch (§5.4) | An argument that $\gamma^2\lvert u\rvert^2=1$ cannot occur, which would make the omission harmless | Looked for one and found the opposite: the constraint $\gamma^2\lvert u\rvert^2\le1$ is exactly a Gram condition and its equality case is attainable a priori, which is why the branch has to be closed rather than excluded |
| The closure holds at any $\dim V$ (§5.5) | A step using rank six, or a $5$-dimensional centraliser outside the conjugacy class of $\mathfrak k$ | Re-read the derivation for a dimension hypothesis and found none, and enumerated the centralisers of a nonzero element by normal form, where every $5$-dimensional entry is $\mathfrak k$ |
| Dimension one collapses to $\mathfrak u(3)$ (§6) | A solution in $\Lambda^2Q\oplus\Lambda^2Q^\perp$ with $\operatorname{rank}\mathcal U\ge1$, or an error in the Sylvester bound | Ran the rank split in all cases and reduced each to §5.4's lemma or to r824 §7. **The $\mathfrak u(3)$ case is untried and is the honest open end** |

**Computation.** *None was run. The standing analysis-only rule was in force, the screening allowance was available and unused, and every bracket, dimension and signature above was worked by hand.*

## 9. What the record should say

1. **Strike the sentence at [line 790](../findings/diagonal-half.md#L790)** saying the finite-stabiliser case cannot occur. §3's triple has $\mathfrak z(U)=0$ at $\dim V=6$. The correct sentence is that the stabiliser has dimension at most $4$ and is generically zero, so orbits run from $11$ to $15$.
2. **Rewrite the settlement at [line 794](../findings/diagonal-half.md#L794).** The two reviewers are not in contradiction: r824's number is attached to the finite-stabiliser stratum and r825's exhibit lives on a stratum with a $4$-dimensional stabiliser, and r824 computes that stratum's own count separately. What survives unchanged is the conclusion the record already draws, that the census carries the expectation and the count does not.
3. **Repair Claim B's regularity clause** at [line 802](../findings/diagonal-half.md#L802): a root vanishes on $\mathfrak t^2$ exactly when $\mathfrak t^2=\ker\alpha$, and *regular* is defined as no root vanishing, so $\mathfrak z(\mathfrak t^2)=\mathfrak t^3$ is definitional. Add the step that an abelian subalgebra of a compact algebra is toral.
4. **Record the closure of the dimension-two case with both missing pieces**: the reduction sentence, that $\dim\mathfrak z(U)=2$ makes $\mathfrak z(U)$ toral and, if singular, conjugate to $\ker(e_1-e_2)$, so $U\subseteq\mathfrak k$; and the degenerate branch $\gamma^2\lvert u\rvert^2=1$ of §5.4, which is where the argument is tight. **Two independent derivations of the closure now exist**, r827's and §5's, and they agree.
5. **The remaining question is dimension one and dimension zero**, and §6 narrows dimension one, subject to audit, to the single case $U\subseteq\mathfrak u(3)$ with $\mathfrak z(U)=\mathbb RJ$.
