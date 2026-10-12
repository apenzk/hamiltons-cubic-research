# REVIEW r871 on I77: the dual bound is valid and exact at the balanced product, and its reduction of the conjecture is refuted

**Cold brief.** I read the brief and one Lean file, [L203DualBound.lean](../lean/HamiltonsCubic/Results/L203DualBound.lean), and nothing else of the record. **No numerical work beyond screening was done**: every derivation below is by hand, every value is exact and closed-form, and the one machine step was an exact-arithmetic screen (sympy over rationals and surds) of values I had already derived, plus the Lean build the brief instructs. **Every value in this report is exact.** Log: [agent_logs/review-r871-dual.log](../agent_logs/review-r871-dual.log).

## Claim table

| # | Claim as recorded | Verdict |
|---|---|---|
| 1 | Multiplying the constraint by `T ≥ 0` and summing gives $m_3\le 2(n-2)Ny$, the $z$ term vanishing by trace-freeness | **SOUND** |
| 2 | Imposing the constraint only at triples of distinct indices suffices | **SOUND** (hollowness carries it) |
| 3 | $\theta\le\sum\lambda_\alpha^3+(n-2)N\min_z\max[\cdot]$, factor $(n-2)N$ | **SOUND** |
| 4 | The bound is an upper bound on $\theta$ for every spectrum | **SOUND, AND UNFALSIFIABLE BY CONSTRUCTION** (proof in §4, and ten spectra screened with no violation) |
| 5 | $n=4$ witness: $z=1/4$, $y=1/(12\sqrt3)$, bound $=\sqrt3/2=\theta_0(4)$ | **CONFIRMED EXACT**, and $y$ cannot be lowered |
| 5b | "all three of the all-within, mixed and all-cross functions are simultaneously active" at $n=4$ | **FALSE AS STATED**: the all-within triple does not exist at $n=4$ ($\lambda_+$ has multiplicity $2$), and the mixed function that is active is $(\lambda_+,\lambda_-,\lambda_-)$, not $(\lambda_+,\lambda_+,\lambda_-)$ |
| 6 | $n=12$: $z=0.004544$, $y=0.001839$, bound $=1.2362$ "to the precision of the hand arithmetic" | **CONFIRMED AND STRENGTHENED**: $z=1/220$, $y=\tfrac34 55^{-3/2}$, bound $=\sqrt{55}/6=\theta_0(12)$ **exactly**, not approximately |
| 7 | Exactness "checked at two dimensions" | **CONFIRMED AND GENERALISED**: bound $=\theta_0(2p)$ identically in $p$, closed form in §7, with the true $\theta$ of $S^p\times S^p$ derived independently and equal to it |
| 8 | Tightness at the balanced product | **STRUCTURAL, NOT A COINCIDENCE**: the product's own $T$ is primal-optimal and complementary slackness holds exactly (§8) |
| 8b | "LP duality turns it into a one-dimensional minimax" | **OVERCLAIM**: the one-parameter family is a sub-family of the LP dual. At the padded $W_{\mathbb{CP}^2}$ spectrum at $n=12$ it returns $221/\sqrt6=90.2229$ where the LP optimum is $11/\sqrt6=4.4907$ |
| 9 | Bound returns $5/\sqrt6=2.0412$ at $W_{\mathbb{CP}^2}$'s spectrum, consistent | **CONFIRMED** |
| 10 | The bound applies to all Ricci-flat unit-norm Weyl tensors, critical or not | **CONFIRMED** |
| 10b | "the remaining question is one finite-dimensional maximisation: is the dual bound at most $\theta_0(n)$ once $n\ge12$", crossing over near $n=6+2\sqrt7$ | **REFUTED** (§10). The maximum over spectra exceeds $\theta_0(n)$ at **every** $n\ge4$ and diverges cubically. At $n=12$: $221/\sqrt6=90.2229$ at the padded $W_{\mathbb{CP}^2}$ spectrum, $3\sqrt{165}/10=3.8536$ at the non-padded $(S^2)^6$ spectrum, against the target $1.2360$ |
| 10c | Such a maximisation "would settle the conjecture outright, uniqueness included" | **MOOT**, and no repair inside the marginal relaxation exists: even the exact LP optimum is $11/\sqrt6=4.4907$ at $n=12$ (§10.3) |
| 11 | The Lean witness "is machine-checked in exact arithmetic and carries no gap axiom" | **CONFIRMED for what it states**, which is much less than the prose (§11): seven theorems build, axioms `propext, Classical.choice, Quot.sound` only |

**One-line summary.** The derivation is correct and its exactness at $S^p\times S^p$ is not only confirmed but holds identically in $p$ with the true $\theta$ equal to the bound. The reduction it claims is false, because the bound charges $y$ against the whole $T$-mass $2(n-2)N$ and therefore grows like $n^3$ on any fixed spectrum, so the maximum over spectra at $n=12$ is at least $3.8536$ and at least $90.2229$ once padded spectra are admitted, against a target of $1.2360$.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector. The inner product is $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$. At orthonormal $u,v$ this is a unit bivector and $(u\wedge v)(u\wedge v)^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_P$.
- $\mathcal W_n$ is the space of algebraic Weyl tensors: symmetric operators on $\Lambda^2\mathbb R^n$, first Bianchi, Ricci-flat, trace-free. $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.
- $\sqrt{3/2}=1.224745$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

## Hypothesis inventory

What the claim actually consumes, in the order the derivation needs it:

| Input | Where from | Used for |
|---|---|---|
| $\theta=\sum_\alpha\lambda_\alpha^3+\tfrac12\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}$ at unit norm | given 14 | the objective |
| $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2\ge0$ | given 14 | the direction of the inequality after multiplying |
| $T$ totally symmetric | given 14 | collapsing $\lambda_\alpha+\lambda_\beta+\lambda_\gamma$ to $3\lambda_\alpha$ |
| $T$ hollow | given 14 | restricting the constraint to distinct triples |
| $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ at every $\alpha$ | given 15, L153 | both the $y$ total $2(n-2)N$ and the per-index $z$ term |
| $\sum_\alpha\lambda_\alpha=0$ | given 16 | killing the $z$ term |
| $\sum_\alpha\lambda_\alpha^2=1$ | given 16 | normalisation of $\theta$ |

Not used, and correctly advertised as not used: decomposability, caps, criticality, relation (B), relation (C), L201, the Johnson Gram matrix, the scalar bound $\Xi$. **Consequence, which matters in §10**: the hypotheses are blind to how many indices actually carry a nonzero eigenvalue. The only place $n$ enters is through $2(n-2)$ and $N=\binom n2$, both of which count the whole index set including the kernel.

## 1. The dual pairing

Write $m_3=\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}$, the sum over all ordered triples. Suppose $\lambda_\alpha\lambda_\beta\lambda_\gamma\le y+\tfrac z3(\lambda_\alpha+\lambda_\beta+\lambda_\gamma)$ at every triple of pairwise distinct indices. Multiply by $T_{\alpha\beta\gamma}\ge0$, which preserves the direction, and sum over ordered triples:

$$m_3\ \le\ y\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\ +\ \frac z3\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}(\lambda_\alpha+\lambda_\beta+\lambda_\gamma).$$

First term. By given 15 the first-slot marginal is $2(n-2)$ at every index, so $\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}=\sum_\alpha 2(n-2)=2(n-2)N$. This is the total over ordered triples, matching the sum on the left, so the $y$ coefficient is $2(n-2)N$ as claimed.

Second term. Total symmetry of $T$ makes the three slot-sums equal, so $\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}(\lambda_\alpha+\lambda_\beta+\lambda_\gamma)=3\sum_\alpha\lambda_\alpha\sum_{\beta\gamma}T_{\alpha\beta\gamma}=3\cdot2(n-2)\sum_\alpha\lambda_\alpha=0$ by trace-freeness, and the factor $\tfrac13$ in the constraint is exactly what cancels the $3$.

**Answer to the question asked.** Total symmetry plus given 15 plus trace-freeness is exactly enough, and nothing more is needed. Two remarks on what could have gone wrong and does not. Symmetry in the first slot alone would not do: what is needed is that the marginal is the same functional of $T$ in all three slots, which total symmetry supplies and given 15 then evaluates. And the cancellation is a cancellation of a *sum*, not of each term, so it is unavailable if the constraint's linear part is any function of the triple other than a multiple of $\lambda_\alpha+\lambda_\beta+\lambda_\gamma$. The choice $\tfrac z3(\lambda_\alpha+\lambda_\beta+\lambda_\gamma)$ is precisely the part of the dual that trace-freeness makes free. **SOUND.**

## 2. The index set

$T_{\alpha\beta\gamma}=\langle[\omega_\alpha,\omega_\beta],\omega_\gamma\rangle^2$ is hollow: it vanishes whenever two indices coincide, by given 14. Hence in $m_3$ every term with a repeated index is zero, and the sum is supported on triples of pairwise distinct indices, exactly where the constraint is imposed. Imposing it at triples with repeats would be harmless but useless.

**Exactly which triples have $T_{\alpha\beta\gamma}\ne0$.** In general only the containment holds: $\operatorname{supp}T\subseteq\{\text{pairwise distinct triples}\}$, and which of those are non-null depends on the basis. For the coordinate configuration, which is the case every witness in this claim uses, it is exact and I compute it here because §4 and §7 need it. With $\omega_{ij}=e_i\wedge e_j=E_{ji}-E_{ij}$ and $E_{ab}E_{cd}=\delta_{bc}E_{ad}$,

$$[\omega_{ij},\omega_{jk}]=E_{ik}-E_{ki}=-\omega_{ik}\qquad(i,j,k\text{ distinct}),$$

so $c_{\{ij\}\{jk\}\{ik\}}=-1$ and $T=1$ there. Two coordinate forms sharing no index commute, so $T=0$, and $-\omega_{ik}$ is orthogonal to every coordinate form other than $\omega_{ik}$. **The support is exactly the triangles** $\{\{i,j\},\{j,k\},\{i,k\}\}$, one per $3$-subset of coordinate indices, and there are $\binom n3$ of them. The marginal check is immediate: at $\alpha=\{i,j\}$ there are $n-2$ triangles through $\alpha$, each contributing two ordered pairs $(\beta,\gamma)$, giving $2(n-2)$ and confirming given 15 in this case.

A notational caveat. The record writes the max over "$\alpha\ne\beta\ne\gamma$". Read literally that chain permits $\alpha=\gamma$. The intended and correct reading is pairwise distinct. Including the repeats would only raise $y$, hence weaken a still-valid bound, so nothing depends on it, but the minimax as printed is ambiguous and should say pairwise distinct. **SOUND.**

## 3. The objective and the factor

Given 14 at unit norm is $\theta=\sum_\alpha\lambda_\alpha^3+\tfrac12 m_3$, so §1 gives

$$\theta\ \le\ \sum_\alpha\lambda_\alpha^3+\tfrac12\cdot2(n-2)Ny\ =\ \sum_\alpha\lambda_\alpha^3+(n-2)Ny .$$

The factor is $(n-2)N$ and not $2(n-2)N$ precisely because of the $\tfrac12$ in given 14. Both the $\tfrac12$ and the value $T=1$ on triangles are cross-validated independently in §4.1 against given 3, which is a different route to $P(W)$ entirely. Passing from a fixed feasible pair to the displayed minimax is legitimate because the bound holds for every feasible $(y,z)$: for fixed $z$ the least feasible $y$ is $y(z)=\max_{\text{distinct}}[\lambda_\alpha\lambda_\beta\lambda_\gamma-\tfrac z3(\lambda_\alpha+\lambda_\beta+\lambda_\gamma)]$, and then any $z$ may be chosen, so the infimum over $z$ is a bound.

**Finiteness of the minimax, which the record does not address.** $y(\cdot)$ is a max of finitely many affine functions, hence convex and piecewise linear, and if it were unbounded below the "bound" would read $\theta\le-\infty$. It is not: summing $\lambda_\alpha+\lambda_\beta+\lambda_\gamma$ over all triples gives $\binom{N-1}{2}\sum_\alpha\lambda_\alpha=0$, so the triple sums average to zero. Therefore some triple has $\Sigma\le0$, whose affine function is non-increasing in $-z$ and bounds $y(z)$ below by its product as $z\to+\infty$, and some triple has $\Sigma\ge0$, doing the same as $z\to-\infty$. So $\min_z$ is finite and attained. **SOUND.**

## 4. THE KILLER TEST: can the bound fall below the true $\theta$?

**It cannot, and this is a theorem rather than the outcome of a search.** Fix any $W$ with the givens' hypotheses and let $T$ be its own coefficient tensor. Consider the linear programme, at the fixed spectrum,

$$\text{maximise }\ \tfrac12\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma S_{\alpha\beta\gamma}\quad\text{over }S\ge0,\ S\text{ totally symmetric and hollow},\ \sum_{\beta\gamma}S_{\alpha\beta\gamma}=2(n-2)\ \forall\alpha .$$

$W$'s own $T$ is feasible for it, by givens 14 and 15, so the LP value is at least $\theta-\sum_\alpha\lambda_\alpha^3$. Sections 1 to 3 show every feasible $(y,z)$ produces an upper bound for the same LP. Hence

$$\text{bound}(\lambda)\ \ge\ \sum_\alpha\lambda_\alpha^3+\text{LP}(\lambda)\ \ge\ \theta(W)$$

for every $W$ with that spectrum. A spectrum with bound $<\theta$ would therefore contradict one of the givens, not the derivation. That is the honest verdict on this item: the test cannot fail unless L153 or given 14 is wrong, and the useful thing to do instead is to check the arithmetic of the record's own evaluations, which is what I did, and to measure the size of the gap, which is what kills the reduction in §10.

### 4.1 The machinery I use to compute true $\theta$, and its independent validation

For any coordinate-diagonal $W$, write $\lambda_{ij}$ for the eigenvalue on $e_i\wedge e_j$. Then Ricci-flatness is $\sum_{j\ne i}\lambda_{ij}=0$ for every $i$ (given 1 and 2, since $\Theta(e_i\wedge e_j)=\Pi_{ij}$), first Bianchi is automatic (given 6, each $\omega_\alpha\wedge\omega_\alpha=0$), trace-freeness follows by summing the row sums, and by §2 given 14 becomes

$$\theta=\sum_{i<j}\lambda_{ij}^3+3\sum_{i<j<k}\lambda_{ij}\lambda_{jk}\lambda_{ik}\qquad\text{at unit norm }\sum_{i<j}\lambda_{ij}^2=1 .$$

For a Riemannian product of round spheres I need the spectrum. With $\mathcal R$ the curvature operator, which acts as $\kappa_i\,\mathrm{Id}$ on $\Lambda^2V_i$ and as $0$ on every cross block $V_i\otimes V_j$, and with $D_h(e_i\wedge e_j)=\tfrac{h_i+h_j}2e_i\wedge e_j$ the operator form of the Kulkarni–Nomizu part, $\mathcal W=\mathcal R-D_h$ with $h$ fixed by $\operatorname{Ric}(D_h)_i=\tfrac{(n-2)h_i+\operatorname{tr}h}2=\rho_i$, that is

$$\operatorname{tr}h=\frac{\sigma}{n-1},\qquad h_i=\frac1{n-2}\Big(2\rho_i-\frac{\sigma}{n-1}\Big).$$

Three validations, all exact, before I use it. (i) Constant curvature: $\rho_i=(n-1)\kappa$, $\sigma=n(n-1)\kappa$, $h_i=\kappa$, so $\mathcal W=0$. (ii) $S^p\times S^p$: $h=\tfrac{(p-1)\kappa}{2p-1}\mathrm{Id}$, giving $\lambda_+=\tfrac{p\kappa}{2p-1}$ with multiplicity $p(p-1)$ and $\lambda_-=-\tfrac{(p-1)\kappa}{2p-1}$ with multiplicity $p^2$, hence the ratio $\lambda_-/\lambda_+=-(p-1)/p$ and, after normalising, exactly the record's $\lambda_\pm$ of item 7. (iii) The formula for $\theta$ against given 3 at $n=4$. For $S^2\times S^2$ both chirality blocks are $\operatorname{diag}(a,b,b)$ with $a=1/\sqrt3$, $b=-a/2$, both trace-free as given 3 requires, and given 3 yields $\langle W,W^\#\rangle=\sum_\pm 2\operatorname{tr}\mathcal A^3=4\cdot\tfrac34a^3=3a^3$, while the triangle formula yields $3\sum_{\text{triangles}}=3\cdot4\cdot ab^2=3a^3$. They agree, and adding $\operatorname{tr}W^3=\tfrac32a^3$ gives $\theta=\tfrac92a^3=\sqrt3/2$. The same route on $W_{\mathbb{CP}^2}$, one block $c\operatorname{diag}(2,-1,-1)$ with $c=1/\sqrt6$, gives $\theta=6c^3+12c^3=18c^3=3/\sqrt6=\sqrt{3/2}$, reproducing given 5. **So both the $\tfrac12$ in given 14 and $T=1$ on triangles are confirmed against an independent identity.**

### 4.2 The spectra checked, exactly

Every entry is a closed form derived by hand and then screened in exact arithmetic. $\theta_0(4)=\sqrt3/2$, $\theta_0(6)=\sqrt{10}/3$, $\theta_0(12)=\sqrt{55}/6$.

| Spectrum | $n$ | $z_\ast$ | $y_\ast$ | $\sum\lambda^3$ | bound | true $\theta$ |
|---|---|---|---|---|---|---|
| $S^2\times S^2$ | 4 | $1/4$ (interval $[-\tfrac12,\tfrac14]$) | $\sqrt3/36$ | $\sqrt3/6$ | $\sqrt3/2=0.8660254$ | $\sqrt3/2=0.8660254$ |
| $S^3\times S^3$ | 6 | $1/20$ | $\sqrt{10}/200$ | $\sqrt{10}/30$ | $\sqrt{10}/3=1.0540926$ | $\sqrt{10}/3=1.0540926$ |
| $S^6\times S^6$ | 12 | $1/220$ | $3\sqrt{55}/12100$ | $\sqrt{55}/330$ | $\sqrt{55}/6=1.2360331$ | $\sqrt{55}/6=1.2360331$ |
| $W_{\mathbb{CP}^2}$, padded | 4 | $0$ | $\sqrt6/18$ | $\sqrt6/6$ | $5\sqrt6/6=2.0412415$ | $\sqrt6/2=1.2247449$ |
| $W_{\mathbb{CP}^2}$, padded | 12 | $0$ | $\sqrt6/18$ | $\sqrt6/6$ | $221\sqrt6/6=90.222872$ | $\sqrt6/2=1.2247449$ |
| $S^2\times S^2\times S^2$ | 6 | $13/60$ | $\sqrt{15}/150$ | $\sqrt{15}/10$ | $\sqrt{15}/2=1.9364917$ | $\sqrt{15}/6=0.6454972$ |
| $S^2\times S^2\times S^2$, padded | 12 | $13/60$ | $\sqrt{15}/150$ | $\sqrt{15}/10$ | $9\sqrt{15}/2=17.428425$ | $\sqrt{15}/6=0.6454972$ |
| $(S^2)^6$ | 12 | $91/660$ | $\sqrt{165}/2420$ | $3\sqrt{165}/110$ | $3\sqrt{165}/10=3.8535698$ | $\sqrt{165}/30=0.4281744$ |
| coordinate $n=4$, $\lambda_{12}=\lambda_{34}=0$ | 4 | $-1/4$ | $1/12$ | $0$ | $1$ | $0$ |
| negated $S^2\times S^2$ | 4 | $-1/8$ | $5\sqrt3/144$ | $-\sqrt3/6$ | $\sqrt3/4=0.4330127$ | $-\sqrt3/2$ |

**No violation anywhere**, as §4 proves must be the case. The three spectra the brief names are all present: the balanced product at two dimensions and in fact at three, the padded $W_{\mathbb{CP}^2}$, and products of more than two spheres, both $S^2\times S^2\times S^2$ at $n=6$ and $(S^2)^6$ at $n=12$. The last two rows are the two extreme directions of the $n=4$ coordinate sector, included because they are the cases where a sign error in the $z$ term would show: the $\lambda_{12}=0$ row has $\sum\lambda^3=0$ and $\theta=0$ with the bound carried entirely by $y$, and the negated row has $\theta<0$ with the bound positive.

For the record, the $n=4$ coordinate sector is two-dimensional, $\lambda_{12}=\lambda_{34}=x$, $\lambda_{13}=\lambda_{24}=y'$, $\lambda_{14}=\lambda_{23}=w$ with $x+y'+w=0$, and there $\theta=2(x^3+y'^3+w^3)+12xy'w=18xy'w$ using $x^3+y'^3+w^3=3xy'w$. Maximising $18xy'w$ on $x^2+y'^2+w^2=\tfrac12$ gives $\sqrt3/2$ at $x=y'=-t$, $w=2t$, $t=1/(2\sqrt3)$, which is $S^2\times S^2$. So the coordinate sector at $n=4$ maxes exactly at $\theta_0(4)$, where the bound is exact.

## 5. The $n=4$ witness

Spectrum $a=1/\sqrt3$ twice, $b=-1/(2\sqrt3)$ four times. Trace $2a+4b=\tfrac2{\sqrt3}-\tfrac2{\sqrt3}=0$. Norm $2\cdot\tfrac13+4\cdot\tfrac1{12}=\tfrac23+\tfrac13=1$. Note $b=-a/2$, so $a+2b=0$, which is the whole story of this witness.

The distinct-index triples available from the multiset are $(a,a,b)$, $(a,b,b)$, $(b,b,b)$, and **not** $(a,a,a)$, because $a$ has multiplicity two. With $f=\Pi-\tfrac z3\Sigma$:

| triple | $\Pi$ | $\Sigma$ | $f(z)$ | $f(1/4)$ |
|---|---|---|---|---|
| $(a,a,b)$ | $-a^3/2$ | $3a/2$ | $-\tfrac{a^3}2-\tfrac{za}2$ | $-\tfrac{a^3}2-\tfrac a8<0$ |
| $(a,b,b)$ | $a^3/4$ | $0$ | $\tfrac{a^3}4$, constant in $z$ | $\tfrac{a^3}4$ |
| $(b,b,b)$ | $-a^3/8$ | $-3a/2$ | $-\tfrac{a^3}8+\tfrac{za}2$ | $\tfrac{a^3}4$ |
| $(a,a,a)$, absent | $a^3$ | $3a$ | $a^3-za$ | $\tfrac{a^3}4$ |

At $z=1/4$ the all-cross function equals $-\tfrac{a^3}8+\tfrac a8=\tfrac{a^3}4$, using $a^2=\tfrac13$, so the constraint holds at every available triple with $y=\tfrac{a^3}4=\tfrac1{12\sqrt3}$, which is the record's $y$ and its stated $0.04811$. Then $\sum\lambda^3=2a^3+4b^3=\tfrac32a^3=\tfrac1{2\sqrt3}$, $(n-2)N=2\cdot6=12$, and

$$\text{bound}=\frac1{2\sqrt3}+12\cdot\frac1{12\sqrt3}=\frac1{2\sqrt3}+\frac1{\sqrt3}=\frac3{2\sqrt3}=\frac{\sqrt3}2=\theta_0(4).$$

**Can $y$ be lowered?** No, and the reason is not the one the record and the Lean file give. The mixed triple $(a,b,b)$ has $\Sigma=a+2b=0$, so its function is the constant $ab^2=\tfrac{a^3}4$ and $y(z)\ge\tfrac{a^3}4$ for **every** $z$. Hence $\min_z\max=\tfrac1{12\sqrt3}$ exactly, the witness is optimal in this dual family, and the minimiser is not unique: the value is attained on the whole interval $z\in[-\tfrac12,\tfrac14]$, the endpoints being where the $(b,b,b)$ and $(a,a,b)$ functions catch up. The exact-arithmetic screen independently returns $z_\ast=0$ with the same $y_\ast$, which is a second point of that interval and confirms the degeneracy.

**The activity claim is wrong as stated.** The record says all three of the all-within, mixed and all-cross functions are simultaneously active, and the Lean file states the all-within one as a theorem. At $p=2$ the within block $\Lambda^2V_1\oplus\Lambda^2V_2$ is two-dimensional, so no triple of distinct indices carries $(\lambda_+,\lambda_+,\lambda_+)$: the all-within function is not a constraint of the $n=4$ programme at all. The arithmetic identity $a^3-\tfrac14a=\tfrac{a^3}4$ is true, since $\tfrac34a^3-\tfrac a4=\tfrac a4(3a^2-1)=0$, and it is harmless, because adding a function that is not a constraint can only raise $y$ and here raises it by nothing. But two consequences should be recorded: the "three coincidences" are two, and the mixed function that is active is $(\lambda_+,\lambda_-,\lambda_-)$ whereas $(\lambda_+,\lambda_+,\lambda_-)$ is strictly inactive. **CONFIRMED EXACT, with the activity narrative corrected.**

## 6. The $n=12$ witness, in exact arithmetic

$p=6$, $N=66$, $a=\lambda_+=1/\sqrt{55}$ with multiplicity $30$, $b=\lambda_-=-\sqrt{55}/66=-\tfrac56a$ with multiplicity $36$. Trace $30a+36b=0$ because $36\cdot\tfrac56=30$, and norm $30a^2+36\cdot\tfrac{25}{36}a^2=55a^2=1$. All four triple types are available here since $30,36\ge3$:

$$f_0=a^3-za,\quad f_1=-\tfrac56a^3-\tfrac{7za}{18},\quad f_2=\tfrac{25}{36}a^3+\tfrac{2za}9,\quad f_3=-\tfrac{125}{216}a^3+\tfrac56za .$$

$f_0=f_2$ gives $\tfrac{11}{36}a^3=\tfrac{11}9za$, that is $z_\ast=\tfrac{a^2}4=\tfrac1{220}$, at which $y_\ast=a^3-\tfrac{a^3}4=\tfrac34a^3=\tfrac{3}{4}\,55^{-3/2}=\tfrac{3\sqrt{55}}{12100}$. At that $z$ the other two are strictly below: $f_1=a^3(-\tfrac56-\tfrac7{72})<0$ and $f_3=-\tfrac{80}{216}a^3<0$. Since $f_0$ is strictly decreasing and $f_2$ strictly increasing, and the max of affine functions is convex, this is the global minimax and here the minimiser is unique.

$$\sum\lambda^3=30a^3+36b^3=a^3\Big(30-\tfrac{125}6\Big)=\tfrac{55}6a^3=\frac1{6\sqrt{55}},\qquad (n-2)Ny_\ast=660\cdot\tfrac34a^3=495\cdot55^{-3/2}=\frac9{\sqrt{55}},$$
$$\text{bound}=\frac{1+54}{6\sqrt{55}}=\frac{55}{6\sqrt{55}}=\frac{\sqrt{55}}6=\theta_0(12).$$

**The agreement is exact, not approximate.** The record's $z=0.004544$ is $1/220=0.00454545$, its $y=0.001839$ is $3\sqrt{55}/12100=0.00183873$, and its $1.2362$ is $\sqrt{55}/6=1.23603308$. The record's own hedge, that the two "agree to the precision of the hand arithmetic", understates what is true.

## 7. The general spectrum: the exactness is an identity in $p$

Put $r=(p-1)/p$, so $\lambda_-=-r\lambda_+$, and write $a=\lambda_+$ with $a^2=1/((p-1)(2p-1))$, multiplicities $p(p-1)$ and $p^2$, total $p(2p-1)=\binom{2p}2$. Then

$$f_0=a^3-za,\quad f_1=-ra^3-\tfrac z3a(2-r),\quad f_2=r^2a^3-\tfrac z3a(1-2r),\quad f_3=-r^3a^3+zra .$$

Two clean differences do all the work:

$$f_1-f_0=(1+r)\Big[\tfrac{za}3-a^3\Big],\qquad f_3-f_2=(1+r)\Big[\tfrac{za}3-r^2a^3\Big],$$

so $f_1\le f_0$ iff $z\le3a^2$ and $f_3\le f_2$ iff $z\le3r^2a^2$. The crossing $f_0=f_2$ is at

$$a^3(1-r^2)=\tfrac{2(1+r)}3za\ \Longrightarrow\ z_\ast=\tfrac32a^2(1-r)=\frac{3a^2}{2p}=\frac{3}{2p(p-1)(2p-1)},\qquad y_\ast=a^3\Big(1-\frac3{2p}\Big)=\frac{2p-3}{2p}a^3 .$$

At $z_\ast$ both side conditions hold: $\tfrac1{2p}\le1$ always, and $\tfrac1{2p}\le r^2$ is $(2p-1)(p-2)\ge0$, true for $p\ge2$ with equality exactly at $p=2$, which is why at $p=2$ the all-cross function is active as well and the minimiser degenerates to an interval. So $f_0$ decreasing, $f_2$ increasing, the other two below, and $y_\ast$ is the minimax. Then, using $a^3(p-1)(2p-1)=a$,

$$\sum\lambda^3=a^3(p-1)\frac{2p-1}p=\frac ap,\qquad (n-2)Ny_\ast=2(p-1)\,p(2p-1)\,\frac{2p-3}{2p}a^3=(2p-3)a,$$
$$\text{bound}=a\Big(2p-3+\frac1p\Big)=a\frac{(2p-1)(p-1)}p=\frac{\sqrt{(p-1)(2p-1)}}p=\frac{\sqrt{4(2p-1)(p-1)}}{2p}=\theta_0(2p).$$

**So the bound returns $\theta_0(2p)$ identically in $p$, not only at $p=2$ and $p=6$.** And the true $\theta$ does too, computed independently from §4.1: with $\lambda_{ij}=a$ inside a factor and $-ra$ across,

$$\theta=\frac ap+a^3\Big[\underbrace{p(p-1)(p-2)}_{3\cdot2\binom p3\text{ all-within triangles}}+\underbrace{3(p-1)^3}_{\text{one-within-two-cross}}\Big]=\frac ap+a^3(p-1)(2p-1)(2p-3)=\frac ap+(2p-3)a=\theta_0(2p).$$

Two things worth recording. First, the true $\theta$ of $S^p\times S^p$ is $\theta_0(2p)$ for every $p\ge2$, derived here from the product metric and given 14 without appeal to the record. Second, the bound and the truth agree term by term, not just in total: $\sum\lambda^3$ is common and $\tfrac12m_3=(n-2)Ny_\ast=(2p-3)a$ exactly. §8 explains why.

The record's spectrum data are confirmed as printed: $\lambda_+=1/\sqrt{(p-1)(2p-1)}$ with multiplicity $p(p-1)$, $\lambda_-=-\tfrac1p\sqrt{(p-1)/(2p-1)}$ with multiplicity $p^2$, unit norm since $(p-1)[p+(p-1)]a^2=1$.

## 8. Tightness versus validity

**The agreement is structural.** At the balanced product the support of $T$ is the triangle set of §2, and the eigenvalue pattern of a triangle $\{\{i,j\},\{j,k\},\{i,k\}\}$ is forced: if two of the three pairs lie inside one spherical factor then all of $i,j,k$ do, so the third does too. Hence the only triple types in $\operatorname{supp}T$ are $(\lambda_+,\lambda_+,\lambda_+)$ and $(\lambda_+,\lambda_-,\lambda_-)$, and these are exactly the two functions $f_0$ and $f_2$ that are active at $z_\ast$. The types that are inactive, $(\lambda_+,\lambda_+,\lambda_-)$ and $(\lambda_-,\lambda_-,\lambda_-)$, carry $T=0$. That is complementary slackness verbatim: the primal $T$ is feasible for the LP of §4, the dual pair $(y_\ast,z_\ast)$ is feasible, and their objectives coincide. **So the balanced product's own $T$ is optimal for the relaxed programme, the dual choice is optimal, and the agreement is not a coincidence of the parametrisation.** At $p=2$ the same holds in degenerate form: only the $(\lambda_+,\lambda_-,\lambda_-)$ type occurs in $\operatorname{supp}T$, because a factor of dimension two has no triple of coordinate indices, and that single type is the one that pins $y$.

**But the record's framing of the dual is an overclaim.** "LP duality turns it into a one-dimensional minimax" asserts an equivalence that does not hold. The full dual of the LP in §4 has a multiplier per index: any $y$ and any $u_1,\dots,u_N$ with $\lambda_\alpha\lambda_\beta\lambda_\gamma\le y+u_\alpha+u_\beta+u_\gamma$ at distinct triples give

$$\theta\ \le\ \sum_\alpha\lambda_\alpha^3+(n-2)\Big[Ny+3\sum_\alpha u_\alpha\Big],$$

by the same pairing. The record's family is the slice $u_\alpha=\tfrac z3\lambda_\alpha$, chosen so that $\sum_\alpha u_\alpha=0$ by trace-freeness. That slice happens to contain an optimal dual at the balanced product, which is what §7 exhibits, and it is far from optimal elsewhere. At the padded $W_{\mathbb{CP}^2}$ spectrum at $n=12$ the slice gives $221/\sqrt6=90.2229$ while the free-$u$ dual gives $11/\sqrt6=4.4907$ (§10.3), a factor of $20$. So: **valid, sometimes exact, and not the LP dual.**

## 9. $W_{\mathbb{CP}^2}$

Spectrum $2c,-c,-c$ and zeros, $c=1/\sqrt6$, trace-free and unit since $6c^2=1$. The triple $(2c,-c,-c)$ has $\Sigma=0$ and $\Pi=2c^3>0$, so its function is the constant $2c^3$ and $y(z)\ge2c^3$ for every $z$. At $z=0$ every function equals its product and the largest product is $2c^3$, so $y_\ast=2c^3=\tfrac1{3\sqrt6}$ at $z_\ast=0$, exactly. With $\sum\lambda^3=8c^3-2c^3=6c^3=1/\sqrt6$ and $(n-2)N=12$ at $n=4$,

$$\text{bound}=\frac1{\sqrt6}+12\cdot\frac1{3\sqrt6}=\frac5{\sqrt6}=2.0412415 .$$

**Confirmed, and consistent rather than defective**, since the true value is $\sqrt{3/2}=1.2247449$ and an upper bound is entitled to be loose. The gap factor is exactly $5/3$: the truth has $\tfrac12m_3=12c^3$ against the bound's allowance $24c^3$, that is, the relaxation permits twice the $T$-mass on the one productive triple that the geometry actually puts there.

## 10. The reduction claim: REFUTED

### 10.1 The parts that hold

The bound uses no criticality, so it applies to **every** Ricci-flat unit-norm Weyl tensor, and indeed to every trace-free unit-norm symmetric operator on $\Lambda^2\mathbb R^n$ for which given 14 and L153 hold. So the shape of the inference is right: if $\max_\lambda\text{bound}(\lambda)\le\theta_0(n)$ for $n\ge12$ over realisable spectra, then $\theta\le\theta_0(n)$ for all such tensors, and no criticality analysis would be needed. The equality analysis it would owe is heavier than the record suggests: equality in $\theta=\theta_0(n)$ would force equality in the spectral maximisation **and** tightness of the dual constraint at every triple in $\operatorname{supp}T$ **and** the marginal to be saturated as it is, from which the configuration would have to be reconstructed, presumably through L201 and the integrality route. Uniqueness does not fall out of the bound by itself.

### 10.2 The part that fails

**The maximum over spectra is not $\theta_0(n)$ at $n\ge12$, and there is no crossover.** Three exhibits, all exact, all closed form.

**(a) The padded $W_{\mathbb{CP}^2}$ spectrum, at any $n\ge4$.** $W_{\mathbb{CP}^2}$ extended by zero to $\Lambda^2\mathbb R^n$ is a Ricci-flat unit-norm algebraic Weyl tensor for every $n\ge4$, its $\theta$ is unchanged at $\sqrt{3/2}$, and §9's argument gives $y_\ast=2c^3$ independently of $n$, because the pinning triple has $\Sigma=0$. Therefore

$$\text{bound}(n)=\frac1{\sqrt6}\Big(1+\frac{n(n-1)(n-2)}6\Big),$$

which is $5/\sqrt6=2.0412$ at $n=4$, the record's own figure, and $221/\sqrt6=90.2229$ at $n=12$, against $\theta_0(12)=1.2360$. It grows like $n^3/(6\sqrt6)$ and exceeds $\theta_0(n)<\sqrt2$ at every $n\ge4$. **The maximisation the record proposes has value at least $90.22$ at $n=12$, not $1.236$, and the crossover it predicts does not happen at any $n$.**

**(b) A non-padded exhibit, in case padding is thought degenerate.** Take six round $S^2$ factors of equal radius, a genuine $12$-dimensional Einstein product whose Weyl tensor is coordinate-diagonal. By §4.1, $h=\tfrac1{2k-1}\mathrm{Id}$ for $k$ equal $S^2$ factors, so at $k=6$ the normalised spectrum is $10v$ with multiplicity $6$ and $-v$ with multiplicity $60$, $v=1/\sqrt{660}$, with no kernel at all. Then $f_0=1000v^3-10zv$ and $f_3=-v^3+zv$ cross at $z_\ast=91v^2=91/660$ with $y_\ast=90v^3$, the other two types being far below, and

$$\text{bound}=5940v^3+660\cdot90v^3=65340v^3=\frac{3\sqrt{165}}{10}=3.8535698,\qquad \theta=7260v^3=\frac{\sqrt{165}}{30}=0.4281744 .$$

So a spectrum with full support, realised by an actual metric, already gives $3.8536>\theta_0(12)=1.2360$. **Worse, $3.8536>11/\sqrt{13}=3.0509$**, so at this spectrum the new bound is weaker than the record's standing bound of given 18. The dual bound does not dominate the standing bound pointwise, and any claim of a "factor of $2.47$" improvement is a statement about one spectrum, not about the bound.

**(c) The mechanism, stated positively.** The $y$-term charges the least upper bound $y$ against the entire $T$-mass $2(n-2)N$, which counts every index including the kernel and every triple including those on which $\lambda_\alpha\lambda_\beta\lambda_\gamma=0$. The true $\tfrac12m_3$ collects only the triples in $\operatorname{supp}T$ whose three eigenvalues are nonzero. If the spectrum is supported on $k$ indices, the productive triples number $O(k^3)$ while the charge is $O(n^3)$, and whenever three eigenvalues vanish the all-kernel triple forces $y_\ast\ge0$, so none of that charge can be recovered by choosing $z$. The bound is therefore near-tight only on spectra that are spread across essentially all of $\Lambda^2\mathbb R^n$, which is exactly the balanced product, and it is off by a factor growing like $n^3/k^3$ elsewhere.

### 10.3 There is no repair inside the marginal relaxation

One might hope the failure is an artefact of the one-parameter dual slice, which §8 shows is not the LP dual. It is not. At the padded $W_{\mathbb{CP}^2}$ spectrum at $n=12$ the **exact** LP optimum of §4 is $11/\sqrt6=4.4907$, still $3.6$ times $\theta_0(12)$.

Primal: put all of index $1,2,3$'s marginal on the single triple, $T_{123}=10$, which saturates $\sum_{\beta\gamma}T_{1\beta\gamma}=2\cdot10=20=2(n-2)$ and likewise at $2$ and $3$, and give the remaining $63$ indices their marginals with a uniform small weight on triples among themselves. Then $\tfrac12m_3=\tfrac12\cdot6\cdot10\cdot2c^3=60c^3$, and no feasible $T$ does better because $\lambda_\alpha\lambda_\beta\lambda_\gamma$ vanishes off the permutations of $(1,2,3)$. Dual, in the free-$u$ form of §8: $y=3c^3$, $u_1=-c^3$, $u_2=u_3=0$, $u_k=-c^3$ on the $63$ kernel indices. Feasibility, triple by triple: $(1,2,3)$ gives $2c^3\le3c^3-c^3=2c^3$, tight; $(1,2,k)$ gives $0\le c^3$; $(2,3,k)$ gives $0\le2c^3$; $(1,k,l)$ gives $0\le0$; $(2,k,l)$ gives $0\le c^3$; $(k,l,m)$ gives $0\le0$. Objective $Ny+3\sum u=198c^3-192c^3=6c^3$, so the bound is $6c^3+10\cdot6c^3=66c^3=11/\sqrt6$. Primal equals dual, so that is the LP value.

**Conclusion for item 10.** Any bound whose only structural input about $T$ is L153's marginals is at least $11/\sqrt6=4.4907$ at $n=12$, so it cannot reach $\theta_0(12)=1.2360$, whatever dual family is used. The reduction as written is not merely unproven, its hypothesis is false. What is needed is an input that couples $T$ to the spectrum, and one is already in the record and explicitly discarded here: relation (B), $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$, is **linear in $T$ at fixed spectrum**, hence admissible in the very same LP with $N$ extra multipliers, and it is exactly the sort of constraint that penalises concentrating $T$ off the spectrum's support. The natural repair is to put (B) back in and redo the dual, not to maximise the present bound over spectra. The single line of retreat available to the claim is to restrict the maximisation to spectra of **critical** tensors, which the derivation never needed. That would forfeit the "settles the conjecture outright, uniqueness included" clause, and it would need the padded competitors checked for criticality one at a time.

The record's crossover remark should also be corrected: $n=6+2\sqrt7$ is where $\theta_0(n)$ overtakes the **true** value $\sqrt{3/2}$, from $4(n-1)(n-2)=3n^2$, that is $n^2-12n+8=0$. That is a crossover of true values. The bound at the same spectrum diverges cubically in $n$, so the crossover does not transfer to it, and the sentence "the maximisation must cross over from the competitor's value to $\theta_0(n)$ somewhere" is where the reasoning slips.

## 11. The Lean file

[L203DualBound.lean](../lean/HamiltonsCubic/Results/L203DualBound.lean) builds clean, `lake build HamiltonsCubic.Results.L203DualBound` completing 3006 jobs at exit 0 on toolchain `leanprover/lean4:v4.33.1` with Mathlib `v4.33.1`, and it is imported by the library root at [HamiltonsCubic.lean:472](../lean/HamiltonsCubic.lean#L472). All seven results report

`depends on axioms: [propext, Classical.choice, Quot.sound]`

so there is no `sorry` and **no gap axiom**, as claimed. Statement by statement, against the prose:

| Theorem | Says what the prose says? |
|---|---|
| `dual_n4_unit_norm` | Yes. $2(1/\sqrt3)^2+4(1/(2\sqrt3))^2=1$. |
| `dual_n4_trace_free` | Yes. |
| `dual_n4_bound_eq_theta0` | Yes, as an arithmetic identity: $\tfrac32a^3+12y=\sqrt3/2$. It does not say that the left side *is* the bound, since neither $T$, $\theta$, nor $(n-2)N$ appears. |
| `dual_n4_within_active` | Arithmetically true, **but the triple it describes is not in the $n=4$ programme** (§5): $\lambda_+$ has multiplicity two. Its docstring's claim that this is why "the bound cannot be improved by lowering $y$ alone" is the wrong reason. The true reason, the constant function of the $(\lambda_+,\lambda_-,\lambda_-)$ triple, is not stated anywhere in the file. |
| `dual_n4_cross_active` | Yes, and this triple does exist ($\lambda_-$ has multiplicity four). |
| `dual_balanced_collapses` | Yes, and it is stronger than the prose, which claims only two checked dimensions: $1/(pD)+(2p-3)/D=D/p$ for $D^2=(p-1)(2p-1)$ is the general-$p$ collapse of §7. $p$ and $D$ are free reals with $D^2$ hypothesised, so it is the algebra, not the spectrum. |
| `theta0_eq_D_div_p` | Yes, $\theta_0(2p)=D/p$ under the same hypothesis. |

**What it does NOT type**, which is most of the claim:

1. The derivation. No $T$, no hollowness, no marginal, no $m_3$, no pairing, no $\theta$, no Weyl tensor, no $\Lambda^2$. The file is arithmetic on six real numbers and two free reals.
2. The minimax. There is no `min`, no `max`, no quantifier over triples, and no statement that $y=1/(12\sqrt3)$ is *least* for $z=1/4$, which is the only thing that makes the bound the bound rather than one feasible evaluation.
3. Dual feasibility at the remaining triple types. The $(\lambda_+,\lambda_+,\lambda_-)$ and $(\lambda_+,\lambda_-,\lambda_-)$ constraints are never stated, so the file does not certify that $(y,z)=(1/(12\sqrt3),1/4)$ is feasible at all, only that two functions take the value $y$ there.
4. That the multiset of triples is drawn with multiplicity, which is the defect in item 4 of that table.
5. The $n=12$ witness, in any form.
6. That $\sum\lambda^3=1/(2\sqrt3)$ and $(n-2)N=12$ come from the spectrum and from L153 rather than being written in by hand.
7. In `dual_balanced_collapses`, that $\sum\lambda^3=1/(pD)$ and $(n-2)Ny_\ast=(2p-3)/D$ for the balanced product. Both are supplied as hypotheses of shape, so the general-$p$ exactness is machine-checked only downstream of the two facts a reader would most want checked.

## 12. What would break it, and what I did to look for it

| Object sought | What I did | Outcome |
|---|---|---|
| A spectrum with bound $<\theta$ | Proved it impossible: $W$'s own $T$ is feasible for the LP the dual bounds, so bound $\ge$ LP $\ge\theta$ (§4). Then checked ten spectra in closed form anyway, including three balanced products, two paddings, two multi-sphere products, and the two extreme rays of the $n=4$ coordinate sector | None exists, and none found |
| An unbounded minimax, which would make the bound read $\theta\le-\infty$ | Averaged $\lambda_\alpha+\lambda_\beta+\lambda_\gamma$ over triples, obtaining $\binom{N-1}2\operatorname{tr}W=0$, hence a triple of each sign of $\Sigma$ | Impossible, so $\min_z$ is finite and attained |
| A failure of the $z$-cancellation | Checked it needs total symmetry of $T$ and given 15 in all three slots, not first-slot symmetry alone | Sound as derived |
| A hollowness gap, a triple with $T\ne0$ and a repeated index | Computed $[\omega_{ij},\omega_{jk}]=-\omega_{ik}$ from $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$ and read off the support and the marginal | Support is exactly the triangles, and given 15 is reproduced |
| An error in given 14's factor $\tfrac12$ or in $T=1$ | Recomputed $\theta$ for $S^2\times S^2$ and for $W_{\mathbb{CP}^2}$ through given 3's chirality formula, $\langle W,W^\#\rangle=\sum_\pm2\operatorname{tr}\mathcal A^3$, and compared with the triangle formula | Agree exactly, $\sqrt3/2$ and $\sqrt{3/2}$ |
| A spectrum defeating the reduction | Constructed the Weyl operator of an arbitrary product of round spheres from $\mathcal W=\mathcal R-D_h$, $h_i=\tfrac1{n-2}(2\rho_i-\tfrac\sigma{n-1})$, and evaluated the bound at padded $W_{\mathbb{CP}^2}$, at padded $S^2\times S^2\times S^2$ and at the non-padded $(S^2)^6$ | **Found, three times over: $90.2229$, $17.4284$ and $3.8536$ at $n=12$ against a target of $1.2360$** |
| A repair of the reduction inside the same relaxation | Solved the LP exactly at the padded $W_{\mathbb{CP}^2}$ spectrum at $n=12$, primal and free-$u$ dual, both $11/\sqrt6$ | No repair: $4.4907>1.2360$ |

Everything above is exact. The only machine step other than the Lean build was an exact-arithmetic screen of values already derived by hand, which caught one hand slip of mine ($y_\ast=1/12$, not $1/8$, in the $\lambda_{12}=0$ row of §4.2) and confirmed the other nine rows and all closed forms as printed.

## Verdict

**The bound is VALID, its exactness at the balanced product is CONFIRMED and stronger than claimed, and the reduction of the conjecture that the record hangs on it is REFUTED.**

1. **Keep the bound.** Items 1, 2 and 3 are sound as derived, from exactly the three advertised inputs. The bound holds for all Ricci-flat unit-norm Weyl tensors, critical or not, and it cannot fall below $\theta$ for a reason stronger than any test: the tensor's own $T$ is feasible for the programme the bound relaxes.
2. **Strengthen the exactness statement.** It is exact at $S^p\times S^p$ for every $p\ge2$, with $z_\ast=\tfrac3{2p(p-1)(2p-1)}$, $y_\ast=\tfrac{2p-3}{2p}\lambda_+^3$ and bound $=\sqrt{(p-1)(2p-1)}/p=\theta_0(2p)$, and the true $\theta$ of that product is the same number, so the LP is exact there by complementary slackness with the geometry's own $T$. The $n=12$ agreement is exact, not "to the precision of the hand arithmetic".
3. **Withdraw the reduction.** "The remaining question is one finite-dimensional maximisation" is false as stated. At $n=12$ the bound is $221/\sqrt6=90.2229$ at the padded $W_{\mathbb{CP}^2}$ spectrum and $3\sqrt{165}/10=3.8536$ at the non-padded $(S^2)^6$ spectrum, and even the exact LP optimum over the marginal relaxation is $11/\sqrt6=4.4907$, against $\theta_0(12)=1.2360$. There is no crossover: the bound at a fixed spectrum grows like $n^3$. The $3.8536$ figure also shows the bound is not uniformly stronger than the standing $(n-1)/\sqrt{n+1}=3.0509$.
4. **Correct two smaller things.** The $n=4$ witness has two active constraints, not three, and the all-within triple the prose and [L203DualBound.lean](../lean/HamiltonsCubic/Results/L203DualBound.lean) both single out does not exist at $n=4$. The constraint that pins $y$ is the mixed $(\lambda_+,\lambda_-,\lambda_-)$ triple, whose function is constant in $z$ because $\lambda_++2\lambda_-=0$. And "LP duality turns it into a one-dimensional minimax" should read that the one-parameter family is a sub-family of the LP dual, exact at the balanced product and off by a factor of $20$ at padded $W_{\mathbb{CP}^2}$ at $n=12$.
5. **The direction that survives.** Relation (B) is linear in $T$ at fixed spectrum, so it belongs in the same LP with its own multipliers. Adding it is the repair worth attempting, because the present relaxation's blindness to where the spectrum's support sits is precisely what the padded exhibits exploit.
