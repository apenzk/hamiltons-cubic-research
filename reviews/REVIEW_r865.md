# Review r865: I77, the triangle-type linear programme

**Cold brief.** I read the brief and one other file, [L202TriangleLP.lean](../lean/HamiltonsCubic/Results/L202TriangleLP.lean). I did not read the findings files, the plan, the other reviews or the attempts notebook. **No numerical work beyond screening was done, and every value in this report is exact.** What I ran: exact rational arithmetic on closed forms I had already derived by hand, one symbolic simplification that confirms four of those hand derivations, and the Lean build and axiom check that attack-list item 14 instructs. Every decimal is a reading of an exact rational or an exact surd stated beside it. Log: [agent_logs/review-r865-trianglelp.log](../agent_logs/review-r865-trianglelp.log).

## Claim table

| # | Claim, as the record states it | Verdict |
|---|---|---|
| 1 | $\theta=\operatorname{tr}(W^3)+\tfrac12T(\lambda,\lambda,\lambda)$, with the factor $\tfrac12$ | **CORRECT** |
| 2 | $\sum_j t_j=2N(n-2)$ | **CORRECT** |
| 3 | $\sum_j j\,t_j=6(n-2)a$ | **CORRECT** |
| 4 | The coefficients are positive at $j=1,3$ and negative at $j=0,2$ | **CORRECT** |
| 5 | "The coefficients alternate in sign, **so** the optimum puts all mass on $j\in\{1,3\}$" | **NON SEQUITUR AS ARGUED, TRUE ONLY FOR $s\ge N/3$** |
| 6 | "feasible exactly when $N/3\le s\le N$" | **TRUE OF THE VERTEX, AND READ AS THOUGH IT WERE A CONSTRAINT ON $s$** |
| 7 | The closed form $[(N-2s)+(n-2)(N-s)(4s-N)/(2s)]/\sqrt{sN(N-s)}$ | **CORRECT** |
| 8 | $\operatorname{tr}(W^3)=(N-2s)/\sqrt{sN(N-s)}$ | **CORRECT** |
| 9 | Balanced product: $t_3=240$, $t_1=1080$, $t_0=t_2=0$, and these are the vertex | **CORRECT** |
| 10 | $330/\sqrt{71280}=\theta_0(12)$ and $6/\sqrt{48}=\theta_0(4)$ | **CORRECT AND EXACT** |
| 11 | "it returns $\theta_0(n)$ exactly at the balanced product" | **CORRECT, AND I EXTEND IT TO EVERY $n=2p$** |
| 12 | "at $n=4$ the programme CLOSES the two-eigenvalue decomposable case exactly" | **GAP: $s=1$ is uncovered, and is excluded only by a lemma the block does not state** |
| 13 | $s=31$ at $n=12$ gives $1.2385$ | **CORRECT** |
| 14 | "the programme alone leaves a $0.2\%$ gap at $n=12$" | **NOT ESTABLISHED: on the uncovered range $6\le s\le21$ the same programme gives up to $3.8536$** |
| 15 | "no configuration is known to carry" $s=31$ | **STRENGTHENED TO A PROOF for coordinate configurations, and its vertex violates relation (B)** |
| 16 | The programme is an upper bound, relaxation direction right | **CORRECT** |
| 17 | "For the two-eigenvalue case L105 is still better" | **CORRECT, AND NO CONTRADICTION BETWEEN THEM** |
| 18 | Three marginal equalities and six cap inequalities, with $a_i(a_i-1)$ | **CORRECT** |
| 19 | "the positive coefficients are $\mu_1^3$ and $\mu_1\mu_2\mu_3$" | **WRONG: four of the ten types carry positive coefficients** |
| 20 | "At two eigenvalues the vertex was forced without" the caps | **CORRECT ABOUT THE FORCING, FALSE THAT THE CAPS ARE SLACK: the vertex violates one of them for $s>N-n+1$** |
| 21 | "The closed form and both checks are machine-checked and gap-free" | **CORRECT: builds clean on three standard axioms, statements faithful to the prose** |
| 22 | **My repair.** Adding relation (B), which the programme discards and which costs nothing, gives $\theta\le(n-1)\sqrt{s/(N(N-s))}$ for $s\le n(n-2)/4$, whose maximum over $s$ is $\theta_0(n)$ exactly | **DERIVED IN CLOSED FORM, TIGHT AT THREE EXHIBITED CONFIGURATIONS** |

**Overall verdict: GAP, REPAIRABLE, AND REPAIRED IN SECTION 16.**

## One-line summary

Every algebraic step the block writes down is correct and the two exact checks are exact, but the bound is a bound only on $s\ge N/3$ while the admissible range is $s\ge n/2$, and on the uncovered part the same programme returns $3.8536$ at $n=12$, so the headline $1.2385$ is not a bound on $\theta$. Adding relation (B), already established and free of any hypothesis the programme lacks, closes both the domain hole and the $0.2\%$ gap and returns $\theta_0(n)$ exactly.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector. The inner product is $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$. At orthonormal $u,v$ this is a unit bivector and $(u\wedge v)(u\wedge v)^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_P$, the orthogonal projection onto $P=\mathrm{span}\{u,v\}$.
- $\omega$ is decomposable when $\omega=u\wedge v$, equivalently $\omega\wedge\omega=0$. The record's wedge is TWICE the Pfaffian.
- $\mathcal W_n$ is the space of algebraic Weyl tensors: symmetric operators on $\Lambda^2\mathbb R^n$, first Bianchi, Ricci-flat, trace-free. $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.
- $\sqrt{3/2}=1.224745$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

Throughout, $N=\binom n2$, $A$ is the positive level set, $s=\lvert A\rvert$, $B$ is its complement and $p=N-s=\lvert B\rvert$. The operator inner product on symmetric operators of $\Lambda^2$ carries no factor $\tfrac12$, which given 13 fixes by $\lVert W\rVert^2=\sum_\alpha\lambda_\alpha^2$.

## Hypothesis inventory

What the bound actually consumes, itemised, with the given that supplies each:

| Input | Source | Where it is used |
|---|---|---|
| $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ at every index | given 15, L153 | both linear constraints |
| $T_{\alpha\beta\gamma}\ge0$ | $T=c^2$ | the LP's nonnegativity |
| $T$ totally symmetric and hollow | givens 12, 14 | the second constraint, and the $t_{ijk}$ symmetry |
| $(W^\#)_{kk}=\tfrac12\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}$ | given 14 | the objective and the factor $\tfrac12$ |
| $\lVert W\rVert^2=\sum\lambda_\alpha^2$, trace-freeness | givens 13, 18 | the spectrum pinning $\mu:\nu=(N-a):(-a)$ and the scale $k$ |
| exactly two eigenvalues | hypothesis | everything |

What the bound does **not** consume, and this is the point of section 10: decomposability, criticality, first Bianchi, Ricci-flatness, the pair cap, and relation (B). The block says as much for the first and the fifth. Its own conclusion depends on the omission of the last, and on Ricci-flatness having been discarded along with the rest.

---

## 1. The objective, and the factor $\tfrac12$

At unit norm $\theta=P(W)=\langle W,W^2\rangle+\langle W,W^\#\rangle$. Given 13 fixes the operator inner product as the plain trace form, so $\langle W,W^2\rangle=\operatorname{tr}(W^3)=\sum_\alpha\lambda_\alpha^3$ in an eigenbasis, and $\langle W,W^\#\rangle=\sum_k\lambda_k(W^\#)_{kk}$ because $W$ is diagonal there. Given 14's diagonal formula then gives

$$\langle W,W^\#\rangle=\sum_k\lambda_k\cdot\tfrac12\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=\tfrac12 T(\lambda,\lambda,\lambda).$$

So $\theta=\sum_\alpha\lambda_\alpha^3+\tfrac12T(\lambda,\lambda,\lambda)$, exactly as the record has it. **CORRECT.**

Two independent pins of the $\tfrac12$, since item 1 asks for one that does not lean on the block.

**First pin, from relation (C).** Contract given 12's relation (C) with $\lambda_k$: $\sum_k\lambda_k\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=\sum_k2\lambda_k^2(\theta-\lambda_k)$, that is $T(\lambda,\lambda,\lambda)=2\theta\lVert W\rVert^2-2\operatorname{tr}(W^3)$, which at unit norm reads $\operatorname{tr}(W^3)+\tfrac12T(\lambda,\lambda,\lambda)=\theta$. Any constant other than $\tfrac12$ contradicts (C). This pin holds at critical points, which is where (C) lives.

**Second pin, from the value at the balanced product, and it is the sharper of the two.** Section 7 shows the vertex value at $n=2p$, $s=2\binom p2$ equals $\theta_0(2p)$ **identically in $p$**. Replace $\tfrac12$ by $c$ and the vertex value at $n=12$, $s=30$ becomes $(6+648c)/\sqrt{71280}$, which equals $\theta_0(12)=330/\sqrt{71280}$ only at $c=\tfrac12$. That one datum already pins it, and the identity in $p$ pins it at every even $n$ at once.

**What a wrong $\tfrac12$ would do.** At $c=1$ the $n=12$ value is $654/\sqrt{71280}=2.4494$, twice $\theta_0(12)$ and four fifths of the record's standing $3.0509$: the whole claim of near-sharpness would evaporate. The bound is therefore extremely sensitive to this constant, and it is the constant that two independent routes confirm.

## 2. The first constraint

$\sum_jt_j$ is the sum of $T_{\alpha\beta\gamma}$ over all ordered triples, since the four classes $j=0,1,2,3$ partition them. Summing given 15's marginal over the $N$ values of $\alpha$,

$$\sum_jt_j=\sum_\alpha\sum_{\beta\gamma}T_{\alpha\beta\gamma}=\sum_\alpha 2(n-2)=2N(n-2)=M.$$

**CORRECT.** No hypothesis beyond an orthonormal basis of $\mathfrak{so}(n)$, as the block says.

## 3. The second constraint, the one to be most sceptical about

$\sum_jj\,t_j=\sum_{\text{ordered triples}}\#\{\text{positions lying in }A\}\cdot T_{\alpha\beta\gamma}=\sum_{q=1}^3\sum_{\text{triples}}\mathbb 1[\text{position }q\in A]\,T_{\alpha\beta\gamma}$, and each of the three inner sums equals $\sum_{\alpha\in A}\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)a$ because $T$ is totally symmetric. Hence $\sum_jj\,t_j=6(n-2)a$. **CORRECT**, and the counting argument the block gives is the right one: the factor $3$ is the three positions, not the $3!$ orderings.

The check item 3 asks for, on real counts, done three times over. For a coordinate configuration $T_{\alpha\beta\gamma}=1$ exactly on the ordered triples of edges of a triangle of $K_n$ and $0$ elsewhere, so $t_j=6m_j$ with $m_j$ the number of triangles carrying exactly $j$ edges of $A$.

| Configuration | $n$, $s$ | $(m_0,m_1,m_2,m_3)$ | $\sum t_j$ vs $M$ | $\sum jt_j$ vs $J$ |
|---|---|---|---|---|
| $S^6\times S^6$, $A=K_6\sqcup K_6$ | 12, 30 | $(0,180,0,40)$ | $1320=1320$ | $1800=1800$ |
| $(S^2)^6$, $A$ a perfect matching | 12, 6 | $(160,60,0,0)$ | $1320=1320$ | $360=360$ |
| $A$ a 12-cycle | 12, 12 | $(112,96,12,0)$ | $1320=1320$ | $720=720$ |
| $S^2\times S^2$, $A$ a perfect matching | 4, 2 | $(0,4,0,0)$ | $24=24$ | $24=24$ |

All four rows satisfy both constraints on the nose. The three-way split for the 12-cycle: a triangle of $K_{12}$ meets a 12-cycle in two edges exactly when they are consecutive ($12$ such triangles), in one edge in $12\cdot(10-2)=96$ cases, in three never, leaving $220-108=112$.

## 4. The vertex

**The sign pattern is right.** With $\mu=k p$ and $\nu=-ks$, a triple of type $j$ contributes $\mu^j\nu^{3-j}=k^3(N-s)^j(-s)^{3-j}$, so the coefficients are $c_0=-s^3$, $c_1=ps^2$, $c_2=-p^2s$, $c_3=p^3$: negative at $j=0,2$ and positive at $j=1,3$ whenever $0<s<N$. **CORRECT.**

**The inference from it is a non sequitur.** "The coefficients alternate in sign, so the optimum puts all mass on $j\in\{1,3\}$" is not valid reasoning: the two equality constraints can force mass onto a negative coefficient, and in general they do. The correct criterion is the **upper concave envelope**. Writing $t_j=M\pi_j$ the programme is: maximise $M\,\mathbb E_\pi[c_j]$ over distributions $\pi$ on $\{0,1,2,3\}$ with $\mathbb E_\pi[j]=J/M=3s/N$. The maximum is $M$ times the upper concave envelope of the four points $(j,c_j)$ evaluated at $3s/N$, and its support is the envelope edge containing that abscissa.

Two facts settle the envelope, both from one factorisation. The chord from $(1,c_1)$ to $(3,c_3)$ has height $(ps^2+p^3)/2>0>c_2$ at $j=2$, so $j=2$ is always strictly below it. Its extension to $j=0$ has height $(3ps^2-p^3)/2$, and

$$c_0-\frac{3ps^2-p^3}{2}=\frac{p^3-3ps^2-2s^3}{2}=\frac{(p+s)^2(p-2s)}{2}=\frac{N^2(p-2s)}{2},$$

so $j=0$ lies strictly below the line $\{1,3\}$ exactly when $p<2s$, that is $s>N/3$, is on it at $s=N/3$, and lies strictly above it when $s<N/3$. Therefore:

- for $s>N/3$ the envelope is the single edge $\{1,3\}$, the abscissa $3s/N$ lies in $(1,3)$, and the optimum is $t_1=(3M-J)/2=3(n-2)(N-s)$, $t_3=(J-M)/2=(n-2)(3s-N)$, **exactly the block's vertex**;
- for $s<N/3$ the same factorisation puts $j=1$ strictly below the chord from $(0,c_0)$ to $(3,c_3)$, the envelope is the edge $\{0,3\}$, and the optimum is $t_3=J/3=2(n-2)s$, $t_0=M-J/3=2(n-2)(N-s)$, with value derived in section 13.

**Could a different vertex beat it?** No, on $s\ge N/3$: the envelope argument is a complete answer, and the four remaining supports $\{0,1\}$, $\{0,2\}$, $\{0,3\}$, $\{1,2\}$, $\{2,3\}$ are all dominated by it there. **Is the feasibility range right?** $t_3\ge0$ gives $s\ge N/3$ and $t_1\ge0$ gives $s\le N$, so yes for the vertex. The trouble is what the block does with that sentence, which is section 13.

## 5. The closed form

With $t_1=3(n-2)p$ and $t_3=(n-2)(2s-p)$,

$$t_1c_1+t_3c_3=(n-2)\left[3p\cdot ps^2+(2s-p)p^3\right]=(n-2)p^2\left[3s^2+2sp-p^2\right]=(n-2)p^2(3s-p)(s+p)=(n-2)p^2N(4s-N),$$

using $3s-p=4s-N$ and $s+p=N$. Dividing by $2sN p$ leaves $(n-2)(N-s)(4s-N)/(2s)$, and the remaining $(sNp)^{-1/2}$ from $k^3=(sNp)^{-3/2}$ is the stated denominator. **CORRECT**, and this is precisely the identity the Lean file types.

$\operatorname{tr}(W^3)$: the pinning $\mu=kp$, $\nu=-ks$ satisfies $s\mu+p\nu=0$, and $\lVert W\rVert^2=k^2(sp^2+ps^2)=k^2spN=1$ gives $k=(sNp)^{-1/2}$, matching given 18 and the block. Then

$$\operatorname{tr}(W^3)=k^3(sp^3-ps^3)=k^3sp(p^2-s^2)=k^3spN(N-2s)=\frac{N-2s}{\sqrt{sN(N-s)}}.$$

**CORRECT.**

## 6. The balanced product's counts

At $n=12$ the within-factor planes are the edges of $K_6\sqcup K_6$, so $s=2\binom62=30$ and $p=36$, and the sectional curvatures of given 16 give $\lambda=6/11$ on $A$ and $-5/11$ on $B$, whose ratio $36:(-30)=(N-s):(-s)$ is the pinning. The triangle census of $K_{12}$ split by the bipartition $V_1\sqcup V_2$:

- three vertices in one part: all three edges within-factor, $j=3$, count $2\binom63=40$, so $t_3=240$;
- two vertices in one part and one in the other: one within-factor edge and two cross edges, $j=1$, count $2\binom62\cdot6=180$, so $t_1=1080$;
- $j=2$ is **impossible**: two within-factor edges sharing a vertex have all three of their endpoints in one part, so the third edge is within-factor too, giving $j=3$;
- $j=0$ is **impossible**: three cross edges forming a triangle would properly 2-colour $K_3$ by the bipartition, and $K_3$ is not bipartite.

Both vanishings **CORRECT**. And these are the vertex: $(J-M)/2=(1800-1320)/2=240=t_3$ and $(3M-J)/2=(3960-1800)/2=1080=t_1$. **CORRECT.**

## 7. The two exact checks, and a general identity that subsumes them

$n=12$, $s=30$: $N-2s=6$ and $(n-2)(N-s)(4s-N)/(2s)=10\cdot36\cdot54/60=324$, so the numerator is $330$, and $\frac{330^2}{71280}=\frac{108900}{71280}=\frac{55}{36}$, so the bound is $\sqrt{55}/6=\theta_0(12)$. **EXACT.**

$n=4$, $s=2$: $N-2s=2$ and $2\cdot4\cdot2/4=4$, numerator $6$, and $\frac{36}{48}=\frac34$, so the bound is $\sqrt3/2=\theta_0(4)$. **EXACT.**

These are not two coincidences. Put $n=2p$, so $N=p(2p-1)$, $s=2\binom p2=p(p-1)$ and $N-s=p^2$. Then $N-2s=p$ and

$$\frac{(n-2)(N-s)(4s-N)}{2s}=\frac{2(p-1)\,p^2\,p(2p-3)}{2p(p-1)}=p^2(2p-3),$$

so the numerator is $p+p^2(2p-3)=p(2p-1)(p-1)$ while $\sqrt{sN(N-s)}=p^2\sqrt{(p-1)(2p-1)}$, giving

$$\theta\le\frac{\sqrt{(p-1)(2p-1)}}{p}=\frac{\sqrt{4(p-1)(2p-1)}}{2p}=\frac{\sqrt{2(n-1)(n-2)}}{n}=\theta_0(n).$$

**The programme returns $\theta_0(n)$ at the balanced product for every even $n$, identically.** The vertex counts also match in general: $t_3=(n-2)(3s-N)=2p(p-1)(p-2)=6\cdot2\binom p3$ and $t_1=3(n-2)(N-s)=6p^2(p-1)=6\cdot2\binom p2p$, exactly the block's two triangle types. This is the single strongest piece of evidence that the objective, the constraints and the vertex are all right, and it is stronger than the record claims for itself.

## 8. The $n=4$ closure

At $n=4$, $N=6$, the closed form over the vertex's range $2\le s\le6$:

| $s$ | numerator | $\theta^2$ bound | $\theta$ bound |
|---|---|---|---|
| 2 | $6$ | $3/4$ | $\sqrt3/2=0.866025$ |
| 3 | $6$ | $2/3$ | $2/\sqrt6=0.816497$ |
| 4 | $3$ | $3/16$ | $0.433013$ |
| 5 | $-6/5$ | | negative |
| 6 | | | excluded, see section 13 |

So the maximum over the vertex's range is at $s=2$ and equals $\theta_0(4)$, matching the block's $2/\sqrt6$ and $0.433$. **The enumeration is right as far as it goes and the two quoted values are right.**

**But $s=1$ is not in the table, and the block's "the maximum over $s$ there IS at $s=2$" is asserted over a range it has not justified.** At $s=1$ the vertex is infeasible and the LP optimum sits on $\{0,3\}$, giving (section 13) $(n-1)(N-2s)/\sqrt{sNp}=3\cdot4/\sqrt{30}=12/\sqrt{30}=2.190890$, two and a half times $\theta_0(4)$. So the programme does not close $n=4$ on its own.

**The repair is one line, and it needs decomposability plus Ricci-flatness, both of which the programme had discarded.** At two eigenvalues, given 2 gives $\mu\Theta(A)+\nu\Theta(B)=0$ and given 1 gives $\Theta(A)+\Theta(B)=(n-1)\mathrm{Id}$, so $(\mu-\nu)\Theta(A)=-(n-1)\nu\,\mathrm{Id}$ and, with $\mu-\nu=kN$ and $-\nu=ks$,

$$\boxed{\ \Theta(A)=\frac{s(n-1)}{N}\mathrm{Id}=\frac{2s}{n}\mathrm{Id}_n\ }$$

whose trace $2s=2\dim A$ agrees with given 1. On the decomposable locus $\Theta(A)=\sum_{i\in A}\Pi_i$ is a sum of $s$ rank-two projections, so $\operatorname{rank}\Theta(A)\le2s$, while $\frac{2s}{n}\mathrm{Id}_n$ has rank $n$. Hence

$$\frac n2\le s\le N-\frac n2,$$

the upper bound by the same argument applied to $B$, whose $\Theta$ is $(n-1-\frac{2s}n)\mathrm{Id}$ with a positive coefficient for $s<N$. At $n=4$ that is $2\le s\le4$, so $s=1$ is excluded and **the $n=4$ closure holds, with this lemma supplied.** At $n=12$ it is $6\le s\le60$, which is where the trouble in section 13 lives.

## 9. The $s=31$ excess

$s=31$, $n=12$: $N-2s=4$ and $10\cdot35\cdot58/62=10150/31$, so the numerator is $\frac{10274}{31}=331.4194$ exactly and $\theta\le\frac{10274}{31\sqrt{71610}}$, whose square is exactly $\frac{10274^2}{31^2\cdot71610}=\frac{105555076}{68817210}=1.533847\ldots$, so $\theta\le1.238486$. Against $\theta_0(12)=1.236033$ the ratio is $1.001984$, so **"two parts in a thousand" is CORRECT** and I confirm $s=31$ is the maximiser over $22\le s\le65$ ($s=30$ gives $1.236033$, $s=32$ gives $1.236612$, $s=29$ gives $1.228655$).

**Is $s=31$ realisable? Not by any coordinate configuration, and I can prove it.** Section 8's identity $\Theta(A)=\frac{2s}{n}\mathrm{Id}$ specialises: for a coordinate configuration the planes are the $e_i\wedge e_j$ of one frame, $\Pi_{ij}=E_{ii}+E_{jj}$, and $\Theta(A)=\mathrm{diag}(\deg_A v)$ over the graph $A\subseteq E(K_n)$. So

**a coordinate configuration carrying a two-valued Ricci-flat weighting has $A$ regular of degree $2s/n$, hence $n\mid 2s$.**

At $n=12$ that forces $6\mid s$, and $2\cdot31/12=31/6$ is not an integer, so $s=31$ is impossible. This is the integrality condition, and by given 9 (L201) the coordinate configurations are exactly those whose pairwise traces are integral, so any $s=31$ configuration must carry some $\operatorname{tr}(\Pi_\alpha\Pi_\beta)\in(0,1)$. Non-coordinate configurations are not excluded by this alone, and they are not vacuous: $\Theta(\Lambda^+)=\tfrac32\mathrm{Id}_4$ at $n=4$ shows $2s/n$ need not be an integer in general, so the obstruction is genuinely restricted to the coordinate case rather than universal.

**A second and sharper obstruction: the $s=31$ vertex violates relation (B).** Given 12's relation (B) reads $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$ at every index and is the diagonal of $W\#I=-W$, so it holds at every Weyl tensor with no criticality. Sum it over $k\in A$. Total symmetry of $T$ gives $t_{AAB}=t_{ABA}=t_{BAA}=t_2/3$ and $t_{ABB}=t_1/3$, so the left side is $\mu(t_3+t_2/3)+\nu(t_2/3+t_1/3)$ and, after clearing $k$ and multiplying by $3$,

$$\textbf{(B$_A$)}\qquad 3p\,t_3+(p-s)\,t_2-s\,t_1=-6ps.$$

At $s=30$ the block's vertex satisfies it: $3\cdot36\cdot240-30\cdot1080=-6480=-6\cdot36\cdot30$. At $s=31$ it does not: $3\cdot35\cdot270-31\cdot1050=9450-10850=-1400$ against a required $-6\cdot35\cdot31=-6510$. **So the vertex that produces $1.2385$ is not the count vector of any Weyl tensor at all.** Section 16 turns this into the repair.

## 10. Is it an upper bound at all?

**Yes, and the relaxation direction is right.** The true count vector of any two-eigenvalue $W$ is feasible for the programme, since given 15's marginal holds at every orthonormal basis of $\mathfrak{so}(n)$ and $T=c^2\ge0$, and $\theta$ is exactly the linear functional being maximised, by section 1, once $s$ is fixed and the spectrum pinned. Maximising over a superset of the feasible set therefore returns a number no smaller than $\theta$. **CORRECT.**

No step needs a discarded constraint. The spectrum pinning uses trace-freeness and unit norm, which are properties of $W$ rather than constraints on $t$, and both are legitimately available. Two remarks that go slightly beyond the item.

**The bound needs neither criticality nor decomposability.** Section 1's objective identity uses only $P(W)=\langle W,W^2+W^\#\rangle$, given 14 and unit norm, so the bound holds at every unit-norm two-valued trace-free $W$, not only at critical points, and the marginal holds for any orthonormal basis. The block says this. It is worth saying twice because it is what makes the comparison with L105 in section 11 an apples-to-apples one.

**The programme throws away one constraint that costs nothing.** Relation (B) is established (given 12), holds with no criticality and no decomposability, and is linear in $t$. Discarding it is what leaves the $0.2\%$ gap, and section 16 shows that keeping it removes the gap entirely.

## 11. Against L105

**L105 is better for two eigenvalues, as the block says.** L105 gives $\theta\le\theta_0(n)$ outright with no decomposability, whereas the programme's uniform statement over $s$ is $\max_s(\text{bound})$, which at $n=12$ is $1.238486>1.236033$ even on the range the closed form covers. **CORRECT.**

**No contradiction.** Both are upper bounds, so one being smaller at a given $s$ is not a conflict: at $s=24$, $n=12$ the programme gives $1.087503$, a sharper statement about that $s$ than L105 makes, and both are consistent with the truth. A contradiction would need the programme's bound to fall **below** an attained value. It does not, and I checked tightness at three exhibited configurations rather than merely failing to find a violation:

| Configuration | $n$, $s$ | true $\theta$, exact | programme's bound at that $s$ |
|---|---|---|---|
| $S^2\times S^2$ | 4, 2 | $\sqrt3/2$ | $\sqrt3/2$, attained |
| $S^6\times S^6$ | 12, 30 | $\sqrt{55}/6$ | $\sqrt{55}/6$, attained |
| $(S^2)^6$ | 12, 6 | $\sqrt{11/60}=0.428174$ | $3.853570$, valid and loose |

The first two are equalities, so the relaxation is lossless at the balanced values and the bound cannot be lowered there by any means. The third value is computed in section 15.

## 12. The three-eigenvalue setup

**The three marginal equalities are right.** $\sum_{j,k}t_{ijk}=\sum_{\alpha\in A_i}\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)a_i$, and their sum over $i$ is $2(n-2)N=M$, as the block says. **CORRECT.**

**The six cap inequalities are right, hollowness included.** $\sum_kt_{ijk}=\sum_{\alpha\in A_i,\beta\in A_j}S_{\alpha\beta}$ with $S_{\alpha\beta}=\lVert[\omega_\alpha,\omega_\beta]\rVert^2$, which given 8 makes $\operatorname{tr}(\Pi_\alpha\Pi_\beta)\le1$ on the decomposable locus. For $i\ne j$ there are $a_ia_j$ ordered pairs, giving $\le a_ia_j$. For $i=j$ the $a_i$ diagonal pairs contribute $S_{\alpha\alpha}=0$, leaving $a_i(a_i-1)$. **CORRECT**, and "exactly half the strength of the general cap" is right, $1$ against $2$. Ten types is right: multisets of size three from three labels, $\binom52=10$. The $t_{ijk}$ are symmetric in $(i,j,k)$ because $T$ is and the level sets partition the index set.

**The sign claim is WRONG.** With $\mu_1>0>\mu_2\ge\mu_3$ the block says "the positive coefficients are $\mu_1^3$ and $\mu_1\mu_2\mu_3$". Four of the ten monomials are positive, not two: $\mu_1^3$, $\mu_1\mu_2\mu_3$, **$\mu_1\mu_2^2$ and $\mu_1\mu_3^2$**. The block's own two-eigenvalue answer refutes it, because the type carrying $t_1=3(n-2)(N-s)$, four fifths of the total mass at $n=12$, is exactly a $\mu_1\mu_2^2$ type: one index in $A$ and two in $B$. So "the optimum loads the all-positive type and the mixed type" misdescribes where the mass wants to sit, and the two extra positive types are precisely the ones the two-eigenvalue instance says will dominate. **This needs correcting before the vertex enumeration is attempted, or the enumeration will start from the wrong guess.**

**"At two eigenvalues the vertex was forced without them" is right about the forcing and wrong that the caps are slack.** In the two-set specialisation the caps read $t_3+t_2/3\le s(s-1)$, $(t_2+t_1)/3\le sp$ and $t_1/3+t_0\le p(p-1)$. At the block's vertex ($t_0=t_2=0$) these are $(n-2)(3s-N)\le s(s-1)$, $(n-2)p\le sp$ and $(n-2)p\le p(p-1)$, that is $s\ge n-2$ and $s\le N-n+1$. So the third cap **is violated by the vertex for $s>N-n+1$**, which at $n=12$ means $s\ge56$. The maximiser at $s=31$ is well inside the range where the caps are slack, so the headline is unaffected, but the sentence as written is not true across the vertex's stated feasibility range $N/3\le s\le N$.

## 13. Degenerate cases, and the gap

**$a=0$ and $a=N$.** Both are excluded before the programme starts: a single eigenvalue plus trace-freeness forces $W=0$, contradicting unit norm. The formula reflects this, dividing by $2s$ and by $\sqrt{s N(N-s)}$.

**A zero eigenvalue.** Impossible at two eigenvalues, and for a reason the pinning exhibits rather than merely records: $\mu=k(N-s)>0$ and $\nu=-ks<0$ for $0<s<N$, so neither value can vanish. This agrees with given 18 and is why $W_{\mathbb{CP}^2}$, whose spectrum is $\{2c,-c,-c,0,0,0\}$ at $\theta=\sqrt{3/2}=1.224745$, is outside the hypothesis: it has three eigenvalues, and the two-eigenvalue bound $\sqrt3/2=0.866$ at $s=2$ does not apply to it. Had the zero been admitted as a second value, $\mathbb{CP}^2$ would refute the bound on the spot. **The hypothesis is exactly as tight as it needs to be, and given 18 is load-bearing.**

**$s$ outside the feasibility range: this is the gap, and it is not a technicality.** The block's "feasible exactly when $N/3\le s\le N$" is a statement about the vertex. It is then used as though $s<N/3$ were excluded for configurations, which nothing establishes. Section 8 shows the admissible window is $n/2\le s\le N-n/2$, so at $n=12$ the range $6\le s\le21$ is admissible and uncovered. On it the programme still runs, on the envelope edge $\{0,3\}$ of section 4, and its value has a clean closed form:

$$t_3=2(n-2)s,\quad t_0=2(n-2)(N-s),\qquad \tfrac12k^3(t_0c_0+t_3c_3)=k^3(n-2)sp\,N(N-2s)=\frac{(n-2)(N-2s)}{\sqrt{sNp}},$$

so, adding $\operatorname{tr}(W^3)$,

$$\theta\ \le\ \frac{(n-1)(N-2s)}{\sqrt{sN(N-s)}}\qquad (s\le N/3),$$

which agrees with the block's formula at $s=N/3$, both giving $(n-1)/\sqrt{2N}$. At $n=12$ this is decreasing in $s$ and its values on the admissible part of the range are

| $s$ | 6 | 10 | 12 | 15 | 18 | 20 | 21 |
|---|---|---|---|---|---|---|---|
| bound | $3.853570$ | $2.631992$ | $2.233997$ | $1.762351$ | $1.381927$ | $1.160647$ | $1.057100$ |

**The maximum of the programme's bound over the whole admissible range at $n=12$ is therefore $3.853570$ at $s=6$, not $1.238486$.** That is worse than the record's standing $3.0509$. So the sentence "the programme alone leaves a $0.2\%$ gap at $n=12$, against the record's standing factor of $2.47$" is **NOT ESTABLISHED**: as a statement about $\theta$ at two-eigenvalue points of $\mathcal W_{12}$ the programme gives nothing better than what the record already had.

Adding the pair cap does not rescue it. On $s\le N/3$ the cap $t_3+t_2/3\le s(s-1)$ binds, and since the coefficient of $t_3$ in the reduced objective is $N^2(p-2s)>0$ there, the optimum takes $t_3=\min(2(n-2)s,\,s(s-1))$ with the rest on $\{0,1\}$. At $n=12$, $s=12$ that point is $t=(864,324,0,132)$, which satisfies both equalities and all three caps and has value exactly

$$\theta\le\frac{297}{\sqrt{42768}}=\sqrt{\frac{33}{16}}=\frac{\sqrt{33}}4=1.436141,$$

still above $\theta_0(12)$. So **the cap narrows the hole from $3.85$ to about $1.44$ and does not close it.** What closes it is section 16.

## 14. The Lean file

`lake build HamiltonsCubic.Results.L202TriangleLP` completes successfully (3006 jobs) on Lean 4.33.1 with Mathlib v4.33.1, and all four results depend on `propext`, `Classical.choice`, `Quot.sound` and nothing else: no `sorry` and no gap axiom. **The "machine-checked and gap-free" claim is CORRECT for what is typed.**

Each statement says what the prose says:

- `lp_vertex_closed_form` types $\big(s^2(N-s)\cdot3(n-2)(N-s)+(N-s)^3(n-2)(3s-N)\big)/2\big/(sN(N-s))=(n-2)(N-s)(4s-N)/(2s)$. The two bracketed factors are $c_1t_1$ and $c_3t_3$ of section 5 with the right signs, since $c_1=(N-s)(-s)^2$, and the division by $sN(N-s)$ rather than $(sN(N-s))^{3/2}$ is the correct bookkeeping: one factor of $\sqrt{sN(N-s)}$ stays outside as the shared denominator of the whole numerator. **Faithful.**
- `lp_bound_sq_n4` and `lp_bound_sq_n12` type $\mathrm{num}^2/(sN(N-s))=2(n-1)(n-2)/n^2$ at $(4,6,2)$ and $(12,66,30)$, which are $36/48=3/4$ and $108900/71280=220/144$. **Faithful, and the squared form does avoid the surd honestly rather than hiding a sign: both numerators are positive.**
- `lp_gap_n12` types the strict inequality between the squares at $s=30$ and $s=31$, equivalent to the inequality between the bounds because both numerators are positive. **Faithful.**

**What the file does NOT type**, and this matters more than usual here because the untyped part is where the gap is:

1. **The linear programme itself.** There are no $t_j$, no marginal, no nonnegativity, no equality constraints. The file checks the vertex value's algebra, it does not derive the vertex.
2. **The vertex forcing.** Nothing types the sign pattern, and nothing types the envelope argument that is the actual proof (section 4). The one place the prose reasons invalidly is entirely outside Lean.
3. **The feasibility range and its scope.** `lpNumerator` takes $n$, $N$, $s$ as three unrelated reals with no $N=\binom n2$ and no $N/3\le s\le N$. Nothing in the file records that the closed form is the LP optimum only on part of the admissible range, so the file is silent exactly where section 13's gap lives.
4. **The objective.** $P(W)=\operatorname{tr}(W^3)+\tfrac12T(\lambda,\lambda,\lambda)$, the factor $\tfrac12$, the pinning of $\mu:\nu$, $k$, and $\operatorname{tr}(W^3)=(N-2s)/\sqrt{sNp}$ are all prose.
5. **Any Weyl tensor.** No $\mathcal W_n$, no $\Lambda^2$, no decomposability, no criticality. The theorems are four facts about real numbers.
6. **The balanced product's counts**, including the two vanishing claims of section 6.

The INDEX row I saw while locating the file states items 1, 2 and part of 3 honestly, so the record is not overstating what Lean covers. My complaint is not with the file. It is that "machine-checked and gap-free" sits in the same sentence as a bound whose scope restriction is the one thing neither the prose nor the file records.

## 15. What would break it, and what I did to look for it

**The object to look for is a two-eigenvalue Ricci-flat decomposable configuration outside the closed form's domain.** I did not sweep for one. I constructed two in closed form, from section 9's integrality condition read forwards instead of backwards: a coordinate configuration works exactly when $A$ is a $\frac{2s}n$-regular graph on $n$ vertices, so at $n=12$ every $6\mid s$ is realisable and, by given 2 with $\Theta(A)=\frac{2s}{n}\mathrm{Id}$, carries a genuine two-valued Ricci-flat trace-free $W$. First Bianchi is automatic, since given 6 makes $\mathrm{Alt}(W)=\tfrac16\sum_\alpha\mu_\alpha\,\omega_\alpha\wedge\omega_\alpha$ and every $\omega_\alpha$ is decomposable, so every $\omega_\alpha\wedge\omega_\alpha$ vanishes. Both objects are therefore in $\mathcal W_{12}$, both are in the class the bound quantifies over, and both lie in the range section 13 leaves uncovered.

**$A$ a perfect matching, $s=6$, the Weyl tensor of $(S^2)^6$.** Degree $1=2\cdot6/12$. Triangle census: no triangle carries two matching edges, since two matching edges are disjoint, so $m_3=m_2=0$, $m_1=6\cdot10=60$ and $m_0=160$. With $\mu'=60$, $\nu'=-6$ and $k=23760^{-1/2}$,

$$\tfrac12T(\lambda,\lambda,\lambda)=3k^3\left[60\cdot60\cdot36+160\cdot(-216)\right]=3k^3\cdot95040=\frac{12}{\sqrt{23760}},\qquad \theta=\frac{54+12}{\sqrt{23760}}=\frac{66}{\sqrt{23760}}=\sqrt{\frac{11}{60}}=0.428174.$$

**$A$ a 12-cycle, $s=12$.** Degree $2=2\cdot12/12$. Census $(m_0,m_1,m_2,m_3)=(112,96,12,0)$ from section 3. With $\mu'=54$, $\nu'=-12$ and $k=42768^{-1/2}$, $\tfrac12T=3k^3\cdot133056=\frac{28/3}{\sqrt{42768}}$ and $\theta=\frac{42+28/3}{\sqrt{42768}}=\frac{154}{3\sqrt{42768}}=0.248224$.

Neither breaks the conjecture: both are far below $\theta_0(12)$. **Both break the claim in the record.** They are admissible two-eigenvalue decomposable Ricci-flat configurations at $n=12$ with $s=6$ and $s=12$, for which the quoted closed form is not a bound on anything, and for which the programme's actual output is $3.853570$ and $2.233997$. They also make section 13's gap concrete rather than hypothetical: the uncovered range is populated by objects one can write down.

A third check in the same spirit, and it went the other way. Both configurations satisfy the relation-(B) row of section 9 exactly, as they must: the matching gives $-6\cdot360=-2160=-6\cdot60\cdot6$, and the cycle gives $(54-12)\cdot72-12\cdot576=-3888=-6\cdot54\cdot12$. That is what suggested section 16.

## 16. The repair, and it is free

Keep relation (B). It is established (given 12), it is linear in $t$, it needs no criticality and no decomposability, and section 9 showed the $s=31$ vertex violates it while the balanced vertex satisfies it. Add (B$_A$) of section 9 to the programme. Its companion row over $k\in B$ carries no new information, since the two sum to $\sum_\beta\lambda_\beta\cdot2(n-2)=0$ by trace-freeness on both sides.

Three equalities in four nonnegative variables leave a segment, so the optimum sits where one variable vanishes. On the branch $t_2=0$ the equalities determine everything:

$$t_3=\frac{2s(2s-n)}{n},\qquad t_1=\frac{12sp}{n},\qquad t_0=\frac{8(N-s)\left(\tfrac{n(n-2)}4-s\right)}{n},$$

so **$t_3\ge0$ forces $s\ge n/2$ and $t_0\ge0$ forces $s\le n(n-2)/4$**, the first reproducing section 8's rank bound with no decomposability used at all. And the objective collapses. Writing $\Phi=\sum_jc_jt_j$,

$$\frac{\Phi}{2sNp}=(n+1)s-N,\qquad\text{so}\qquad (N-2s)+\frac{\Phi}{2sNp}=(n-1)s,$$

which is to say

$$\boxed{\ \theta\ \le\ (n-1)\sqrt{\frac{s}{N(N-s)}}\qquad\text{for }\ \frac n2\le s\le\frac{n(n-2)}4.\ }$$

This is increasing in $s$, so its maximum is at the right endpoint, and $N-\frac{n(n-2)}4=\frac{n^2}4$ gives

$$\theta\ \le\ (n-1)\sqrt{\frac{n(n-2)/4}{\frac{n(n-1)}2\cdot\frac{n^2}4}}=\frac{\sqrt{2(n-1)(n-2)}}{n}=\theta_0(n).$$

The endpoint $s=n(n-2)/4$ is an integer exactly when $n$ is even, where it equals $2\binom{n/2}2$: **the balanced product $S^{n/2}\times S^{n/2}$ is not merely a case the programme gets right, it is the unique maximiser of the (B)-strengthened programme, and it sits exactly where $t_0$ hits zero.** At odd $n$ the endpoint is not integral and the maximum over integer $s$ is strictly below $\theta_0(n)$: $s=\lfloor n(n-2)/4\rfloor$ gives $0.828079$ at $n=5$ against $\theta_0(5)=0.979796$, and $1.186434$ at $n=11$ against $\theta_0(11)=1.219673$.

On the other branch, $t_0=0$, the three equalities have a unique solution, $t_3=2N(n-2)-\frac{12sp}n$ and $t_2=6p\left(\frac{4s}n-(n-2)\right)$, so $t_2\ge0$ forces $s\ge n(n-2)/4$ and the two branches meet exactly at the endpoint. There the numerator is $\frac{(n-1)\left(n^4-3n^3+2n^2-4n^2s+4ns+4s^2\right)}{4s}$, and at $n=12$ its exact values decrease monotonically from $330$ at $s=30$: the bound is $1.099256$ at $s=31$, $0.974922$ at $s=32$, and negative from $s=47$ on. **So at $n=12$ the strengthened programme gives $\theta\le\theta_0(12)$ over the whole admissible range, with equality only at $s=30$, and the $0.2\%$ gap is gone.**

Three tightness checks, all exact, all at the strengthened bound:

| Configuration | $s$ | strengthened bound | true $\theta$ |
|---|---|---|---|
| $S^2\times S^2$, $n=4$ | 2 | $\sqrt3/2$ | $\sqrt3/2$ |
| $(S^2)^6$, $n=12$ | 6 | $11/\sqrt{660}=\sqrt{11/60}$ | $\sqrt{11/60}$ |
| $S^6\times S^6$, $n=12$ | 30 | $330/\sqrt{71280}=\sqrt{55}/6$ | $\sqrt{55}/6$ |

The middle row is the one that persuades me, because it is at an $s$ the record's closed form does not reach and the bound is attained there to the last digit by an object I built for the purpose.

Two caveats on the repair, stated as such. The general-$n$ monotonicity of the upper branch I verified only as an exact evaluation at $n=12$ over its feasible integers, not as a proof for all $n$: the sign of the quartic factor on the feasible sub-range is what remains. And the result is not new mathematics, since given 17's L105 already gives $\theta\le\theta_0(n)$ at two eigenvalues. **What it is, is the evidence that the method is sound enough to reproduce L105 by an independent route, and the plain instruction for the three-eigenvalue programme where L105 does not reach: carry relation (B), which gives one equality per level set, alongside the marginal.** The block's plan for I77, "ten nonnegative variables, three equalities, six cap inequalities", is missing three equalities that are already established and that at two eigenvalues do all the work.

## Verdict

**GAP, REPAIRABLE, AND REPAIRED ABOVE.** Every algebraic step the block writes is correct: the objective and its $\tfrac12$, both constraints, the sign pattern, the vertex's value, the closed form, both exact checks, the balanced product's counts and both vanishing claims, and the Lean file's four theorems, which build clean on three standard axioms and say what the prose says. The general identity of section 7 makes the balanced-product check an identity in $p$ rather than two coincidences, which is stronger than the record claims. Three defects:

1. **The bound's domain is $s\ge N/3$, and the block treats that as though it constrained configurations.** The admissible range is $n/2\le s\le N-n/2$, and on the uncovered part at $n=12$ the same programme returns up to $3.853570$, worse than the record's standing $3.0509$. So "the programme alone leaves a $0.2\%$ gap at $n=12$" is not established, and the $n=4$ closure needs the rank lemma of section 8, which the block does not state. **The headline must be restated with its domain, or the domain must be closed.**
2. **The vertex forcing is argued invalidly**, from the sign pattern rather than from the upper concave envelope. The conclusion is right for $s\ge N/3$ and the correct argument is three lines, but as written it is the same reasoning that would give the wrong support for $s<N/3$, which is how the domain was lost.
3. **The three-eigenvalue sign claim is wrong**: four of the ten types carry positive coefficients, not two, and the two the block omits include the type that dominates its own two-eigenvalue answer.

Against those, the maximiser at $s=31$ is spurious on two independent counts, integrality and relation (B), and adding relation (B) closes the whole thing in closed form at $\theta_0(n)$.
