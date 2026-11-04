# Review r860, I76: the $A$-regularity of the Gram matrix at two eigenvalues

**Cold brief.** This review was written from the brief alone plus the one Lean file it names, [L201Statement.lean](../lean/HamiltonsCubic/Results/L201Statement.lean). No findings file, plan, route, reference note or earlier review was read. **No numerical work beyond screening was done**: the two closed-form derivations below were carried out by hand in general $\cos t,\sin t$ and then screened in exact rational arithmetic at $\cos t=3/5$ on objects constructed for that purpose, and the screens agreed to the last digit. **Every value reported is exact.** Log: [agent_logs/review-r860-aregular.log](../agent_logs/review-r860-aregular.log).

## Claim table

| # | Claim as written in the I76 block | Verdict |
|---|---|---|
| 1 | $(\mu-\nu)S\mathbf1_A=-2(n-1)\nu\,\mathbf1$ from $S\lambda=0$ and $S\mathbf1=2(n-1)\mathbf1$ | **HOLDS**, and unconditionally: $\mu\ne\nu$ is needed only for the "hence" |
| 2 | $\mathbf1^{\mathsf T}S\mathbf1_A=2(n-1)a$ | **HOLDS** |
| 3 | $\sum_{\beta\in A}S_{\alpha\beta}=2(n-1)a/N$ at EVERY index $\alpha$ | **HOLDS**, at every index and not merely on average |
| 4 | Trace-freeness is what the weights enter through | **FALSE AS A NECESSITY.** Trace-freeness is redundant, and it is *implied* by Ricci-flatness plus completeness |
| 5 | "a combinatorial condition on the configuration alone" | **OVERSTATED.** It is a linear condition on a real matrix, and on the pair (configuration, subset), not the configuration alone |
| 6 | Tightness at $S^6\times S^6$: constant $10$, both cases return $10$ | **HOLDS.** Verified in closed form, and it generalises to every $S^p\times S^p$ with constant $2(p-1)$ |
| 7 | "is not vacuous" | **HOLDS.** $S^6\times S^6$ is a genuine two-eigenvalue critical point, at $\theta=\sqrt{55}/6=\theta_0(12)$ exactly |
| 8 | "the question is whether $A$-regularity ... forces integrality" | **ANSWERED NO. REFUTED IN CLOSED FORM** by the record's own given 4, at $n=4$ |
| 9 | "If it does, every two-eigenvalue critical point on the locus is coordinate-diagonal" | **VALID AS A CONDITIONAL, VACUOUS IN FACT.** The antecedent is false, so this route to the conclusion is closed |
| 10 | "the non-diagonal case carries at least THREE distinct eigenvalues" | **FOLLOWS FROM THE (FALSE) ANTECEDENT**, and the narrowing is thin: $W_{\mathbb{CP}^2}$ already has three |
| 11 | "That is a structural narrowing ... and it needs no new machinery" | **REFUTED.** The step is an equivalence, so it narrows nothing, and the machinery it needs is new |
| 12 | `two_eigenvalue_A_regular` machine-checked and gap-free | **HOLDS.** Three standard axioms only, and the typed statement is strictly WIDER than the prose |
| 13 | "the hypotheses are trace two, completeness, trace-freeness, $\mu\ne\nu$ and the Ricci rows" | **INCOMPLETE.** The Lean statement also carries $N\ne0$, which the prose does not name |
| 14 | *New finding.* $A$-regularity with the stated constant is **EQUIVALENT** to the existence of a two-valued Ricci-flat weighting | **ESTABLISHED HERE.** I76 is a change of variables, not a new constraint |

## Summary in one line

The two-line derivation is correct and the arithmetic at $S^6\times S^6$ is correct, but the step is an *equivalence* rather than a narrowing, and the implication it was built to test is refuted in closed form by the record's own rotated witness: an $A$-regular Gram matrix at $n=4$ with off-diagonal entries $9/25$ and $16/25$.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices, $\varphi_{ab}=E_{ba}-E_{ab}$ is a UNIT bivector, and $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$, so at orthonormal $u,v$ this is a unit bivector and $(u\wedge v)(u\wedge v)^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_P$.
- $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ and $\sqrt{3/2}=1.224745$.
- $S_{\alpha\beta}=\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)$ with the plain trace pairing and no factor $\tfrac12$ (given 10, given 14).

## Hypothesis inventory

What the I76 derivation actually consumes, listed against what the block declares.

| Ingredient | Where it comes from | Used? |
|---|---|---|
| $S\lambda=0$, i.e. Ricci-flatness | given 14 | **Yes**, at every row |
| $S\mathbf1=2(n-1)\mathbf1$, i.e. completeness | given 1, given 14 | **Yes**, at every row |
| $S$ symmetric | $\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=\mathop{\mathrm{tr}}(\Pi_\beta\Pi_\alpha)$ | **Yes**, for the constant by the summation route |
| $\lambda$ two-valued with $\mu\ne\nu$ | hypothesis of the block | **Yes**, for the division |
| $\mathop{\mathrm{tr}}W=0$ | membership of $\mathcal W_n$ | **No**, redundant and implied (section 2) |
| $N\ne0$ | forced by $n\ge2$ | **Yes**, for the final division |
| Criticality $W^2+W^\#=\theta W$ | hypothesis of the block | **NO. Never used anywhere** |
| $S_{\alpha\alpha}=2$, $S_{\alpha\beta}\in[0,1]$, $S\succeq0$, decomposability, first Bianchi | givens 8, 14, 6 | **No** |
| $\mu>0>\nu$ | hypothesis of the block | **No**, and it is a consequence (section 4) |

The block's own summary of the Lean hypotheses is therefore right about "nothing about planes is used" and understates the case: nothing about **criticality** is used either, so the result is a statement about Ricci-flat two-eigenvalue $W$ on the decomposable locus, critical or not.

## 1. The subtraction

Write $\lambda=\mu\mathbf1_A+\nu\mathbf1_B$ with $\mathbf1_B=\mathbf1-\mathbf1_A$. Then

$$0=S\lambda=\mu S\mathbf1_A+\nu S(\mathbf1-\mathbf1_A)=(\mu-\nu)S\mathbf1_A+\nu S\mathbf1=(\mu-\nu)S\mathbf1_A+2(n-1)\nu\,\mathbf1,$$

which rearranges to the block's display. **This is pure linearity and holds for every $\mu,\nu$ including $\mu=\nu$**, where it degenerates to $0=2(n-1)\nu\mathbf1$. So the display as printed needs no hypothesis at all.

Where $\mu\ne\nu$ enters is the word **hence**. Dividing by $\mu-\nu$ gives

$$\sum_{\beta\in A}S_{\alpha\beta}=\frac{-2(n-1)\nu}{\mu-\nu}\qquad\text{at every index }\alpha,$$

and the right-hand side is a single number, independent of $\alpha$. That constancy across indices is the whole content of "$A$-regular", and it is exactly the step that fails at $\mu=\nu$. The block places $\mu\ne\nu$ correctly among the hypotheses, and a reader who takes the display itself as needing it has been mildly misled.

## 2. The constant, and what trace-freeness contributes

**$\mathbf1^{\mathsf T}S\mathbf1_A=2(n-1)a$ is right.** Since $S$ is symmetric, $\mathbf1^{\mathsf T}S\mathbf1_A=(S\mathbf1)^{\mathsf T}\mathbf1_A=2(n-1)\mathbf1^{\mathsf T}\mathbf1_A=2(n-1)a$.

There are two routes to the constant, and they consume different hypotheses.

**Route A, the one the Lean proof takes.** Trace-freeness reads $a\mu+(N-a)\nu=0$. For $a\ne N$ this gives $\nu=-a\mu/(N-a)$ and $\mu-\nu=\mu N/(N-a)$, so

$$\frac{-2(n-1)\nu}{\mu-\nu}=-2(n-1)\cdot\frac{-a\mu/(N-a)}{\mu N/(N-a)}=\frac{2(n-1)a}{N}.$$

Written that way the route appears to divide by $\mu$, and the Lean proof avoids that by combining instead: from $(\mu-\nu)X=-\nu T$ with $T=2(n-1)$ and $X$ the $A$-row sum, the combination $N\cdot(\text{that})-T\cdot(\text{trace-freeness})$ collapses to $(\mu-\nu)(NX-Ta)=0$, and $\mu\ne\nu$ finishes it. That is [L201Statement.lean:177-182](../lean/HamiltonsCubic/Results/L201Statement.lean#L177-L182) and it is clean.

**Route B, which the block's parenthetical actually describes.** Once constancy is known, write the common value as $c$ and sum over all $\alpha$: $cN=\mathbf1^{\mathsf T}S\mathbf1_A=2(n-1)a$, hence $c=2(n-1)a/N$. **Route B never mentions trace-freeness.**

So the answer to "check what trace-freeness contributes and whether it is used" is: **it is used in the Lean proof and it is not needed**, and worse for the docstring's claim that "the weights enter only through trace-freeness", trace-freeness is a *consequence* of the other hypotheses. Pair $S\lambda=0$ with completeness:

$$0=\mathbf1^{\mathsf T}S\lambda=(S\mathbf1)^{\mathsf T}\lambda=2(n-1)\sum_\alpha\lambda_\alpha=2(n-1)\mathop{\mathrm{tr}}W,$$

so $\mathop{\mathrm{tr}}W=0$ for every $n\ne1$. **Ricci-flatness plus completeness implies trace-freeness on this locus.** The hypothesis `htf` in [two_eigenvalue_A_regular](../lean/HamiltonsCubic/Results/L201Statement.lean#L149) is therefore removable in principle. Nothing is broken by its presence, and the prose sentence attributing the weights' role to it is wrong about which hypothesis is load-bearing: the load-bearing one is $\mu\ne\nu$.

**At every index, not on average.** $S\lambda=0$ is a vector identity, so row $\alpha$ gives the conclusion at $\alpha$. Route B's averaging is used only to *identify* the constant, after constancy is already in hand. The block does not blur this.

## 3. Degenerate cases

| Case | The identity | Consistency with the stated hypotheses |
|---|---|---|
| $a=0$ | Both sides are $0$, so true and empty | Excluded: $\mu$ is then not attained, and trace-freeness forces $\nu=0$ against $\nu<0$ |
| $a=N$ | LHS is the full row sum $2(n-1)$, RHS is $2(n-1)N/N$, so true | Excluded: $\nu$ is not attained, and trace-freeness forces $\mu=0$ against $\mu>0$ |
| $N=0$ | Vacuous, there is no index $\alpha$ | $N=\binom n2=0$ means $n\le1$ and $\Lambda^2\mathbb R^n=0$ |
| $n=2$ | $N=1$, the single plane has $\Pi=\mathrm{Id}_2$, and trace-freeness forces $\lambda=0$ | No two distinct eigenvalues exist |

The block's phrasing, "exactly TWO distinct eigenvalues $\mu>0>\nu$", excludes $a\in\{0,N\}$ by construction, so the degenerate rows are unreachable rather than mishandled. The Lean statement admits them and stays true in each, which is the right behaviour for a typed generalisation.

One thing the block does not say and should: **$0<a<N$ is what makes the conclusion non-empty.** At $a\in\{0,N\}$ every configuration satisfies it, so the condition carries information only strictly between.

## 4. The kernel, $\nu=0$

Suppose $\nu=0$, so $\lambda=\mu\mathbf1_A$ with $\mu\ne0$. Then $S\lambda=0$ gives $S\mathbf1_A=0$, and pairing with $\mathbf1$ gives $0=\mathbf1^{\mathsf T}S\mathbf1_A=2(n-1)a$, hence $a=0$ for every $n\ge2$, hence $W=0$. The mirror case $\mu=0$ gives $a=N$ and again $W=0$.

**So the derivation survives $\nu=0$ and what it then says is that the case does not occur.** A nonzero $W$ on this locus with a two-valued spectrum cannot have $0$ as one of the two values, and the signs $\mu>0>\nu$ are a consequence rather than a hypothesis: $\mathop{\mathrm{tr}}W=0$ with two attained values and neither zero forces opposite signs. The block states $\mu>0>\nu$ as given, which costs nothing but hides that it is free.

Note also that in this convention a $W$ with a kernel has **three or more** distinct eigenvalues, so I76 says nothing about any $W$ with a kernel. That matters for section 8.

## 5. Tightness at $S^6\times S^6$, verified independently

**The configuration is the coordinate one.** For $S^p\times S^q$ the curvature operator acts on the splitting $\Lambda^2\mathbb R^n=\Lambda^2V_1\oplus(V_1\otimes V_2)\oplus\Lambda^2V_2$ as $\mathrm{Id}$ on each $\Lambda^2V_i$ (each factor has constant curvature $1$) and as $0$ on the cross part, by given 15. A multiple of the identity on each summand is diagonal in any basis adapted to the splitting, in particular in the coordinate bivector basis $\{e_i\wedge e_j\}$, whose members are all decomposable. Subtracting $c\,\mathrm{Id}$ with $c=S/(n(n-1))$ keeps it diagonal. So the coordinate basis is an orthonormal decomposable eigenbasis.

**The weights are two-valued.** With $p=q$ and unit factors, $S=2p(p-1)$ and $n=2p$, so $c=(p-1)/(2p-1)$ and

$$\mu=1-c=\frac{p}{2p-1}\ \text{ on the }2\binom p2\text{ within-factor planes},\qquad \nu=-c=-\frac{p-1}{2p-1}\ \text{ on the }p^2\text{ cross planes}.$$

At $p=6$: $\mu=6/11$ on $30$ planes and $\nu=-5/11$ on $36$ planes. Trace check: $30\cdot\tfrac6{11}+36\cdot(-\tfrac5{11})=(180-180)/11=0$. Two values, opposite signs, exactly as section 4 predicts.

**The constant.** $n=12$, $N=\binom{12}2=66$, $a=2\binom62=30$, and $2\cdot11\cdot30/66=660/66=10$. Confirmed.

**Case $\alpha\in A$.** For coordinate planes $\mathop{\mathrm{tr}}(\Pi_{\{i,j\}}\Pi_{\{k,l\}})=\lvert\{i,j\}\cap\{k,l\}\rvert$. Take $\alpha=e_1\wedge e_2$. The diagonal gives $2$. Within-factor planes of the first factor meeting $\{1,2\}$ in one index are $\{1,x\}$ and $\{2,x\}$ for $x\in\{3,\dots,6\}$, which is $2(p-2)=8$ planes at trace $1$. Within-factor planes of the second factor are disjoint from $\{1,2\}$ and give $0$. Total $2+8+0=10$. **The block's $2(p-2)=8$ is right.**

**Case $\alpha\in B$.** Take $\alpha=e_1\wedge e_7$. It is not in $A$, so no diagonal term. Within-factor planes meeting it are $\{1,x\}$ with $x\in\{2,\dots,6\}$, which is $p-1=5$, and $\{7,y\}$ with $y\in\{8,\dots,12\}$, which is $q-1=5$. No within-factor plane contains both $1$ and $7$. Total $5+5=10$. **The block's $p-1$ and $q-1$ are right.**

**And it is tight for every balanced product, not only $p=6$.** $N=p(2p-1)$, $a=p(p-1)$, so the constant is $2(2p-1)p(p-1)/(p(2p-1))=2(p-1)$, while case $A$ gives $2+2(p-2)=2p-2$ and case $B$ gives $(p-1)+(q-1)=2p-2$. The two cases agree at $2(p-1)$ identically in $p$.

**A cross-check the block does not run, and it passes.** At $p\ne q$ the two within-factor rows give $2p-2$ and $2q-2$, which differ, so $S$ is not $A$-regular and no two-valued Ricci-flat weighting exists. That is the right answer, since $S^p\times S^q$ is Einstein only at $p=q$ (given 15). The necessary condition correctly rejects the unbalanced products.

**Ricci-flatness re-derived from $S$ alone at $p=6$**, as a check on the whole apparatus. The full row sum is $2(n-1)=22$ at every index, and the $A$-row sum is $10$, so the $B$-row sum is $12$ at every index. Then $\tfrac6{11}\cdot10+(-\tfrac5{11})\cdot12=(60-60)/11=0$. Direct count confirms the $12$: at $e_1\wedge e_2$ the cross planes meeting it are $\{i,j\}$ with $i\in\{1,2\}$ and $j\in\{7,\dots,12\}$, twelve of them at trace $1$. At $e_1\wedge e_7$ they are the five $\{1,j\}$, the five $\{i,7\}$, and itself at trace $2$, again twelve.

## 6. Is the conclusion a condition on the configuration alone?

**Partly, and the block claims more than it has.**

- **The eigenvalues do cancel.** Written out, the conclusion $\sum_{\beta\in A}S_{\alpha\beta}=2(n-1)a/N$ contains no $\mu$ and no $\nu$. That much of the block is right.
- **$a$ depends on the weights.** $A=\{\alpha:\lambda_\alpha=\mu\}$ is defined by them, and $a=\lvert A\rvert$ with it. So the honest statement quantifies existentially: the configuration must admit **some** subset $A$ with $0<\lvert A\rvert<N$ whose row sums are the matching constant. That is a condition on the pair (configuration, subset).
- **"Combinatorial" is a stretch.** $S$ has real off-diagonal entries in $[0,1]$ (given 14). $A$-regularity is a system of $N$ linear equations on a real matrix. It becomes combinatorial only once integrality is known, which is the thing being sought.
- **The condition is self-complementary.** Since the full row sums are the constant $2(n-1)$, $A$-regularity for $A$ is equivalent to $A^{\mathsf c}$-regularity for $A^{\mathsf c}$, with constant $2(n-1)(N-a)/N$. So the condition cannot tell the $\mu$-set from the $\nu$-set and carries no sign information. Section 7 uses this.

## 7. The refutation. $A$-regularity does NOT force integrality

This is the finding of the review. **The counterexample is the record's own given 4.**

Take the rotated witness at $n=4$: $g_2=\cos t\,e_2+\sin t\,e_3$, $g_3=-\sin t\,e_2+\cos t\,e_3$ with $\sin2t\ne0$, and the orthonormal basis of $\Lambda^2\mathbb R^4$

$$\omega_1=e_1\wedge g_2,\quad\omega_2=e_1\wedge g_3,\quad\omega_3=e_1\wedge e_4,\quad\omega_4=e_2\wedge e_3,\quad\omega_5=e_2\wedge e_4,\quad\omega_6=e_3\wedge e_4,$$

with the weights $\lambda=(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$ that given 4 names as spanning the Ricci-flat solution space on this family. So $\mu=\tfrac12$, $\nu=-1$, $A=\{1,2,5,6\}$, $a=4$, $N=6$, and the I76 constant is $2\cdot3\cdot4/6=4$.

**Completeness.** $g_2g_2^{\mathsf T}+g_3g_3^{\mathsf T}=e_2e_2^{\mathsf T}+e_3e_3^{\mathsf T}$, so $\sum_\alpha\Pi_\alpha$ has $e_1$ three times (from $\Pi_1,\Pi_2,\Pi_3$), $e_4$ three times (from $\Pi_3,\Pi_5,\Pi_6$), and in the $\{e_2,e_3\}$ block $c^2+s^2+1+1=3$ on each diagonal entry with the off-diagonal $cs-sc=0$. Hence $\sum_\alpha\Pi_\alpha=3\,\mathrm{Id}=(n-1)\mathrm{Id}$.

**The Gram matrix**, from $\mathop{\mathrm{tr}}((aa^{\mathsf T}+bb^{\mathsf T})(xx^{\mathsf T}+yy^{\mathsf T}))=(a\cdot x)^2+(a\cdot y)^2+(b\cdot x)^2+(b\cdot y)^2$ at orthonormal pairs, with $c=\cos t$ and $s=\sin t$:

$$S=\begin{pmatrix}2&1&1&1&c^2&s^2\\ 1&2&1&1&s^2&c^2\\ 1&1&2&0&1&1\\ 1&1&0&2&1&1\\ c^2&s^2&1&1&2&1\\ s^2&c^2&1&1&1&2\end{pmatrix}$$

**Every row sums to $6=2(n-1)$**, and **every $A$-row sums to exactly $4$**:

| $\alpha$ | $\sum_{\beta\in A}S_{\alpha\beta}$ |
|---|---|
| $1$ | $2+1+c^2+s^2=4$ |
| $2$ | $1+2+s^2+c^2=4$ |
| $3$ | $1+1+1+1=4$ |
| $4$ | $1+1+1+1=4$ |
| $5$ | $c^2+s^2+2+1=4$ |
| $6$ | $s^2+c^2+2+1=4$ |

so $S\lambda=\tfrac12\cdot4-1\cdot2=0$ at every index, confirming Ricci-flatness from $S$ alone.

**And integrality fails.** $S_{15}=\cos^2t$ and $S_{16}=\sin^2t$ lie strictly in $(0,1)$ whenever $\sin2t\ne0$, which is exactly given 4's hypothesis. **No common orthonormal frame carries these six planes**, by the easy direction rather than by L201: coordinate planes of a shared frame have integer overlap traces, and $\cos^2t\notin\{0,1\}$.

**Everything the hoped-for implication asks of $S$ is present.** It is positive semidefinite, being a Gram matrix of the $\Pi_\alpha$ in $(\mathrm{Sym}^2\mathbb R^4,\mathop{\mathrm{tr}}(AB))$. It is the Gram matrix of rank-two plane projections. Its row sums are $2(n-1)=6$. Its off-diagonal entries lie in $[0,1]$. It is $A$-regular with the constant I76 predicts. **And it is not integral.** So:

> $A$-regularity of a positive semidefinite Gram matrix of rank-two plane projections, with row sums $2(n-1)$ and off-diagonal entries in $[0,1]$, **does not force integrality.**

**The witness is a genuine critical point, and it sits in the block's own target family.** Its operator is coordinate-diagonal, with $\tfrac12$ on $e_1\wedge e_2,\,e_1\wedge e_3,\,e_2\wedge e_4,\,e_3\wedge e_4$ and $-1$ on $e_1\wedge e_4,\,e_2\wedge e_3$. Testing the diagonal criticality equation, which is given 12's relation (C) with $T_{\alpha\beta\gamma}$ the triangle indicator (from $[\varphi_{ij},\varphi_{jk}]=-\varphi_{ik}$ at the brief's unit normalisation, so $c_{\alpha\beta\gamma}^2=1$ on triangles), the equation reads $\sum_{l\ne i,j}\lambda_{il}\lambda_{jl}=\lambda_{ij}(\theta-\lambda_{ij})$ and all six indices return $\theta=-\tfrac32$: the four indices with $\lambda=\tfrac12$ give $\tfrac12(-1)+(-1)\tfrac12=-1=\tfrac12(\theta-\tfrac12)$, and the two with $\lambda=-1$ give $\tfrac12\cdot\tfrac12+\tfrac12\cdot\tfrac12=\tfrac12=-(\theta+1)$. Relation (B) also holds at every index. With $\lVert W\rVert^2=4\cdot\tfrac14+2=3$ the normalised value is $-\tfrac32/\sqrt3=-\sqrt3/2=-\theta_0(4)$.

**Identifying it:** this $W$ is $-\tfrac32\,W_{S^2\times S^2}$ for the splitting $\{e_1,e_4\}\oplus\{e_2,e_3\}$, since section 5's formula at $p=2$ gives $\mu=\tfrac23$ and $\nu=-\tfrac13$, and $-\tfrac32$ times those is $-1$ and $\tfrac12$. **The falsifier is the balanced sphere product at $p=q=2$, the lowest member of the very family the block's tightness check uses at $p=q=6$.** Flipping the sign of $\lambda$, which stays inside given 4's one-dimensional solution space, gives $+\tfrac32W_{S^2\times S^2}$ at $\theta=+\theta_0(4)$ with $A=\{3,4\}$, $a=2$ and constant $2\cdot3\cdot2/6=2$, and the $A$-row sums are $S_{\alpha3}+S_{\alpha4}=2$ at every $\alpha$. **So the falsifier can be placed at the conjectured extremal value itself.**

**Why the target conclusion survives.** The operator here *is* coordinate-diagonal. The failure is the benign one: the $\mu$-eigenspace is four-dimensional, and a decomposable orthonormal eigenbasis may be chosen inside it that no single frame carries. So integrality is a property of the *chosen* eigenbasis, and $A$-regularity, which is a property of the weights and the Gram matrix, cannot see the choice. Any proof of "two eigenvalues implies coordinate-diagonal" must quantify existentially over eigenbases inside degenerate eigenspaces, which is a strictly harder statement than the one L201 supplies.

**A consistency screen against given 10, which passes and is instructive.** For this configuration $\Xi=\sum_{\alpha\beta}S_{\alpha\beta}^2=24+20+4(c^4+s^4)=48-8c^2s^2$, strictly below $n^2(n-1)=48$ whenever $\sin2t\ne0$, and the off-diagonal total is $10+2(c^2+s^2)=12$ doubled to $24=n(n-1)(n-2)$. So the $\Xi$ bound *does* detect the non-integrality that $A$-regularity misses. Given 10 remains the sharp tool, and I76 supplies no route to $\Xi=n^2(n-1)$.

*Screen note.* Every value in this section was derived by hand in general $c,s$ and then screened in exact rational arithmetic at $c=3/5$, where $S_{15}=9/25$ and $S_{16}=16/25$, all row sums $6$, all $A$-row sums $4$, $S\lambda=0$, $\Xi=28848/625$ which is $48-8\cdot\tfrac9{25}\cdot\tfrac{16}{25}$ exactly, and $W$ coordinate-diagonal with the spectrum stated. The screen was run on objects constructed for the purpose and agrees with the closed form throughout.

## 8. Vacuity, and the claim about what it would deliver

**Two-eigenvalue critical points with a decomposable eigenbasis exist.** $S^6\times S^6$ is one, at $\theta=5$ unnormalised with $\lVert W\rVert^2=180/11$, hence $\hat\theta=5\sqrt{11/180}=\sqrt{55}/6$, and $\theta_0(12)=\sqrt{220}/12=\sqrt{55}/6$. The two agree exactly, so the balanced product at $p=q=6$ hits $\theta_0(12)$ and is critical. $S^2\times S^2$ is another, at $\theta=1$ with $\lVert W\rVert^2=4/3$, hence $\hat\theta=\sqrt3/2=\theta_0(4)$. So I76 is not vacuous.

**Every example known to me here is coordinate.** The $\mu$-set of $S^p\times S^p$, read as a graph on the $n$ vertices with the within-factor pairs as edges, is $2K_p$, which is the strongly regular graph $\mathrm{srg}(2p,p-1,p-2,0)$: at $p=6$ that is $\mathrm{srg}(12,5,4,0)$. That is precisely the correspondence of given 16, so the supply of examples is the supply of strongly regular graphs and it is entirely coordinate. What that does to the item: the $A$-regularity condition is being tested only against configurations already known to be coordinate-diagonal, so tightness confirms arithmetic and nothing about the open half.

**The conditional inference.** "If $A$-regularity forces integrality then every two-eigenvalue critical point on the locus is coordinate-diagonal" is a valid step given L201 (given 9): integrality at every pair puts the planes in a common frame, and diagonality of $W$ in that frame's bivector basis follows since the $\omega_\alpha$ are then the frame's coordinate bivectors. Two caveats.

- **Machine-checking stops short of it.** [integrality_forces_frame](../lean/HamiltonsCubic/Results/L201Statement.lean#L77) is `sorry` in Lean and its `#print axioms` carries `sorryAx`. The chain is machine-checked up to $A$-regularity only. Given 9 grants L201 as established and audited by hand, so this is a note on the Lean status rather than a doubt about the mathematics.
- **"Inside the granted half" is not checkable from this brief.** The brief never states what the granted half is. Under the natural reading, that it is the coordinate-diagonal locus where the bound is already proved, the step is immediate. I record it as unverified rather than endorse it.

**"At least THREE distinct eigenvalues" is right, and thin.** One distinct eigenvalue is impossible: $\lambda=\kappa\mathbf1$ with trace-freeness, which section 2 shows is implied, forces $\kappa N=0$ hence $W=0$. Two is the case handled. So three or more is the remainder. But eigenvalue counting here includes the kernel, so any $W$ with a kernel already has three or more distinct eigenvalues and is untouched. In particular $W_{\mathbb{CP}^2}$ (given 5) has spectrum $\{2c,-c,0\}$ and lies outside I76's reach already. The narrowing removes only kernel-free two-valued spectra.

**"It needs no new machinery" is refuted, for a reason deeper than the counterexample.** See section 9.

## 9. I76 is an equivalence, so it narrows nothing

The converse of the I76 derivation holds, and this is the sharpest thing to say about the item.

Let a configuration be complete, so $S\mathbf1=2(n-1)\mathbf1$, and suppose $S$ is $A$-regular with the constant $c_A=2(n-1)a/N$ for some $A$ with $0<a<N$. Put $\mu=N-a$ and $\nu=-a$, so $\mu>0>\nu$ and $a\mu+(N-a)\nu=0$. Then, using $S\mathbf1_{A^{\mathsf c}}=(2(n-1)-c_A)\mathbf1$,

$$S\lambda=\mu c_A\mathbf1+\nu\bigl(2(n-1)-c_A\bigr)\mathbf1=2(n-1)a\Bigl[\frac{N-a}{N}-1+\frac aN\Bigr]\mathbf1=0.$$

So $\lambda$ is a two-valued Ricci-flat weighting with level set $A$, unique up to scale. Combined with the I76 direction:

> For a complete configuration and a subset $A$ with $0<\lvert A\rvert<N$, the Gram matrix is $A$-regular with constant $2(n-1)\lvert A\rvert/N$ **if and only if** the configuration carries a two-valued Ricci-flat weighting whose level set is $A$.

**$A$-regularity is therefore a restatement of the hypothesis, in different variables.** It is not a consequence that constrains the configuration further, which is why:

- the tightness check at $S^6\times S^6$ was guaranteed to pass, that configuration being two-valued Ricci-flat by construction, so it verified arithmetic rather than a prediction;
- no argument from $A$-regularity alone can force integrality, since a counterexample is any non-coordinate configuration carrying a two-valued Ricci-flat weighting, and given 4 hands one over;
- "it needs no new machinery, only the Gram matrix and the classification of the regular cases" is exactly wrong about where the difficulty sits. The unused hypothesis is **criticality**, and any narrowing of the open half must consume it. The Gram matrix and the weights alone are Ricci-flatness restated.

The block's own framing points at this without drawing it: "the eigenvalues having cancelled" is what a change of variables does.

## 10. What would break it, and what I did to look

**The regularity conclusion itself cannot be broken.** It is two lines of linear algebra over $\mathbb R$ from $S\lambda=0$ and $S\mathbf1=2(n-1)\mathbf1$, machine-checked gap-free. An object falsifying it would be a two-valued Ricci-flat $W$ on the locus with non-constant $A$-row sums, which section 1 forbids outright.

**The falsifiable target is the hoped-for implication**, and the object is: a set of $\binom n2$ pairwise $\Lambda^2$-orthogonal decomposable unit bivectors spanning $\Lambda^2\mathbb R^n$, whose plane-projection Gram matrix is $A$-regular for some $A$ with $0<\lvert A\rvert<\binom n2$ and constant $2(n-1)\lvert A\rvert/\binom n2$, with at least one off-diagonal entry in $(0,1)$. **I found it in the givens.** Given 4's rotated witness is exactly such an object at $n=4$, and section 7 exhibits it in closed form, in the one-parameter family $\sin2t\ne0$, at the critical value $\pm\theta_0(4)$.

How I looked: I read section 9's equivalence off the derivation, which turned the hunt from a search into a lookup, since the object needed is any non-coordinate configuration carrying a two-valued Ricci-flat weighting. Given 4 states the weighting, states that the six planes lie in no common frame, and gives the family. The remaining work was computing $S$ by hand and checking the six row sums, which section 7 does. **No search, sweep or census was run.** The one machine step was an exact rational screen of hand results at $\cos t=3/5$, reported as a screen in section 7.

**A second falsifier that is not one.** $S^p\times S^q$ at $p\ne q$ fails $A$-regularity, as section 5 shows, but it also fails Ricci-flatness, so it refutes nothing and instead confirms the derivation.

## Verdict

**The derivation HOLDS. The programme claim built on it is REFUTED.**

- **Sections 1 to 5 hold.** The subtraction, the constant, the at-every-index quantification, the degenerate cases and the tightness arithmetic at $S^6\times S^6$ are all correct, and the tightness generalises to every balanced product with constant $2(p-1)$.
- **Section 7 refutes the item's stated question.** $A$-regularity does not force integrality, and the counterexample is the record's own given 4 at $n=4$, in closed form, with off-diagonal entries $\cos^2t$ and $\sin^2t$. It is a genuine critical point, equal to $\mp\tfrac32W_{S^2\times S^2}$, and it can be placed at $\theta_0(4)$ exactly.
- **Section 9 is the finding that matters most.** $A$-regularity with the stated constant is *equivalent* to carrying a two-valued Ricci-flat weighting, so I76 is a change of variables. It narrows nothing, the tightness check could not have failed, and the sentence "it needs no new machinery" is backwards: the machinery it needs is whatever consumes **criticality**, which the derivation never touches.
- **Corrections owed to the block, in order of size.** First, delete the claim that the open question is whether $A$-regularity forces integrality, and record the refutation. Second, record the equivalence, so the step is filed as a reformulation. Third, drop "combinatorial" and "on the configuration alone" for "a linear condition on the configuration and a subset". Fourth, note that criticality and decomposability are unused, so the result covers every two-valued Ricci-flat $W$ on the locus. Fifth, note that trace-freeness is redundant and implied, and that $\mu>0>\nu$ is a consequence.
- **The Lean file is sound and its statements are wider than the prose.** `two_eigenvalue_A_regular` and `sum_trace_row` depend on `propext`, `Classical.choice` and `Quot.sound` only. `integrality_forces_frame` carries `sorryAx`, so the machine-checked chain stops at $A$-regularity. The prose's list of Lean hypotheses omits $N\ne0$, and `htf` is removable. Neither affects correctness.
