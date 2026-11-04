# Review r861, I76: A-regularity at two eigenvalues, where the identity holds and the route it proposes is dead

Reviewer r861, 2026-09-10. The brief was cold: I read the brief and [L201Statement.lean](../lean/HamiltonsCubic/Results/L201Statement.lean) and nothing else of the record. No numerical work was done beyond screening claims I was about to record, on objects I constructed for that purpose, and every value in this report is exact and derived in closed form before any screen was run. The two screens are labelled as such in section 10 and are cited for nothing. Log: [agent_logs/review-r861-aregular.log](../agent_logs/review-r861-aregular.log).

## Claim table

| # | Claim as quoted | Verdict |
|---|---|---|
| 1 | The subtraction: $(\mu-\nu)S\mathbf1_A=-2(n-1)\nu\,\mathbf1$ from $S\lambda=0$ and $S\mathbf1=2(n-1)\mathbf1$ | **CORRECT** |
| 2 | $\mathbf1^{\mathsf T}S\mathbf1_A=2(n-1)a$, hence the constant $2(n-1)a/N$ | **CORRECT**, and at every index, not on average |
| 3 | "A two-eigenvalue critical point on this locus forces the Gram matrix to be $A$-regular" | **CORRECT BUT MIS-HYPOTHESISED**: criticality is inert, Ricci-flatness alone gives it |
| 4 | "$\mu\ne\nu$" as a hypothesis | **REDUNDANT** under $\mu>0>\nu$, and load-bearing only at the division |
| 5 | Tightness at $S^6\times S^6$: constant $10$, both cases $10$, counts $2(p-2)=8$ and $(p-1)+(q-1)=10$ | **CORRECT**, every count verified, and the tensor is genuinely a critical point at $\theta=\theta_0(12)=\sqrt{55}/6$ |
| 6 | "The eigenvalues having cancelled", the conclusion is "a condition on the configuration alone" | **CORRECT BUT UNDERSTATED AND LOOSELY PHRASED**: $A$ is weight-defined, and trace-freeness pins $\mu:\nu=(N-a):(-a)$ |
| 7 | "The question is whether $A$-regularity ... forces integrality" | **ANSWERED NO. REFUTED IN CLOSED FORM**, by the record's own Given 4, and again at the target $n=12$ |
| 8 | "If it does, every two-eigenvalue critical point on the locus is coordinate-diagonal ... at least THREE distinct eigenvalues" | **VALID AS A CONDITIONAL, VACUOUS IN FACT**: the antecedent is false |
| 9 | "That is a structural narrowing of the open half and it needs no new machinery" | **NOT SUSTAINED**: no narrowing is delivered, and in the coordinate case the condition is exactly R15's own |
| 10 | Lean `two_eigenvalue_A_regular` and `sum_trace_row` machine-checked and gap-free | **CONFIRMED**, no `sorryAx`, but the typed statement is both wider and narrower than the prose |
| 11 | Vacuity | **NOT VACUOUS**: $A$-regular subsets of the coordinate configuration are exactly the regular graphs on $n$ vertices |

## One-line summary

The linear algebra of I76 is right and the tightness check is right, but the item's own hoped-for route fails for a structural reason: $A$-regularity is invariant under rotation of a decomposable eigenbasis inside an eigenspace while integrality is not, so $A$-regularity can never force integrality, and Given 4 of this brief is already an explicit non-integral $A$-regular configuration.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices, $\varphi_{ab}=E_{ba}-E_{ab}$ is a UNIT bivector, and $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$, and at orthonormal $u,v$ this is a unit bivector with $(u\wedge v)(u\wedge v)^{\mathsf T}=\Pi_P$.
- $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ and $\sqrt{3/2}=1.224745$.
- The inner product on the $\Pi_\alpha$ is the plain $\mathop{\mathrm{tr}}(AB)$ with no factor $\tfrac12$ (Given 10).

## Hypothesis inventory

What the quoted block declares: $W$ critical, an orthonormal decomposable eigenbasis $\omega_1,\dots,\omega_N$ of $\Lambda^2\mathbb R^n$ with $N=\binom n2$, exactly two distinct eigenvalues $\mu>0>\nu$, $A=\{\alpha:\lambda_\alpha=\mu\}$ of size $a$.

What the derivation actually consumes:

| Hypothesis | Used? | Where |
|---|---|---|
| $S\lambda=0$, Ricci-flatness (Given 14) | **yes** | the whole identity |
| $S\mathbf1=2(n-1)\mathbf1$, completeness (Given 14) | **yes** | the subtraction and the constant |
| $\lambda$ takes exactly two values | **yes** | writing $\lambda=\nu\mathbf1+(\mu-\nu)\mathbf1_A$ |
| $\mu\ne\nu$ | **yes**, at the division only | section 1 |
| $N\ne0$ | **yes**, at the division by $N$ | section 2 |
| trace-freeness $\sum_\alpha\lambda_\alpha=0$ | **no** in the prose route, **yes** in the Lean route | sections 2, 10 |
| $\mu>0$, $\nu<0$ | **no** | section 3 |
| criticality $Q(W)=\theta W$ | **no** | section 3 |
| the $\omega_\alpha$ are decomposable | **no** for the identity, **yes** to exclude the kernel case | sections 3, 4 |
| first Bianchi | **no**, and it is free on this locus | section 3 |
| $S$ positive semidefinite | **no** for the identity, **yes** in section 4 | section 4 |

Two hypotheses of the quoted block are therefore decoration, criticality and the signs of $\mu$ and $\nu$, and one apparent hypothesis, trace-freeness, is a consequence of the other two: $\mathbf1^{\mathsf T}S\lambda=0$ and $S\mathbf1=2(n-1)\mathbf1$ give $2(n-1)\sum_\alpha\lambda_\alpha=0$, so $\mathop{\mathrm{tr}}W=0$ for every $n\ge2$.

## 1. The subtraction

Write $\lambda=\mu\mathbf1_A+\nu\mathbf1_B=\nu\mathbf1+(\mu-\nu)\mathbf1_A$, which is an identity of vectors in $\mathbb R^N$ and needs nothing. Apply $S$ and use linearity:

$$0=S\lambda=\nu\,S\mathbf1+(\mu-\nu)\,S\mathbf1_A=2(n-1)\nu\,\mathbf1+(\mu-\nu)\,S\mathbf1_A,$$

so $(\mu-\nu)\,S\mathbf1_A=-2(n-1)\nu\,\mathbf1$ exactly as written. **CORRECT.**

$\mu\ne\nu$ is not needed for this identity. It is needed one step later, to divide and reach

$$S\mathbf1_A=c\,\mathbf1,\qquad c=\frac{-2(n-1)\nu}{\mu-\nu},$$

which is the step that turns the identity into constancy of the $A$-row sums. Under the block's own $\mu>0>\nu$ the hypothesis $\mu\ne\nu$ is automatic, so listing it in prose is redundant. It earns its place in the Lean statement, where the signs are dropped. Note also that $c>0$ under $\mu>0>\nu$, and that the same computation applied to $B$ gives $S\mathbf1_B=(2(n-1)-c)\mathbf1$, so $A$-regularity and $B$-regularity are the same condition.

Had $\mu=\nu$ been allowed, the identity would read $0=-2(n-1)\nu\mathbf1$, forcing $\nu=0$ for $n\ge2$, hence $\lambda=0$ and $W=0$. So nothing is lost by the division except the zero tensor.

## 2. The constant, and whether it is pointwise or on average

Sum the vector identity against $\mathbf1$. The left side is $c\,\mathbf1^{\mathsf T}\mathbf1=cN$. The right side is

$$\mathbf1^{\mathsf T}S\mathbf1_A=\sum_{\beta\in A}\sum_{\alpha}\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=\sum_{\beta\in A}\mathop{\mathrm{tr}}\Big(\big(\textstyle\sum_\alpha\Pi_\alpha\big)\Pi_\beta\Big)=\sum_{\beta\in A}\mathop{\mathrm{tr}}\big((n-1)\Pi_\beta\big)=2(n-1)a,$$

using $\mathop{\mathrm{tr}}\Pi_\beta=2$. So $c=2(n-1)a/N$, which is the block's value. **CORRECT.** The column-sum route above needs no symmetry of $S$, and in any case $S$ is symmetric because $\mathop{\mathrm{tr}}(AB)=\mathop{\mathrm{tr}}(BA)$.

**At every index, not on average.** This is the point the phrasing risks blurring and it survives inspection: constancy of $\sum_{\beta\in A}S_{\alpha\beta}$ in $\alpha$ comes from the vector identity of section 1, and the average is used only to name the constant. The block's "at EVERY index $\alpha$" is therefore earned.

**What trace-freeness contributes.** Nothing to the quoted route, and it is anyway implied (see the hypothesis inventory). It does give a second, independent derivation of the same constant, which is a real cross-check: $a\mu+(N-a)\nu=0$ with $a\ge1$ gives $\mu=-(N-a)\nu/a$, hence $\mu-\nu=-\nu N/a$, hence

$$c=\frac{-2(n-1)\nu}{-\nu N/a}=\frac{2(n-1)a}{N}.$$

The two routes agree. It also yields something the block does not notice, recorded in section 6: the weights are not merely cancelled, they are determined.

Finally, $N\ne0$ is needed to divide. It is met whenever the setting is, since two distinct eigenvalues need $N\ge2$, hence $n\ge3$.

## 3. Degenerate cases, and the hypotheses that do no work

- **$a=0$.** Then $\mathbf1_A=0$ and section 1 gives $0=-2(n-1)\nu\mathbf1$, so $\nu=0$ and $W=0$. The stated conclusion reads $0=2(n-1)\cdot0/N$ and is true but empty. The block's "exactly TWO distinct eigenvalues" excludes $a=0$ anyway, since $\mu$ would not be attained.
- **$a=N$.** Then $B=\emptyset$, $S\mathbf1_A=2(n-1)\mathbf1$, and section 1 gives $\mu-\nu=-\nu$, so $\mu=0$ and again $W=0$. The formula reads $2(n-1)=2(n-1)N/N$ and is true.
- **$N=0$.** Then $n\le1$, $\Lambda^2\mathbb R^n=0$, there is no eigenbasis and the quotient by $N$ is undefined. The prose does not say $N\ne0$. The Lean statement does, correctly, as `hN`.
- **$\mu>0>\nu$.** Not used, and partly derivable: trace-freeness with $a\ge1$ and $N-a\ge1$ forces $\mu$ and $\nu$ to have opposite signs unless both vanish, and both vanishing contradicts distinctness. So the sign hypothesis is a naming convention.
- **Criticality.** Never used. The derivation consumes Ricci-flatness and completeness only. The claim is therefore true of every Ricci-flat two-eigenvalue $W$ with an orthonormal decomposable eigenbasis, a strictly larger class. As a theorem this is a strengthening. As a step in a programme it is a warning, because the condition cannot distinguish critical points from the much larger Ricci-flat family, and it is exactly that failure to discriminate which section 7 turns into a refutation.
- **First Bianchi.** Free on this locus. By Given 6, $\mathrm{Alt}(W)=\tfrac16\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha$, and each $\omega_\alpha$ is decomposable, so each $\omega_\alpha\wedge\omega_\alpha=0$ by Given 13. No condition on the weights.

## 4. The kernel case, $\nu=0$

The derivation survives it formally and the case is impossible. Suppose $\nu=0$. Then $\lambda=\mu\mathbf1_A$ with $\mu\ne0$, so $S\lambda=0$ gives $S\mathbf1_A=0$, and then

$$0=\mathbf1_A^{\mathsf T}S\mathbf1_A=\sum_{\alpha,\beta\in A}\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=\mathop{\mathrm{tr}}\Big(\big(\textstyle\sum_{\alpha\in A}\Pi_\alpha\big)^2\Big)=\Big\lVert\textstyle\sum_{\alpha\in A}\Pi_\alpha\Big\rVert_F^2,$$

so $\sum_{\alpha\in A}\Pi_\alpha=0$. Each $\Pi_\alpha$ is positive semidefinite of trace $2$, so the sum has trace $2a$, and it vanishes only for $a=0$. That contradicts $\mu$ being attained. The symmetric argument rules out $\mu=0$. So **a two-eigenvalue $W$ of this kind has no kernel among its two values**, and the block's $\mu>0>\nu$ is a theorem rather than an assumption.

This is the one place where the planes are load-bearing: the argument uses positive semidefiniteness of the $\Pi_\alpha$, which the general trace-two family of the Lean statement does not have. The block's aside that "nothing about planes is used" is accurate for the identity and inaccurate for this exclusion.

## 5. The tightness check at $S^6\times S^6$, verified independently

Take $n=12$, $p=q=6$, the standard frame, $\Pi_{ij}=E_{ii}+E_{jj}$, and $\mathop{\mathrm{tr}}(\Pi_{ij}\Pi_{kl})=\lvert\{i,j\}\cap\{k,l\}\rvert$.

**The configuration is the coordinate one.** By Given 15 the product's curvature operator is diagonal on the coordinate plane basis, so the eigenbasis is $\{e_i\wedge e_j\}$, which is orthonormal, decomposable, and of size $\binom{12}2=66=N$. Completeness holds: $\sum_{i<j}(E_{ii}+E_{jj})=11\,\mathrm{Id}$, matching Given 1.

**The weights are two-valued, and exact.** Each unit $S^6$ has scalar curvature $p(p-1)=30$, so the product has $\mathrm{scal}=60$, and $p=q$ makes it Einstein, so by Given 15 the Weyl part is the curvature operator less $\mathrm{scal}/(n(n-1))=60/132=5/11$ on every plane:

$$\mu=1-\tfrac5{11}=\tfrac6{11}\ \text{on the }30\text{ within-factor planes},\qquad \nu=0-\tfrac5{11}=-\tfrac5{11}\ \text{on the }36\text{ cross planes}.$$

Trace-free: $30\cdot\tfrac6{11}+36\cdot(-\tfrac5{11})=\tfrac{180-180}{11}=0$. Two distinct values with $\mu>0>\nu$.

**Sizes.** $a=2\binom62=30$, cross planes $6\cdot6=36$, and $30+36=66=N$. The block's $a$ and $N$ are right.

**The constant.** $2(n-1)a/N=2\cdot11\cdot30/66=660/66=10$. And independently from section 1, $c=-2\cdot11\cdot(-\tfrac5{11})/(\tfrac6{11}+\tfrac5{11})=10/1=10$. Both routes give $10$.

**Case $\alpha\in A$, $\alpha=\{1,2\}$.** Diagonal $2$. Within-factor planes meeting $\{1,2\}$ in one index are $\{1,k\}$ and $\{2,k\}$ for $k\in\{3,4,5,6\}$, which is $2(p-2)=8$ planes at trace $1$. The remaining within-factor planes of factor one, $\binom42=6$ of them, and all $15$ of factor two are disjoint from $\{1,2\}$ and contribute $0$. Total $2+8=10$. The block's $2(p-2)=8$ is right.

**Case $\alpha\in B$, $\alpha=\{1,7\}$.** No diagonal term, since $\alpha\notin A$. Within-factor planes meeting $\alpha$ are $\{1,k\}$ for $k\in\{2,\dots,6\}$, which is $p-1=5$, and $\{7,k\}$ for $k\in\{8,\dots,12\}$, which is $q-1=5$, each at trace $1$. Total $10$. The block's $p-1=5$ and $q-1=5$ are right.

**Both cases return $10$ exactly. The tightness claim is CORRECT.**

**And $S\lambda=0$ closes independently.** The $B$-row sums are $2(n-1)-10=12$ in both cases, verified by hand at $\{1,2\}$ (the $12$ cross planes $\{1,j\}$ and $\{2,j\}$, $j\ge7$) and at $\{1,7\}$ (diagonal $2$, plus $\{1,j\}$ for $j\in\{8,\dots,12\}$ and $\{i,7\}$ for $i\in\{2,\dots,6\}$, which is $2+5+5=12$). Then $\tfrac6{11}\cdot10+(-\tfrac5{11})\cdot12=\tfrac{60-60}{11}=0$ at every index.

**The tensor really is critical, which the brief's givens do not assert.** I checked it rather than assume it. For a coordinate-diagonal $W$ the operator $W^\#$ is diagonal too, because $W$ is invariant under the sign group $\{\pm1\}^n$ and $\omega_{ij}\mapsto\varepsilon_i\varepsilon_j\omega_{ij}$ separates the pairs, so any equivariant symmetric operator is diagonal, and criticality is exactly relation (C) of Given 12. The structure constants are unit: with $\varphi_{ab}=E_{ba}-E_{ab}$, $[\omega_{12},\omega_{23}]=E_{13}-E_{31}=-\omega_{13}$, so $T_{\alpha\beta\gamma}=1$ on triangles of planes and $0$ otherwise. Using the unnormalised weights $\mu=p$, $\nu=-(p-1)$, at a within-factor $k$ the triangles through $k$ have a third vertex either in the same factor ($p-2$ choices, both other planes within-factor) or in the other ($p$ choices, both cross), so $2(W^\#)_{kk}=2(p-2)\mu^2+2p\nu^2$ and

$$Q_{kk}=\mu^2+(p-2)\mu^2+p\nu^2=(p-1)p^2+p(p-1)^2=p(p-1)(2p-1),\qquad Q_{kk}/\mu=(p-1)(2p-1).$$

At a cross $k$ the third vertex lies in one factor or the other, $2(p-1)$ choices, and each triangle pairs a within-factor plane with a cross plane, so $(W^\#)_{kk}=2(p-1)\mu\nu$ and

$$Q_{kk}=\nu^2+2(p-1)\mu\nu=(p-1)^2-2p(p-1)^2=(p-1)^2(1-2p),\qquad Q_{kk}/\nu=(p-1)(2p-1).$$

The two ratios agree, so $Q=\kappa W$ and the point is critical for every $p$. Restoring the scale $1/(2p-1)$ and using $\lVert W\rVert^2=p^2(p-1)/(2p-1)$ gives

$$\theta(S^p\times S^p)=\frac{p-1}{\lVert W\rVert}=\frac{\sqrt{(p-1)(2p-1)}}{p}=\theta_0(2p),$$

since $\theta_0(2p)=\sqrt{2(2p-1)(2p-2)}/(2p)=\sqrt{(2p-1)(p-1)}/p$. At $p=6$ this is $\sqrt{55}/6$, and $\lVert W\rVert^2=180/11$, $Q=5W$, $P=900/11$. So the block's "conjectured maximiser" sits exactly at $\theta_0(n)$, which is an independent confirmation that my spectrum $(6/11,-5/11)$ is the right one. At $p=2$ this gives $\theta_0(4)=\sqrt3/2=0.866025$, below the $\sqrt{3/2}=1.224745$ of Given 5, consistent with $\mathbb{CP}^2$ beating the product at $n=4$.

## 6. Is the conclusion a condition on the configuration alone?

**Written out, and correctly, the conclusion is:** there exists $A\subseteq\{1,\dots,N\}$ with $\sum_{\beta\in A}S_{\alpha\beta}=2(n-1)\lvert A\rvert/N$ at every $\alpha$. No $\mu$ or $\nu$ occurs, so the block's "the eigenvalues having cancelled" is right about the numbers. It is loose about the set: $A$ is defined as a level set of the weights, so the honest form of the statement is existential over subsets, and it is that existential which is a condition on $S$ alone.

**The condition has a clean equivalent, and the converse holds.** Given any $A$ with $0<a<N$ and $S\mathbf1_A=c\mathbf1$, $c=2(n-1)a/N$, put $\mu=N-a$ and $\nu=-a$. Then $\lambda=\nu\mathbf1+(\mu-\nu)\mathbf1_A$ satisfies

$$S\lambda=2(n-1)\Big(\nu+(\mu-\nu)\frac aN\Big)\mathbf1=2(n-1)\Big(-a+N\cdot\frac aN\Big)\mathbf1=0.$$

So $A$-regularity for some proper non-empty $A$ is **equivalent** to the existence of a two-valued vector in $\ker S$, and the item's condition is exactly a statement about $\ker S$. Since $S$ is the Gram matrix of the $\Pi_\alpha$ its rank is $\dim\mathop{\mathrm{span}}\{\Pi_\alpha\}\le\binom{n+1}2$, and for the coordinate configuration the rank is $n$ (the $\Pi_{ij}=E_{ii}+E_{jj}$ span the diagonal matrices), matching the multiplicity $\binom n2-n$ of the eigenvalue $-2$ in Given 11. The kernel is large, so such subsets are plentiful. See section 11.

**And the weights are determined, which the block misses.** Trace-freeness is implied, and it gives $\mu:\nu=(N-a):(-a)$, so on a fixed configuration with a fixed $A$ the two-eigenvalue Ricci-flat tensor is unique up to scale. The claim "the eigenvalues cancel" is therefore weaker than the truth, which is that they are pinned by $a$ and $N$.

**Does $a$ depend on the weights?** Only through which level set is called $A$, and by the $A/B$ symmetry of section 1 the choice is a labelling. What does not depend on the weights is the pair $\{A,B\}$ once the tensor is fixed, and what does not depend on the tensor at all is the family of $A$-regular subsets of $S$.

## 7. The proposed route is refuted, in closed form, twice

The block asks "whether $A$-regularity of a positive semidefinite Gram matrix of rank-two plane projections, with row sums $2(n-1)$ and off-diagonal entries in $[0,1]$, forces integrality". **The answer is no, and the counterexample is Given 4 of this brief.**

### 7.1 The structural reason, before any example

$A$-regularity follows from Ricci-flatness for **every** orthonormal decomposable eigenbasis of a two-eigenvalue $W$, by section 1, which uses nothing but the weights and completeness. But an eigenbasis of a two-eigenvalue $W$ is far from unique: the eigenspaces have dimensions $a$ and $N-a$, and any orthogonal change of basis inside either one is again an eigenbasis. Integrality of the pairwise traces is **not** invariant under such a change, while $A$-regularity is. Therefore no implication from $A$-regularity to integrality can exist, as soon as one two-eigenvalue example admits an eigenspace rotation that keeps the forms decomposable and moves a trace off $\{0,1\}$. Given 4 exhibits exactly such a rotation, and section 7.3 performs it at the target itself.

### 7.2 The $n=4$ witness, all values exact

Take Given 4 verbatim: $g_2=\cos t\,e_2+\sin t\,e_3$, $g_3=-\sin t\,e_2+\cos t\,e_3$, $\sin2t\ne0$, and the six forms

$$\omega_1=e_1\wedge g_2,\quad\omega_2=e_1\wedge g_3,\quad\omega_3=e_1\wedge e_4,\quad\omega_4=e_2\wedge e_3,\quad\omega_5=e_2\wedge e_4,\quad\omega_6=e_3\wedge e_4,$$

with the Ricci-flat weight vector Given 4 supplies, $\lambda=(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$. **That vector is two-valued**, so $A=\{1,2,5,6\}$, $a=4$, $N=6$, $n=4$. Writing $c=\cos t$, $s=\sin t$ and using $\mathop{\mathrm{tr}}(\Pi_P\Pi_{P'})=\sum_{i,j}\langle u_i,v_j\rangle^2$:

$$S=\begin{pmatrix}2&1&1&1&c^2&s^2\\1&2&1&1&s^2&c^2\\1&1&2&0&1&1\\1&1&0&2&1&1\\c^2&s^2&1&1&2&1\\s^2&c^2&1&1&1&2\end{pmatrix}$$

Every row sums to $6=2(n-1)$, as Given 1 requires. The $A$-row sums, target $2(n-1)a/N=2\cdot3\cdot4/6=4$:

$$2+1+c^2+s^2=4,\quad 1+2+s^2+c^2=4,\quad 1+1+1+1=4,\quad 1+1+1+1=4,\quad c^2+s^2+2+1=4,\quad s^2+c^2+1+2=4.$$

**All six are $4$. The configuration is $A$-regular, and its Gram matrix is not integral**, since $c^2,s^2\in(0,1)$ whenever $\sin2t\ne0$. It is positive semidefinite because it is a Gram matrix, its off-diagonal entries lie in $[0,1]$ by Given 8, its row sums are $2(n-1)$, and its planes are rank-two projections. Every clause of the block's antecedent is met and the consequent fails.

**The witness is a genuine critical point, not merely Ricci-flat.** Its operator is $\lambda_{12}=\lambda_{13}=\lambda_{24}=\lambda_{34}=\tfrac12$ and $\lambda_{14}=\lambda_{23}=-1$ in the coordinate plane basis, which is equal on complementary pairs, so it preserves $\Lambda^\pm$ and acts as $\mathcal A=\mathop{\mathrm{diag}}(\tfrac12,\tfrac12,-1)$ on each chirality, trace-free as Given 3 requires. Then $\mathcal A^2=\mathop{\mathrm{diag}}(\tfrac14,\tfrac14,1)$, $\mathop{\mathrm{tr}}(\mathcal A^2)=\tfrac32$, and Given 3 gives

$$W^\#\big\vert_{\Lambda^\pm}=2\mathcal A^2-\tfrac32\mathrm{Id}=\mathop{\mathrm{diag}}(-1,-1,\tfrac12),\qquad Q=W^2+W^\#=\mathop{\mathrm{diag}}(-\tfrac34,-\tfrac34,\tfrac32)=-\tfrac32\,\mathcal A.$$

So $Q=-\tfrac32W$, criticality holds, $\lVert W\rVert^2=4\cdot\tfrac14+2\cdot1=3$, $P=-\tfrac92$ and $\theta=-\tfrac92/3^{3/2}=-\sqrt3/2=-\theta_0(4)$. The witness is $-\tfrac32W_{S^2\times S^2}$ for the factor split $\{e_1,e_4\},\{e_2,e_3\}$, and $P(-W)=-P(W)$ makes that critical whenever the product is, which section 5 proved for all $p$.

**So the $n=4$ witness is a two-eigenvalue critical point with an orthonormal decomposable eigenbasis whose Gram matrix is $A$-regular and non-integral.** The conclusion of Given 4 is untouched: the operator is coordinate-diagonal after all, reached by rotating $\omega_1,\omega_2$ back inside the $\tfrac12$-eigenspace. That is precisely the point. Coordinate-diagonality of the operator is weaker than integrality of a given eigenbasis, and the item is aiming at the stronger and false statement.

### 7.3 The same falsifier at the target, $n=12$

Take $W_{S^6\times S^6}$ of section 5 and replace the two within-factor forms $e_1\wedge e_2$ and $e_1\wedge e_3$ by $e_1\wedge g_2$ and $e_1\wedge g_3$ with the same $g_2,g_3$. Both lie in $\mathop{\mathrm{span}}\{e_1\wedge e_2,e_1\wedge e_3\}$, which sits inside the $\mu$-eigenspace, both are decomposable, and the change is orthogonal, so the result is again an orthonormal decomposable eigenbasis of the same tensor. Hence:

- $A$-regularity holds with constant exactly $10$, by section 1, with no computation.
- The trace $\mathop{\mathrm{tr}}(\Pi_{e_1\wedge g_2}\Pi_{e_2\wedge e_4})=\cos^2t\notin\{0,1\}$, so the configuration is not integral.
- The scalar quantity of Given 10 drops by an exact amount. Only the entries against $\Pi_{2k}$ and $\Pi_{3k}$ for $k\notin\{1,2,3\}$ move, $n-3$ of each per rotated form, from $(1,0)$ to $(\cos^2t,\sin^2t)$, so

$$\Xi=n^2(n-1)-2(n-3)\sin^2 2t,$$

which is $48-2\sin^22t$ at $n=4$ and $1584-18\sin^22t$ at $n=12$, strictly below the bound of Given 10 for $\sin2t\ne0$. By Given 10 that alone certifies non-integrality.

**So the very configuration the block cites as its tightness check carries a non-integral $A$-regular eigenbasis.** The tightness check does not distinguish the coordinate configuration from a rotated one, because the condition it checks is blind to the rotation.

## 8. The inference the block draws from the hoped-for implication

Quoted: "If it does, every two-eigenvalue critical point on the locus is coordinate-diagonal, hence inside the granted half, and the non-diagonal case carries at least THREE distinct eigenvalues."

- **The chain is valid as a conditional.** $A$-regularity $\Rightarrow$ integrality, then integrality plus Given 9 (L201) gives the planes as the coordinate 2-planes of one orthonormal frame, and a $W$ diagonal on those forms is coordinate-diagonal. The contrapositive then gives at least three distinct eigenvalues in the non-diagonal case. No step of that reasoning is faulty.
- **It is vacuous.** Section 7 refutes the antecedent by explicit object, so the conditional carries no information.
- **It cannot be repaired by weakening the antecedent.** The repair a reader would reach for is existential, "every two-eigenvalue $W$ on the locus admits an integral decomposable eigenbasis", which is what coordinate-diagonality actually needs. That may well be true. But $A$-regularity holds for **all** decomposable eigenbases of such a $W$, integral or not, so it cannot possibly separate the ones that admit an integral choice from the ones that do not. **$A$-regularity is not a tool for this question**, and the item's "it needs no new machinery, only the Gram matrix and the classification of the regular cases" is the mistake: the Gram matrix of one eigenbasis is not an invariant of $W$.
- **"Inside the granted half" is not checkable from this brief.** The brief never states what the granted half is. If it means the coordinate-diagonal case, the step is a tautology and the phrase is harmless. Whether the granted half in fact covers coordinate-diagonal points with two eigenvalues is a question about a file I was told not to open, and I record it as unverified rather than guess.

## 9. What the item does deliver, and it is less than claimed

Restricted to the coordinate configuration the condition is computable in closed form and turns out to be R15's own condition, one notch weaker. There $\sum_\alpha\lambda_\alpha\Pi_\alpha=0$ reads, row by row, $\sum_{j\ne i}\lambda_{ij}=0$ at each vertex $i$. For a two-valued $\lambda$ with $\mu$ on an edge set $G$ and $\nu$ off it, that is

$$\mu\,d_G(i)+\nu\,(n-1-d_G(i))=0\quad\text{at every }i,$$

so **$G$ is a regular graph**, of some degree $d$, with $\mu d=-\nu(n-1-d)$. Then $a=nd/2$ and the constant is

$$c=\frac{2(n-1)a}{N}=\frac{2(n-1)\cdot nd/2}{\binom n2}=2d.$$

At $S^6\times S^6$ the set $A$ is two disjoint $K_6$, which is $5$-regular, so $c=2\cdot5=10$. That is a third independent derivation of the block's $10$, and it explains where the number comes from. Criticality then upgrades regular to strongly regular, which is exactly the correspondence of Given 16 and R15's diagonal side. So the claim "here the same condition arrives without assuming diagonality" is literally true and delivers nothing new: on the diagonal locus the condition is one notch weaker than what R15 already has, and off it the condition is satisfied by rotated bases that carry no integrality information. **The "structural narrowing of the open half" is not delivered.**

## 10. The Lean file

Built clean with `lake build HamiltonsCubic.Results.L201Statement`, 8708 jobs, the only `sorry` at line 77, which is `integrality_forces_frame` and is openly declared as the gap in its own docstring. Axioms:

| Declaration | Axioms |
|---|---|
| `two_eigenvalue_A_regular` | `propext`, `Classical.choice`, `Quot.sound` |
| `sum_trace_row` | `propext`, `Classical.choice`, `Quot.sound` |
| `sum_trace_off` | `propext`, `Classical.choice`, `Quot.sound` |
| `integrality_forces_frame` | the same plus `sorryAx` |

**So the block's "machine-checked and gap-free" is CONFIRMED for the two declarations it names.** The typed statement differs from the prose in four ways, none of them fatal and all worth recording.

1. **Wider on the objects, correctly.** `P : Fin N → Matrix (Fin n) (Fin n) ℝ` carries only `htr : (P a).trace = 2` and `hsum : ∑ a, P a = ((n:ℝ)-1) • 1`. Nothing says the `P a` are symmetric, idempotent, positive semidefinite, or rank two. The theorem is therefore stronger than the prose and vindicates "nothing about planes is used". It also forces $N=\binom n2$ for free: taking traces of `hsum` gives $2N=n(n-1)$.
2. **Narrower on the hypotheses.** `htf : (A.card)*μ + (N - A.card)*ν = 0` is assumed, and the Lean proof genuinely uses it, at `linear_combination (N:ℝ) * hkey - T * htf`. The prose route of section 2 does not need trace-freeness, deriving the constant from $\mathbf1^{\mathsf T}S\mathbf1_A$ instead. So the file proves a formally weaker statement by a different argument than the one the block describes, and the file's own docstring is the accurate one: "the weights enter only through trace-freeness". Since trace-freeness follows from `hricci` and `hsum` for $n\ne1$, the loss is only formal, but the block should not present the Lean theorem as the typed form of its own derivation.
3. **The Ricci hypothesis is the right one.** `hricci : ∀ a, ∑ b, (if b ∈ A then μ else ν) * (P a * P b).trace = 0` is row-wise $S\lambda=0$ with $S_{ab}=\mathop{\mathrm{tr}}(P_aP_b)$, and the conclusion is universally quantified in `a`, so "at EVERY index" is what is typed, not an average.
4. **The degenerate cases are handled where the prose is silent.** `hN : (N:ℝ) ≠ 0` covers section 3, `hne : μ ≠ ν` is exactly the division of section 1, and the sign hypotheses are absent, correctly.

One further note on what the Lean file does **not** say. There is no declaration anywhere in it connecting $A$-regularity to integrality, and `integrality_forces_frame` is L201 itself, the converse direction. Nothing in the file is touched by section 7, which refutes a hoped-for implication that was never typed.

**Screening, disclosed.** Two screens were run on objects I constructed, after the closed forms above were derived, purely to catch arithmetic slips. The $n=4$ Gram matrix reproduced the displayed $S$, the row sums $6$, the $A$-row sums all $4$, $S\lambda=0$, spectrum $\{0,0.830033,1.169967,2,2,6\}$ at $t=0.7$, and $\Xi=46.05778$ against the exact $48-2\sin^2 1.4$. The $n=12$ rotation reproduced orthonormality of all $66$ forms, $\sum\Pi=11\,\mathrm{Id}$, $S\lambda=0$, $A$-row sums identically $10$, off-diagonal values $\{0,\sin^2t,\cos^2t,1\}$, and $\Xi=1566.52$ against the exact $1584-18\sin^2 1.4$. Both agree with the closed forms to machine precision. **They are cited for nothing. The evidence is the closed form.**

## 11. Vacuity, and what a falsifier would be

**Item is not vacuous.** By section 9, every $d$-regular graph on $n$ vertices gives a two-eigenvalue Ricci-flat tensor on the coordinate configuration, with $\mu:\nu=(n-1-d):(-d)$, and by Given 16 the critical ones among them are the strongly regular graphs. $S^p\times S^p$ is the case $G=2K_p$, and section 5 confirmed by hand that it is critical, at $\theta=\theta_0(2p)$. So two-eigenvalue critical points with a decomposable orthonormal eigenbasis exist for every even $n\ge4$.

**Every example I can exhibit in closed form is coordinate-diagonal as an operator**, so the target conclusion of the item survives everything in this review. What does not survive is the route.

**The falsifier, named.** The object that would break the regularity conclusion of section 1 is a configuration of $N=\binom n2$ planes whose wedges are an orthonormal basis of $\Lambda^2\mathbb R^n$, carrying a two-valued Ricci-flat weight vector, with $\sum_{\beta\in A}S_{\alpha\beta}$ **not** constant in $\alpha$. **No such object exists**, and I did not need to look: the conclusion is a two-line consequence of $S\lambda=0$ and $S\mathbf1=2(n-1)\mathbf1$, both established in Given 14, and the Lean file proves it under hypotheses weaker still. The falsifier for the item's **route** is a different object, namely a non-integral $A$-regular configuration, and that one I found in the brief itself at Given 4 and then constructed at the target by rotating inside the $\mu$-eigenspace. Both are exhibited in closed form in section 7, with every value exact.

## Verdict

**The identity is CORRECT and the tightness check is CORRECT. The programme claim built on them is REFUTED.**

- Sections 1, 2 and 5: the subtraction, the constant, the pointwise quantifier and the $S^6\times S^6$ check all stand, by independent derivation, three times over for the constant $10$.
- Sections 3 and 4: criticality and the signs of $\mu$ and $\nu$ are unused, trace-freeness is implied rather than assumed, the case of a zero eigenvalue is impossible rather than uninformative, and $N\ne0$ is missing from the prose. The block should be restated as a fact about Ricci-flat two-eigenvalue tensors, not critical ones.
- Section 6: the conclusion is a condition on the configuration alone once phrased existentially, and it is equivalent to $\ker S$ containing a two-valued vector. The weights are pinned by $a$ and $N$, which strengthens the block.
- Sections 7 and 8: "does $A$-regularity force integrality" is answered **no**, in closed form, at $n=4$ by the record's own Given 4 and at $n=12$ by the same rotation applied to the target. The structural reason is that $A$-regularity is invariant under eigenspace rotations of the eigenbasis and integrality is not, so no such implication can exist. The narrowing the item promises does not follow, and the promised route needs replacing, not repairing.
- Section 9: on the coordinate locus the condition is exactly "$A$ is a regular graph", one notch weaker than R15's strongly regular, so the item adds nothing there either.
- Section 10: both named Lean declarations are gap-free with no `sorryAx`, the statement is wider than the prose on the objects and narrower on the hypotheses, and nothing in the file is touched by the refutation.

**Recommendation.** Keep the identity, and record it as a Ricci-flat statement with the section 6 strengthening and the section 4 exclusion attached. Withdraw the "what it would deliver" paragraph in full, and record Given 4 against it as the reason. If the coordinate-diagonality of two-eigenvalue critical points is to be attacked from the Gram matrix, the quantity attacked has to be an invariant of $W$ rather than of a chosen eigenbasis, and $\max_{\text{eigenbases}}\Xi$ is the first candidate that has that property.
