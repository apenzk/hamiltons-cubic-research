# r824: Gate 2 on the refutation of the $\dim V=6$ parameter count

*Cold brief: I was given the note and the three refutation boxes verbatim, and read [findings/diagonal-half.md](../findings/diagonal-half.md) around [line 786](../findings/diagonal-half.md#L786) in full context (L176 through L191), plus the surrounding rank-three census. **The programme is on an analysis-only footing and I opened no numerical line of work at all: this review contains zero machine computation, not even a screen.** Every derivation below is by hand and every constant is exact. Log: [agent_logs/g2-equivariance-r824.log](../agent_logs/g2-equivariance-r824.log).*

| Claim | Verdict |
|---|---|
| **R1**: the constraint map is $O(6)$-equivariant, its zero set invariant, so at every solution the orbit lies in $\ker dF_p$ | **CONFIRMED.** Every hypothesis the step needs is present and checkable, and the step needs strictly less than the refutation claims for it |
| **R2**: a triple of nonzero forms has stabiliser of dimension at most $9$, so every orbit has dimension at least $6$ | **CONFIRMED but LOOSE by a factor that matters.** The subgroup list and both branchings are right. For a *triple* of independent forms the sharp bound is $\dim\le4$, so every orbit has dimension at least $11$ |
| **R3**: the $35$ constraints are dependent at every solution | **CONFIRMED**, and with the sharp bound the deficiency is at least $6$ rather than at least $1$ |
| **R4**: the note's "$15$-dimensional orbit inside a $5$-dimensional set" is invalid and the argument built on it is circular | **CONFIRMED.** The note's stated contradiction is not a contradiction |
| **R5**: $\operatorname{rank}dF_p\le r$ gives $\dim S\ge 40-r$ | **REFUTED as an implication.** It is false for a general smooth map and false for a general equivariant one, and I give a two-line counterexample of each. The numbers $6$ and $15$ that the refutation reads off it are nevertheless correct, because the orbit is contained in $S$ outright |
| **R6**: "the count says nothing about emptiness" | **REFUTED.** Quotienting by the group first is the standard repair and it survives: $\dim(M/G)=25$ against $35$ constraints, an expected deficit of $10$. The note's *conclusion* comes back stronger than it went in, on the principal stratum |
| **R7**: "the branch's emptiness at $\dim V=6$ is open with nothing pointing either way" | **REFUTED.** Two things point, in the same direction: the corrected count above, and the record's own $\dim V=6$ census, in which every attacked sub-case has closed empty and no witness above $\dim V=4$ exists anywhere |
| **The note's own arithmetic** | **ALL CORRECT.** $45-6=39$, $+1=40$, $20+15=35$, $40-35=5$. There is no arithmetic error to exploit in either direction |
| **What the refutation missed** | **A concrete falsification of the count, sitting inside the record.** The count's own solution set contains an explicit $12$-dimensional family, the padded $\Lambda^+\mathbb R^4$ solutions, where it predicts $5$. That is the strongest available refutation of the count and it is not numerical |
| **New increment** | Every rank-three triple at $\dim V=6$ whose stabiliser has dimension $\ge3$ is now excluded: the $\mathfrak t^3$ case by [L181](../findings/diagonal-half.md), the $\mathfrak{so}(3)$ case by support, and the $\mathfrak{su}(2)$ case by a half-page computation in §7 that is new here |

**One line.** *The refutation's mathematical core is right and the note's argument must be withdrawn, but the refutation then draws two conclusions it has not earned. The count is invalid as an argument and its conclusion survives by a better route, so the correct outcome for the record is not "open with nothing pointing either way" but "the count is repaired, it still expects emptiness, and it is still a count rather than a proof".*

## 0. What is being counted, fixed once

Write $M$ for the parameter space the note counts: orthonormal triples $(\omega_1,\omega_2,\omega_3)$ in $\Lambda^2\mathbb R^6$ times the circle $\{\lambda\in\mathbb R^3:\sum\lambda_i=0,\ \lvert\lambda\rvert=1\}$. Write $N=S^2_0\mathbb R^6\oplus\Lambda^4\mathbb R^6$, of dimension $20+15=35$, and $$F(\omega,\lambda)=\Big(\sum_i\lambda_i\omega_i^2,\ \sum_i\lambda_i\,\omega_i\wedge\omega_i\Big),\qquad S=F^{-1}(0).$$ $G=O(6)$ acts on $\mathbb R^6$, hence on $\Lambda^2$, $S^2$ and $\Lambda^4$, and acts trivially on $\lambda$. A $2$-form is read as a skew matrix with $\langle\omega,\eta\rangle=\sum_{a<b}\omega_{ab}\eta_{ab}$, the convention [L180](../findings/diagonal-half.md) fixes, so $\operatorname{tr}(\omega^2)=-2\lVert\omega\rVert^2$.

**Two identifications used throughout.** $\Lambda^2\mathbb R^6\cong\mathfrak{so}(6)$ as $SO(6)$-representations, the action being $\operatorname{Ad}$, so *fixing a $2$-form is centralising a Lie algebra element*. And for $U=\operatorname{span}(\omega_1,\omega_2,\omega_3)$ the stabiliser of the triple has Lie algebra $\mathfrak z(U)$, the centraliser of $U$ in $\mathfrak{so}(6)$. That second identification is what makes §2's sharp bound a finite check rather than a search.

## 1. Claim R1, the load-bearing step

**The step is correct.** For $X\in\mathfrak g$ and $p\in S$, equivariance gives $F(\exp(tX)\cdot p)=\exp(tX)\cdot F(p)=\exp(tX)\cdot 0=0$ for all $t$, and differentiating at $t=0$ gives $dF_p(X\cdot p)=0$. Hence $T_p(G\cdot p)\subseteq\ker dF_p$ and $$\operatorname{rank}dF_p\le \dim M-\dim(G\cdot p)=40-\dim(G\cdot p).$$

**The hypotheses it actually needs, and each one checked here.**

- *$M$ a smooth manifold and $F$ smooth.* $M$ is a Stiefel manifold times a circle, and $F$ is the restriction of a polynomial map. Clean.
- *A smooth action of $G$ on $M$ preserving $M$.* $g\in O(6)$ acts on $\Lambda^2\mathbb R^6$ orthogonally for the induced inner product, so it carries orthonormal triples to orthonormal triples, and it does not touch $\lambda$. Clean.
- *The action on the target linear, or at least fixing $0$.* This is the hypothesis most easily left implicit and it is the one that makes the argument work. Here the actions on $S^2_0\mathbb R^6$ and $\Lambda^4\mathbb R^6$ are the induced linear ones, so $0$ is fixed. Clean.
- *$F$ equivariant.* $(g\omega g^{\mathsf T})^2=g\,\omega^2\,g^{\mathsf T}$ and $(g\cdot\omega)\wedge(g\cdot\omega)=g\cdot(\omega\wedge\omega)$, both by naturality. The weights are scalars and ride along. Clean.

**What it does NOT need, contrary to the brief's list of candidate hypotheses.** It needs neither smoothness of $S$, nor that $S$ be a manifold, nor that $S$ be the full preimage of anything, nor any transversality. The whole content is that *one orbit* through *one solution* lies in $S$, and the orbit is a smooth immersed submanifold regardless of what $S$ is. This is worth stating because the note's defender might try to escape through a singularity of $S$, and there is no escape there.

**One refinement the refutation does not make.** $-I\in O(6)$ acts trivially on $\Lambda^2$, so the group acting effectively is $O(6)/\{\pm I\}$. Its dimension is still $15$ and every orbit dimension below is unaffected. This matters only if someone tries to read "orbit" as a copy of $O(6)$.

**Verdict R1: CONFIRMED**, and the step is more robust than the refutation's own presentation of it.

## 2. Claim R2, the stabiliser bound: right, and loose

### 2.1 The refutation's version is correct

*The subgroup list.* The maximal connected subgroups of $SO(6)$ are $SO(5)$ (dimension $10$), $U(3)$ ($9$), $SO(4)\times SO(2)$ ($7$), $SO(3)\times SO(3)$ ($6$) and $SO(3)$ acting irreducibly ($3$). A connected subgroup of dimension $\ge10$ lies in a maximal one of dimension $\ge10$, so it is $SO(6)$ or lies in a conjugate of $SO(5)$. The maximal connected subgroups of $SO(5)$ have dimensions $6$, $4$ and $3$, so inside $SO(5)$ nothing of dimension $\ge10$ is proper. The refutation's list is right.

*$\dim U(3)=9$*, as the brief asks: $\dim U(n)=n^2$. Right, and it is the reason the list stops where it does.

*The two branchings.* $\Lambda^2\mathbb R^6$ is the adjoint of $\mathfrak{so}(6)\cong\mathfrak{su}(4)$, which is simple, so it is irreducible and carries no nonzero $SO(6)$-fixed vector. Under $SO(5)$ acting on $\mathbb R^6=\mathbb R^5\oplus\mathbb R$, $\Lambda^2\mathbb R^6=\Lambda^2\mathbb R^5\oplus\mathbb R^5$, the adjoint and the standard representation, both irreducible and both nontrivial. Right.

*One gap in the write-up, and it closes.* The refutation writes "under $SO(5)$ on $\mathbb R^6=\mathbb R^5\oplus\mathbb R$" as though that embedding were the only one. It is, and the reason is worth one line: the real irreducible representations of $B_2$ have dimensions $1$, $5$, $8$ (the quaternionic spin representation, real dimension $8$), $10$, $14$, so a $6$-dimensional real representation is forced to be $5+1$. With that line the argument is complete.

*Disconnected stabilisers*, as the brief asks: the dimension of a Lie group is the dimension of its identity component, and $\dim(G\cdot p)=\dim G-\dim H=\dim G-\dim H^0$. Components change the number of components of the orbit and nothing dimensional. No effect.

*$O(6)$ against $SO(6)$*, as the brief asks: the dimensions agree at $15$, the identity component of a stabiliser in $O(6)$ lies in $SO(6)$ so the bound transfers verbatim, and the constraint map is $O(6)$-equivariant rather than merely $SO(6)$-equivariant. No effect either.

### 2.2 The bound is not attained by a triple, and the sharp value is $4$

$U(3)$ attains $9$ for a *single* form: it fixes the Kähler form. It cannot attain it for a triple. Under $U(3)$, $$\Lambda^2\mathbb R^6=\mathbb R\,\omega_J\ \oplus\ \mathfrak{su}(3)\text{-part }(8)\ \oplus\ \operatorname{Re}\Lambda^{2,0}\ (6),$$ with exactly one trivial summand, so $U(3)$ fixes a line and not a $3$-space. The same holds for $SU(3)$, whose fixed set in $\Lambda^2$ is that same line.

**The sharp statement.** *For every $3$-dimensional $U\subseteq\Lambda^2\mathbb R^6$, $\dim\mathfrak z(U)\le4$, with equality exactly when $U\subseteq\Lambda^{\pm}P\oplus\Lambda^2P^{\perp}$ for a $4$-plane $P$.*

*Proof.* $\mathfrak z(U)=\bigcap_i\mathfrak z(\omega_i)$, so $\dim\mathfrak z(U)\ge5$ forces $\dim\mathfrak z(\omega)\ge5$ for every nonzero $\omega\in U$. Reading $\omega$ in normal form $c_1e^{12}+c_2e^{34}+c_3e^{56}$, the centraliser is $\mathfrak u(3)$ at $(c,c,c)$ with $c\ne0$ (dimension $9$), $\mathfrak{so}(2)\oplus\mathfrak{so}(4)$ at $(c,0,0)$ ($7$), $\mathfrak u(2)\oplus\mathfrak u(1)$ at $(c,c,d)$ with $c\ne d$ and $c\neq 0$ ($5$), and $\mathfrak t^3$ or smaller in every remaining case ($3$). So every nonzero element of $U$ must have a repeated nonzero $c_j$. Now run the other side: a subalgebra $\mathfrak k$ of dimension $\ge5$ with $\dim\mathfrak z(\mathfrak k)\ge3$ does not exist, by inspection of the conjugacy classes. $\mathfrak{so}(5)$ has centraliser $0$; $\mathfrak u(3)$, $\mathfrak{su}(3)$, $\mathfrak{so}(4)\oplus\mathfrak{so}(2)$ and $\mathfrak{so}(4)$ have centraliser of dimension $1$; $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ has $0$; $\mathfrak u(2)\oplus\mathfrak u(1)$ and $\mathfrak{su}(2)\oplus\mathfrak u(1)^2$ have $2$. Since $\mathfrak z(U)$ is itself such a $\mathfrak k$ with $U\subseteq\mathfrak z(\mathfrak z(U))$, the value $\ge5$ is impossible. Dimension $4$ is attained: $\mathfrak z(\mathfrak{su}(2)_-\oplus\mathfrak{so}(2)_{P^{\perp}})=\Lambda^+P\oplus\Lambda^2P^{\perp}$, of dimension $4$, and conversely $\mathfrak{su}(2)\oplus\mathfrak{so}(2)$ is the only $4$-dimensional class with a centraliser of dimension $\ge3$. $\square$

**Consequences.** Every $G$-orbit in $M$ through a triple of independent forms has dimension at least $15-4=11$, so $\operatorname{rank}dF_p\le29$ at every solution and the $35$ constraints are dependent to depth at least $6$. The refutation's "$34$" and "depth at least $1$" are true and weak.

**This kills one of the refutation's own sentences.** It writes "$\dim S\ge40-34=6$, and a single orbit has dimension at least $6$, so one orbit is dimensionally consistent with the whole solution set". The reconciliation at $6$ requires a $9$-dimensional stabiliser, which no triple has. The *qualitative* conclusion survives at $11$ instead of $6$, and it survives for a reason that makes it vacuous rather than informative: see §5.

**Verdict R2: CONFIRMED as stated, LOOSE, and the sharp bound is $4$.**

## 3. Claim on the arithmetic: the note is clean

- *Stiefel.* $\dim V_3(\mathbb R^{15})=15\cdot3-\binom{4}{2}=45-6=39$. Correct.
- *Weights.* $\{\sum\lambda_i=0\}$ is a plane, its unit circle is $1$-dimensional. Correct, and the unit normalisation is the right one, since without it the extra parameter is pure scale.
- *The symmetric constraint.* $\dim S^2\mathbb R^6=21$, and the trace is automatic: $\operatorname{tr}\!\big(\sum_i\lambda_i\omega_i^2\big)=-2\sum_i\lambda_i\lVert\omega_i\rVert^2=-2\sum_i\lambda_i=0$, using equal norms and $\sum\lambda_i=0$ and nothing else. So $20$. Correct.
- *The Bianchi constraint.* $\binom{6}{4}=15$, with no component automatic. Correct.
- *The subtraction.* $40-35=5$. Correct.

**There is no arithmetic error, in either direction.** I looked for one specifically because the brief flags that a wrong number changes the conclusion either way, and the one place I expected to find slack, an automatic component of the $\Lambda^4$ equation, has none.

## 4. What the refutation missed: the count is falsified by a family the record already owns

The refutation argues that the count *could* fail. It does fail, explicitly, and the witness is in the record.

**Take a $4$-plane $P\subset\mathbb R^6$, any orthonormal basis $\omega_1,\omega_2,\omega_3$ of $\Lambda^+P\subset\Lambda^2\mathbb R^6$, and any unit $\lambda$ with $\sum\lambda_i=0$.** For unit self-dual $\omega$ on $P$ one has $\omega^2=-\tfrac12\Pi_P$ and $\omega\wedge\omega=\operatorname{vol}_P$, *the same for every such $\omega$*. Hence $$\sum_i\lambda_i\omega_i^2=-\tfrac12\Big(\sum_i\lambda_i\Big)\Pi_P=0,\qquad \sum_i\lambda_i\,\omega_i\wedge\omega_i=\Big(\sum_i\lambda_i\Big)\operatorname{vol}_P=0.$$ So the whole family lies in $S$. Its dimension is $\dim\operatorname{Gr}(4,6)+\dim O(3)+1=8+3+1=12$.

**The count predicts $5$ for a set that contains $12$.** This is the padded $W_{\mathbb{CP}^2}$ family, [L178](../findings/diagonal-half.md)'s own equality case and the exhibit both [r773](REVIEW_r773.md) and [r774](REVIEW_r774.md) produced. It is not a numerical result and it needs no search.

**The honest scope of this exhibit.** A defender will say the note means the count on the open subset where the supports span $\mathbb R^6$, and the family lies in the closed complement. That defence is available and I grant it. What the exhibit still establishes is that *this* heuristic, applied to *this* map, at *this* dimension, is off by $7$ in the direction of under-counting, and that the mechanism is exactly the equivariant one: the family sits at a stabiliser jump. That is a stronger and more concrete statement than anything the refutation offers, and it should replace the refutation's abstract opening.

**Consistency check on the machinery.** At a point of that family the stabiliser contains $SU(2)_-\times SO(2)_{P^{\perp}}$, of dimension $4$, so the orbit has dimension at most $11$, and the family is the orbit ($11$) together with the weight circle ($1$), giving $12$. The sharp bound of §2 is attained here, and the two counts agree.

## 5. Claim R5: the inequality the refutation reasons with is false

The refutation writes "$\operatorname{rank}dF_p\le 40-\dim(O(6)\cdot p)$", which is correct, and then "the right reading is $\dim S\ge40-34=6$" and "a finite stabiliser gives a $15$-dimensional orbit, which forces the rank to at most $25$ and the set to dimension at least $15$". **The implication "$\operatorname{rank}dF_p=r$ implies $\dim_pS\ge n-r$" is false.** It is the constant-rank theorem with the constancy dropped.

*Counterexample, smooth.* $F:\mathbb R\to\mathbb R$, $F(x)=x^2$. Then $\operatorname{rank}dF_0=0$ and $n-r=1$, while $F^{-1}(0)=\{0\}$ has dimension $0$.

*Counterexample, equivariant, in case one suspects equivariance rules the phenomenon out.* $G=SO(2)$ acting by rotation on $M=\mathbb R^2$, $N=\mathbb R$ the trivial representation, $F(x)=(\lvert x\rvert^2-1)^2$. Then $F$ is equivariant, $S$ is the unit circle, $dF_p=0$ at every $p\in S$, and $n-r=2>1=\dim S$.

**The numbers the refutation reads off are nevertheless right, for a different and simpler reason.** The orbit through $p$ is *contained* in $S$, so $\dim_pS\ge\dim(G\cdot p)$ directly, with no rank theorem. That gives $\ge6$ under the refutation's bound and $\ge11$ under §2's, and $\ge15$ in the finite-stabiliser case. So the conclusions stand and the stated justification does not. **This should be rewritten in the record**, because as written it licenses a false general principle that a successor will reuse.

**And it exposes why R6 overreaches.** Dependent differentials at a point do not enlarge the zero set. Take $F(x,y)=(x^2,y)$ on $\mathbb R^2\to\mathbb R^2$: at the origin the rank is $1$, the two constraints are dependent, and the zero set is still a point of the expected dimension $0$. Forced dependency is compatible with the naive codimension being exactly right.

## 6. Claim R6: the count is repairable, and the repair says emptiness louder

**The standard repair is to count on the quotient, and it is available here.** Let $p\in M$ have finite stabiliser. By the tube theorem a $G$-invariant neighbourhood of the orbit is $G\times_H Z$ with $H$ finite and $Z$ a slice of dimension $40-15=25$, and $S$ meets it in $G\times_H\big((F|_Z)^{-1}(0)\big)$. The map $F|_Z:Z\to N$ has $\dim Z=25$ and $\dim N=35$. **The expected dimension is $25-35=-10$: expect empty, with $10$ to spare.** Equivariance imposes nothing on $F|_Z$ beyond $H$-equivariance for a finite $H$, so the count is not degenerate at the orbit any more.

**The same number by hand, with no tube theorem, which is how a reader should check it.** Use $O(6)$ to put $\omega_1$ in normal form $c_1e^{12}+c_2e^{34}+c_3e^{56}$: that is $2$ parameters after $\sum c_j^2=1$, with residual gauge group $T^3$ of dimension $3$ for generic $c$. Then $\omega_2$ lies on a $13$-sphere in $\omega_1^{\perp}$, $\omega_3$ on a $12$-sphere in $\{\omega_1,\omega_2\}^{\perp}$, and $\lambda$ contributes $1$. Total $2+13+12+1=28$, less the $3$ residual gauge directions, is $25$. Against $35$ constraints.

**So the note's conclusion survives, and by a wider margin than the note claimed.** The note said "expect emptiness, with $5$ dimensions of embarrassment". The corrected count says "expect emptiness, with a deficit of $10$". The refutation's "the count says nothing about emptiness" is therefore wrong. What died is the *argument by orbit dimension*, which was indeed circular. What survives is the *count*, once the group is divided out before subtracting rather than after.

**And the repair carries the note's own honesty label, which must not be lost.** The corrected count is still a heuristic, and it still fails in this very problem on the non-principal strata. At the padded family of §4 the stabiliser is $H^0=\mathfrak{su}(2)_-\oplus\mathfrak{so}(2)$, and the stratified count is $\dim M^{H}$ against $\dim N^{H}$. I computed both: $(\Lambda^2\mathbb R^6)^H=\Lambda^+P\oplus\Lambda^2P^{\perp}$ is $4$-dimensional, so $M^H$ is a $V_3(\mathbb R^4)$ times the circle, of dimension $6+1=7$, and $N^H$ has dimension $5$, being $\mathbb R(\Pi_P-\tfrac23I)$ in $S^2_0$ together with $\operatorname{vol}_P$ and $\Lambda^+P\wedge\Lambda^2P^{\perp}$ in $\Lambda^4$. The count predicts $7-5=2$ and the truth is $4$. **So the repaired count is a better heuristic and not a proof, exactly as the note said of itself.**

**Verdict R6: REFUTED.** The right sentence for the record is that the count is invalid *as stated*, that its conclusion survives a correct restatement, and that the correct restatement is still a count.

## 7. What the sharp stabiliser bound buys, which is a real increment

Combining §2 with the record, **every rank-three triple at $\dim V=6$ whose stabiliser has dimension $\ge3$ is excluded.** A compact $3$-dimensional subalgebra is $\mathfrak{su}(2)$ or abelian, and by §2's classification only these survive with $\dim\mathfrak z\ge3$:

- **$\mathfrak h=\mathfrak t^3$**, with $\mathfrak z(\mathfrak h)=\mathfrak t^3=\operatorname{span}(e^{12},e^{34},e^{56})$. The triple then lies in a common orthogonal splitting into planes, which is exactly [L181](../findings/diagonal-half.md)'s hypothesis, and that lemma empties it.
- **$\mathfrak h=\mathfrak{so}(3)$ acting irreducibly on a $3$-space**, with $\mathfrak z(\mathfrak h)=\Lambda^2$ of the complementary $3$-space. Every $2$-form on a $3$-space is decomposable and the whole span has support of dimension at most $3$, so this is inside [L185](../findings/diagonal-half.md) and outside $\dim V=6$ twice over.
- **$\mathfrak h=\mathfrak{su}(2)_{\pm}$ on a $4$-plane $P$, trivial on $P^{\perp}$** (and its enlargement by $\mathfrak{so}(2)_{P^{\perp}}$, which only shrinks the invariant space). Here $\mathfrak z(\mathfrak h)=\Lambda^{\pm}P\oplus\mathbb R\,\varepsilon$ with $\varepsilon$ the unit area form of $P^{\perp}$, and the case is settled by the following computation, which I believe is new.

**Claim.** *Let $\omega_i=a_i+b_i\varepsilon$ with $a_i\in\Lambda^+P$ be an orthonormal triple, and $\lambda$ with all $\lambda_i\ne0$ and $\sum\lambda_i=0$. If Ricci-flatness and first Bianchi both hold then $b=0$, so the support is $P$ and $\dim V=4$.*

*Proof.* Since $\omega_i$ is block-diagonal, $\omega_i^2=a_i^2\oplus(b_i\varepsilon)^2=-\tfrac12\lVert a_i\rVert^2\Pi_P-b_i^2\Pi_{P^{\perp}}$, and $\omega_i\wedge\omega_i=\lVert a_i\rVert^2\operatorname{vol}_P+2b_i\,a_i\wedge\varepsilon$. With $\lVert a_i\rVert^2=1-b_i^2$ and $\sum\lambda_i=0$ the two trace-type components coincide, and the system is exactly $$\sum_i\lambda_ib_i^2=0\quad\text{and}\quad\sum_i\lambda_ib_ia_i=0\ \text{ in }\Lambda^+P.$$ Let $A$ be the $3\times3$ matrix whose rows are the $a_i$ in an orthonormal basis of $\Lambda^+P$. Orthonormality reads $AA^{\mathsf T}+bb^{\mathsf T}=I_3$, and the second equation reads $A^{\mathsf T}(\lambda\odot b)=0$.

If $\lvert b\rvert<1$ then $AA^{\mathsf T}=I-bb^{\mathsf T}$ is positive definite, so $A^{\mathsf T}$ is injective and $\lambda_ib_i=0$ for every $i$, and the weights being nonzero, $b=0$.

If $\lvert b\rvert=1$ then $\lVert A^{\mathsf T}b\rVert^2=b^{\mathsf T}(I-bb^{\mathsf T})b=0$, so $b\in\ker A^{\mathsf T}$, and $\operatorname{rank}A=2$ makes $\ker A^{\mathsf T}=\mathbb Rb$ exactly. Hence $\lambda\odot b=cb$ for a scalar $c$, so $\lambda_i=c$ at every $i$ with $b_i\ne0$, and then $0=\sum_i\lambda_ib_i^2=c\lvert b\rvert^2=c$. So $c=0$ and $\lambda_i=0$ for some $i$, against the hypothesis. And $\lvert b\rvert>1$ is impossible. $\square$

**So the search for a $\dim V=6$ witness is confined to stabilisers of dimension $0$, $1$ or $2$**, and on the dimension-$0$ part the corrected count of §6 expects nothing. That is a usable next step and it is the constructive form of what the refutation gestures at when it says a solution set of exactly one orbit is the shape now consistent. *This section is my own derivation, produced under a Gate 2 brief rather than a research cycle, and it has had no independent audit.*

## 8. Claim R7: "nothing pointing either way" is not honest

The record at $\dim V=6$ carries: [L185](../findings/diagonal-half.md) emptying the all-decomposable branch at every width, [L186](../findings/diagonal-half.md) the one-non-decomposable branch, [L189](../findings/diagonal-half.md) the two-non-decomposable branch at every dimension, [L184](../findings/diagonal-half.md) and [L191](../findings/diagonal-half.md) the coincident-image case, and [L181](../findings/diagonal-half.md) every triple with a common plane splitting. The only surviving case is three non-decomposable image forms with distinct collinear images, and no witness exists at any $\dim V>4$ anywhere in the record. Add §6's corrected count and §7's exclusion of the large-stabiliser strata.

**Every one of those points the same way**, weakly and without proving anything. The honest sentence is not "nothing points either way" but something like: *the branch is open, and every sub-case attacked at $\dim V=6$ has closed empty, no witness above $\dim V=4$ exists, and the parameter count, corrected for the group action, expects emptiness with a deficit of ten on the principal stratum. None of that is a proof and the count in particular is not one.*

The refutation's stronger sentence, "the expectation had no support", is also wrong on its own terms: the expectation had the census, which is independent of the count and which the refutation does not mention.

**Verdict R7: REFUTED.**

## 9. Protocol

- **Locate exactly.** The note is [findings/diagonal-half.md](../findings/diagonal-half.md) at [line 786](../findings/diagonal-half.md#L786), and the three refutation boxes follow at [788](../findings/diagonal-half.md#L788), [790](../findings/diagonal-half.md#L790) and [792](../findings/diagonal-half.md#L792). The claims they bear on are [L179](../findings/diagonal-half.md), [L180](../findings/diagonal-half.md), [L181](../findings/diagonal-half.md), [L183](../findings/diagonal-half.md) and [L185](../findings/diagonal-half.md).
- **Exhibit concretely.** §4's $12$-dimensional padded family against the count's $5$, §5's two counterexamples to the rank inequality, §6's gauge-fixed derivation of $25$, and §7's closed-form disposal of the $\mathfrak{su}(2)$ stratum.
- **Argue the opposite.** §6 is the attempt to rescue the note, and it succeeds for the note's conclusion and fails for the note's argument. §2.2 is the attempt to break the refutation's stabiliser bound, and it breaks it in the refutation's favour on R3 and against it on the "$6$ against $6$" reconciliation. §5 is the attempt to break the refutation's reasoning, and it breaks a step while leaving the numbers standing.

**No candidate is withdrawn.** Every verdict above cleared all three.

## 10. Falsifiers, and what I did to look for them

**R1 is falsified by** an orbit through a solution failing to lie in the zero set, which needs the target action not to fix $0$, or by $F$ failing to be equivariant. **I checked equivariance on both components separately from the definitions**, and checked that the induced actions on $S^2_0$ and $\Lambda^4$ are linear. I also checked the step against the one escape a defender would reach for, a singular point of $S$, and found the argument does not touch $S$ at all.

**R2's sharp bound is falsified by** a $3$-dimensional $U\subseteq\Lambda^2\mathbb R^6$ with $\dim\mathfrak z(U)\ge5$. **I looked from both sides**: from the element side, by listing $\dim\mathfrak z(\omega)$ over all normal forms and finding that $\ge5$ forces a repeated nonzero $c_j$ at every element of $U$; and from the subalgebra side, by listing every conjugacy class of dimension $\ge5$ and computing its centraliser, all of which came out at $\le2$. The two sides agree that $4$ is the maximum and that the $\mathfrak{su}(2)\oplus\mathfrak{so}(2)$ configuration is the unique attaining class. **What would change it**: a conjugacy class of subalgebra I have not listed. This is a hand enumeration and it deserves a second pair of eyes.

**R5 is falsified by** the rank implication being true after all, which would need a hypothesis I did not see. **I looked for one**, specifically whether equivariance or the polynomiality of $F$ restores it, and built the $SO(2)$-equivariant counterexample precisely to rule out the first. Polynomiality does not help either: $F(x)=x^2$ is polynomial.

**R6 is falsified by** the slice count being unavailable or degenerate, which would need $F|_Z$ to be forced non-generic. **I looked for a forced degeneracy** and found the opposite: for finite $H$ the constraint on $F|_Z$ is vacuous in the relevant sense, and the same $25$ comes out of an explicit gauge fixing that uses no tube theorem. **What would change it**: a solution at $\dim V=6$ with a positive-dimensional stabiliser, which would move the question to a stratum where the count is not $25$ against $35$. §7 removes the stabiliser dimensions $\ge3$ from that possibility and leaves $1$ and $2$ open, so this is the live route.

**R7 is falsified by** the census pointing the other way, that is, by a $\dim V=6$ or $\dim V\ge8$ sub-case that closed *inhabited*. **I read the whole rank-three and rank-two census** in [findings/diagonal-half.md](../findings/diagonal-half.md) looking for one and found only the $\dim V=4$ witnesses, which are on the far side of the question.

**§7's claim is falsified by** an orthonormal triple in $\Lambda^+P\oplus\mathbb R\varepsilon$ with nonzero weights summing to zero, some $b_i\ne0$, satisfying both conditions. **The proof shows the constraint set forces $b=0$ in both branches of $\lvert b\rvert$**, and the branch $\lvert b\rvert=1$ is where I expected trouble and where the argument is tightest, since it is the only place $\ker A^{\mathsf T}$ is nonzero. A reader should attack that line first.

## 11. What the record should say

The note at [line 786](../findings/diagonal-half.md#L786) should be withdrawn as an argument and restated as a corrected count. The three refutation boxes should keep their first box, replace the "$\dim S\ge40-\operatorname{rank}$" reasoning of the second with "the orbit lies in $S$", drop "the count says nothing about emptiness" in favour of "the count must be taken on the quotient, where it reads $25$ against $35$", and replace "open with nothing pointing either way" with the sentence in §8. §4's family and §7's stratum result are worth folding in as they stand.
