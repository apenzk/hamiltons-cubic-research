# Reviewer 323, Lemma L70, the deficiency identity, and route R14

**Cold brief, independent implementation.** Every number below comes from [scripts/reviewers/r323/](../scripts/reviewers/r323/), built from the definitions alone: an orthonormal basis $L_{ij}$ of $\mathfrak{so}(n)$ under $\langle A,B\rangle=\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$, the structure constants from matrix brackets, $\mathcal W_n$ as the nullspace of first Bianchi plus Ricci on $\mathrm{Sym}(\Lambda^2)$, and $W^\#_{ab}=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}_aW\,\mathrm{ad}_bW)$. Calibration checks before any audit: $\dim\mathcal W_n=35,84,168,300$ at $n=5,6,7,8$; $Q(\mathcal W_n)\subseteq\mathcal W_n$ to $2\times10^{-15}$; and [Lemma L23](../results.md)'s $\theta=\frac2n\sqrt{rN/(N-r)}$ reproduced to $9$ digits at $n=6,8,10$. Stored operators in [scripts/data/](../scripts/data/) were used as inputs only, each re-verified against my own $\mathcal W_n$ and my own criticality residual.

| claim | verdict |
|---|---|
| **L4**, R14 a reduction or a tautology | **TAUTOLOGY. Reviewer 118's failure, repeated**, and its best relaxation *is* the closed $\Pi$-bound |
| **L1** (the identity | **CONFIRMED, hypotheses over-stated**), needs criticality and $\lambda_{\min}<0\le\lambda_{\max}$, nothing else |
| **L2** (the equality case | **CONFIRMED; the "for every $v$" question is void**), $D$ is constant on $E_{\min}$ |
| **L3** (the saturation set | **CONFIRMED as stated, and STRENGTHENED**), T4 now closed in the diagonal half |
| **L5** (the Hilbert–Schmidt form | **CONFIRMED, and it carries no new information**), a change of variables on L1 |

---

## L4, the one that matters: R14 is a tautology, and it is the *same* tautology

### 1. $D$ is not an independent quantity

At a critical point, criticality alone gives $\langle v,W^\#v\rangle=\lambda_{\min}(\theta-\lambda_{\min})$, hence

$$D(v)\;=\;\lvert\lambda_{\min}\rvert\big(\lambda_{\min}+(n-2)\lambda_{\max}-\theta\big)$$

**identically**, $D$ is an algebraic function of $(\theta,\lambda_{\min},\lambda_{\max})$ and of nothing else. Substituting it into the deficiency statement returns $\theta\le\theta_0(n)$ after cancelling $\lambda_{\min}+(n-2)\lambda_{\max}$ from both sides. The claimed equivalence is therefore not a reduction; it is the target with $\theta$ renamed. [routes.md](../routes.md) presents "it is an identity, so post F34 cannot bite" as the route's strength. It is the route's problem: an exact reformulation has, by construction, exactly the difficulty of what it reformulates.

### 2. The only content is the second representation, and its ceiling is computable

The one thing that is *not* a restatement is the other expression, $D(v)=\tfrac12\sum(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{vab}^2$. [plan.md](../plan.md)'s T3 names its raw material precisely: spectral weights, the row cap $\sup\lVert[v,\varphi]\rVert^2=2$, and the total $\sum c_{vab}^2=2(n-2)$. I verified the row cap independently ($\max$ over $v,\varphi$ of $\lVert[v,\varphi]\rVert^2=2.000000000$ at $n=5,6,8,10$) and I added, in the route's favour, the record's per-row identity from [B4](../plan.md), which I re-derived in the form it is actually needed:

$$\sum_{a,b}\lambda_a c_{vab}^2=-\mathop{\mathrm{tr}}\!\big(W\,\mathrm{ad}(v)^2\big)=-2\langle v,Wv\rangle\quad\text{for every }W\in\mathcal W_n\text{ and every unit }v,$$

exact to $8\times10^{-16}$ at $n=5,6,7,8$ and **false off $\mathcal W_n$** (residuals $8.9$–$20.7$ on random symmetric operators), so it is a genuine use of Weyl membership, and for $v\in E_{\min}$ it reads $\sum_a\lambda_am_a=2\lvert\lambda_{\min}\rvert$.

The linear program that minimises $D$ over all mass distributions obeying that data has a **closed form** once the row cap is dropped. All points $\big(\tfrac{\lambda_a+\lambda_b}2,\lambda_a\lambda_b\big)$ lie above both of the lines $w=\lambda_{\min}(2s-\lambda_{\min})$ and $w=\lambda_{\max}(2s-\lambda_{\max})$, because $(\lambda_a-\lambda_{\min})(\lambda_b-\lambda_{\min})\ge0$ and $(\lambda_a-\lambda_{\max})(\lambda_b-\lambda_{\max})\ge0$, and both lines are attained by real pairs. So the lower convex envelope is $\mathrm{env}(s)=\max\{\lambda_{\min}(2s-\lambda_{\min}),\,\lambda_{\max}(2s-\lambda_{\max})\}$, evaluated at $s^*=\lvert\lambda_{\min}\rvert/(n-2)$. In the branch $\lambda_{\max}\ge n\lvert\lambda_{\min}\rvert/(n-2)$ this gives $D_{\mathrm{LP}}=\lvert\lambda_{\min}\rvert\big[(n-2)\lambda_{\max}-n\lvert\lambda_{\min}\rvert\big]$ and hence

$$\theta\;\le\;\lambda_{\min}+(n-2)\lambda_{\max}-\frac{D_{\mathrm{LP}}}{\lvert\lambda_{\min}\rvert}\;=\;(n-1)\lvert\lambda_{\min}\rvert .$$

**Strip the row cap and the deficiency identity yields exactly the $\lambda$-weighted bound $\theta\le(n-1)\lvert\lambda_{\min}\rvert$**, which [post F40](../findings/fence-posts.md) identifies as the record's own $\Pi$-bound and which [bounds.md](../findings/bounds.md) closes as *"the reduction is nowhere easier than the target"*. R14 does not escape that route; it lands back on it. The row cap does bite at some points, it is what takes the $n=8$ witness from $2.116891$ down to $1.663647$, but it never binds at a point where the conjecture is tight, and section 3 shows it does not rescue the route.

### 3. The relaxation overshoots by more than a factor of two

Maximising the full LP bound (row cap included), over trace-free, unit-norm spectra with three distinct eigenvalues ([t9.py](../scripts/reviewers/r323/t9.py)):

| $n$ | $\theta_0(n)$ | max LP bound | ratio |
|---|---|---|---|
| $8$ | $1.145644$ | $2.291288$ | $2.000$ |
| $12$ | $1.236033$ | $2.840188$ | $2.298$ |

So **no lower bound on $D$ derived from the spectrum, the total mass, the row cap and the per-row identity can prove Conjecture A**, the same order as [fence post F10](../findings/fence-posts.md)'s $0.80\sqrt{n-2}=2.53$ at $n=12$. R14 sits inside post F10's fenced class.

### 4. And the leftover information is exactly the original problem

Does $D$ carry more than spectrum-plus-marginals? Yes, and only where the conjecture is slack. Comparing the LP minimum against the true $D$ at real critical points:

| point | $\theta$ | residual | true $D$ | $D_{\mathrm{LP}}$ | LP bound |
|---|---|---|---|---|---|
| $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$, $n=6,8,10,12$ |, | $\le6\times10^{-16}$ | $0$ | $0$ | $=\theta$ exactly |
| maximal torus, $n=6,8,10,12$ |, | $\le2\times10^{-16}$ | $0.166667,0.166667,0.15,0.133333$ | identical | $=\theta$ exactly |
| $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$ | $0.836660$ | $2.8\times10^{-16}$ | $0.1$ | $0.1$ | $=\theta$ exactly |
| $\mathbb{CP}^3,\mathbb{CP}^4,\mathbb{CP}^5$ |, | $\le3.4\times10^{-15}$ | $0.444444,0.555556,0.6$ | identical | $=\theta$ exactly |
| frontier points at $\sqrt{3/2}$, $n=6,8,12$ | $1.224745$ | $\le5.4\times10^{-16}$ | $0.666667,1.333333,2.666667$ | identical | $=\theta$ exactly |
| $n=8$ non-diagonal witness | $1.088948$ | $2.9\times10^{-15}$ | $0.619138$ | $0.445342$ | $1.663647$ |

The LP is **exact at every point where the conjecture is tight** and loose only at the one non-symmetric witness, where it overshoots $\theta_0(8)$ by $45\%$. The information $D$ holds beyond its marginals is frame-realizability, which is the original problem, and it is unavailable precisely where a proof would need it. This is [post F34](../findings/fence-posts.md)'s shape as well: a quantity sharp on the equality family admits no lossy step.

### Verdict on L4

**R14 is a tautology in Reviewer 118's exact sense, and the record should close it.** Two statements in [plan.md](../plan.md) and [routes.md](../routes.md) do not survive: *"the conjecture becomes the deficiency statement … with no residue"* is true and is the objection, not the answer; and T3's grade $9$ (attackable $3$ on the strength of "the raw material is on the record"), is not supportable, because that raw material provably ceilings at $2.30\times\theta_0(12)$. What would reopen it is raw material of a different kind: any constraint on $c_{vab}^2$ that is **not** a function of the spectrum and the marginals. Nothing on the record is one.

---

## L1, the identity: CONFIRMED, with a corrected hypothesis list

**Exact.** Identity residual $\le1\times10^{-14}$ at every critical point I built: the four balanced products, the four maximal tori, $\mathrm{ad}(\mathfrak{su}(3))$, $\mathbb{CP}^{3,4,5}$, the four frontier points, the $n=8$ non-diagonal witness, $14$ sphere products, padded $\mathbb{CP}^3$ and padded $S^3\times S^3$, plus $216$ generic $n=6$ points and $790$ diagonal points at $n=8,10,12$.

**What it actually needs, against what the record says it needs.**

| hypothesis | needed? | evidence |
|---|---|---|
| criticality $Q(W)=\theta W$ | **yes** | identity gap $0.266$–$0.497$ at random non-critical $W\in\mathcal W_6$ |
| $v$ a unit vector in $E_{\min}$ | **yes** | the mass $\sum c_{vab}^2=2(n-2)$ needs $\lVert v\rVert=1$; the eigen-relation needs $v\in E_{\min}$ |
| $\lambda_{\min}<0\le\lambda_{\max}$ | **yes** | see below |
| unit norm $\lVert W\rVert=1$ | **no** | both sides are homogeneous of degree $1$ in $W$ |
| Weyl membership | **no** | both ingredients hold for any symmetric operator: $\sum c_{vab}^2=8.000000000$ and expansion-versus-direct $\langle v,W^\#v\rangle$ agreeing to $1.2\times10^{-16}$ on random non-Weyl symmetric operators at $n=6$ |
| $\theta>0$, $n\ge5$ | **no** | neither enters the derivation |

**$D\ge0$ does hold termwise, and with a kernel, and with non-unique minimisers.** For $\lambda_{\min}\le0\le\lambda_{\max}$ the minimum of $\lambda_a\lambda_b$ over the spectrum is $\lambda_{\min}\lambda_{\max}$ in all three cases: two same-sign factors give a nonnegative product; opposite signs give $\lambda_a\lambda_b\ge\lambda_{\min}\lambda_b\ge\lambda_{\min}\lambda_{\max}$; a zero eigenvalue gives $0>\lambda_{\min}\lambda_{\max}$. Tested where it might break, the frontier points carry kernels of dimension $12$, $25$ and $63$, and $790$ diagonal points include kernels of dimension $9$ and $11$, with **zero negative slack in $1{,}020$ critical points**.

**The one hypothesis the record leaves implicit is $\lambda_{\max}\ge0$.** It is free on $\mathcal W_n$ ($\mathop{\mathrm{tr}}W=0$; my basis elements are traceless to $6\times10^{-16}$), but the step fails without it: the diagonal operator on $\Lambda^2\mathbb R^6$ with $\lambda(L_{12})=-1$, $\lambda=-0.3$ on the eight planes meeting $\{1,2\}$ and $-0.7$ elsewhere gives $D=-0.840000000$. Recommend that [bounds.md](../findings/bounds.md) state the trace-free hypothesis where it writes *"each summand being a nonnegative weight against a nonnegative factor"*.

---

## L2, the equality case: CONFIRMED, and the "for every $v$" search is void

**The support characterisation is exact.** $\lambda_{\min}\lambda_{\max}<0$ is the strict minimum, so $\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$ forces opposite signs and then $\lvert\lambda_a\lambda_b\rvert<\lvert\lambda_{\min}\lambda_{\max}\rvert$ unless $\lambda_a=\lambda_{\min}$ and $\lambda_b=\lambda_{\max}$. No spurious pair can carry mass.

**"For every $v$" is not an extra assumption, it is forced.** By L4's step 1, $D(v)=\lvert\lambda_{\min}\rvert(\lambda_{\min}+(n-2)\lambda_{\max}-\theta)$, whose right side has no $v$ in it. **$D$ is constant on the unit sphere of $E_{\min}$ at every critical point**, so saturating for one $v$ is saturating for all. The brief's proposed hunt (a critical point saturating for one $v\in E_{\min}$ and not another), cannot succeed, and no computation is needed to say so. Measured anyway: spread of $D$ over $E_{\min}$ is $\le2\times10^{-15}$ at every point tested, with $\lambda_{\min}$ multiplicities of $9,16,25,36$ at the balanced products, $12,24,40,60$ at the tori and $20$ at $\mathrm{ad}(\mathfrak{su}(3))$.

This also patches a small gap in [bounds.md](../findings/bounds.md)'s reduction on the subalgebra family: $D(v)=0$ for a single $v\in\mathfrak m$ gives only $v\perp[\mathfrak m,\mathfrak m]$, and the step to $[\mathfrak m,\mathfrak m]\perp\mathfrak m$ needs the constancy. The constancy is true, so the step is sound; it should be cited rather than assumed.

---

## L3, the saturation set: CONFIRMED, reproduced independently, and strengthened

### Reproduction

Every reported number came back from my own code, to nine decimals:

| point | criticality residual | slack | mass off $E_{\min}\times E_{\max}$ |
|---|---|---|---|
| $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$, $n=6,8,10,12$ | $\le6.1\times10^{-16}$ | $0.000000000$ | $0$ of $72,192,400,720$ |
| maximal torus, $n=6,8,10,12$ | $\le1.4\times10^{-16}$ | $1.290994449$, $2.160246899$, $2.846049894$, $3.425395354$ | fractions $\tfrac12,\tfrac23,\tfrac34,\tfrac45=\tfrac{m-2}{m-1}$ |
| $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$ | $2.8\times10^{-16}$ | $0.836660027$ | $80$ of $240$ |
| $S^3\times S^5$, $S^5\times S^7$ | $\le5\times10^{-16}$ | $1.115546702$, $0.614119579$ | $8$ of $12$, $12$ of $20$ |
| $\mathbb{CP}^3$ | $8.7\times10^{-16}$ | $2.108185107$ | $5.333333$ of $8$ |

The both-indices-in-$\mathfrak h$ argument is right, $c_{vab}=\langle v,[\varphi_a,\varphi_b]\rangle$ by total antisymmetry of $\langle[x,y],z\rangle$, so $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h\perp\mathfrak m\ni v$ kills it, and the third condition $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$ is automatic because $\mathrm{ad}(\mathfrak h)$ is skew and preserves $\mathfrak h$. The reduction to $(\mathfrak{so}(n),\mathfrak h)$ symmetric is complete on the family.

### Strengthening 1, the structure of saturation, with no two-eigenvalue hypothesis

Write $\mathfrak{so}(n)=E_{\min}\oplus E_{\max}\oplus E_{\mathrm{mid}}$. Then $D=0$ at a critical point is **equivalent** to

$$[E_{\min},E_{\mathrm{mid}}]=0,\qquad [E_{\min},E_{\min}]\subseteq E_{\max},\qquad [E_{\min},E_{\max}]\subseteq E_{\min},$$

which specialises to the record's condition when $E_{\mathrm{mid}}=0$. Two corollaries the record does not have. By Jacobi, $\mathfrak k:=E_{\min}\oplus[E_{\min},E_{\min}]$ is a subalgebra and $(\mathfrak k,[E_{\min},E_{\min}])$ is a symmetric pair. And $E_{\mathrm{mid}}$ centralises $\mathfrak k$, so by Schur $\dim E_{\mathrm{mid}}\le3$ whenever $\mathfrak k$ acts irreducibly on $\mathbb R^n$, $0$, $1$ or $3$ according as the commutant is $\mathbb R$, $\mathbb C$ or $\mathbb H$. That is the shape T4 needs.

### Strengthening 2, saturation implies equality in the *closed* $\Pi$-bound

Feeding the per-row identity $\sum_a\lambda_am_a=2\lvert\lambda_{\min}\rvert$ into $D=0$ (all mass on $E_{\min}\times E_{\max}$, so $\sum_a\lambda_am_a=(n-2)(\lambda_{\min}+\lambda_{\max})$) gives

$$D=0\iff\Big[\ \theta=(n-1)\lvert\lambda_{\min}\rvert\ \text{ and }\ \lambda_{\max}=\tfrac{n}{n-2}\lvert\lambda_{\min}\rvert\ \Big].$$

Consequences worth recording. Lemma L70's saturation set is contained in the $\Pi$-bound's, strictly, the extra condition being **purely spectral**. And since $\theta=(n-1)\lvert\lambda_{\min}\rvert$ holds at every padding-free catalogued point ([post F40](../findings/fence-posts.md)), on that catalogue $D/\lvert\lambda_{\min}\rvert=(n-2)\lambda_{\max}-n\lvert\lambda_{\min}\rvert$ exactly, a function of two eigenvalues. So the separation of the balanced products from the maximal tori, which [routes.md](../routes.md) calls the first recorded quantity to achieve it, is on that population the failure of the ratio $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$: $4.000$ against $1.500$ at the $n=6$ torus, $1.500$ at the balanced product. The separation is real; its mechanism is spectral rather than Lie-theoretic, and the record should say so.

### Strengthening 3, T4 is CLOSED in the diagonal half

Let $W$ be diagonal in $\{L_{ij}\}$, so its eigenvalues are the edge weights $M_{ij}$ of $K_n$ with all row sums zero, and let $G_{\min},G_{\mathrm{mid}},G_{\max}$ partition the edges. Since $[L_{ij},L_{ik}]=\pm L_{jk}$ and disjoint planes commute, the three conditions above read: (i) every mid edge is disjoint from every min edge; (ii) $ij,ik\in G_{\min}\Rightarrow jk\in G_{\max}$, so $G_{\min}$ is triangle-free; (iii) $ij\in G_{\min}$, $ik\in G_{\max}\Rightarrow jk\in G_{\min}$.

- Any vertex $k$ off the support of $G_{\min}$ contradicts (i) and (iii) at once, the edge $ik$ from a $G_{\min}$-covered vertex $i$ can lie in no class. So $G_{\min}$ spans, and by (i) $G_{\mathrm{mid}}=\emptyset$: **saturation forces exactly two eigenvalues**, it is not a hypothesis.
- With $B=N(i)$ and $A$ its complement, (ii) and (iii) give $N(j)=A$ for every $j\in B$, so $G_{\min}=K_{p,q}$ is **complete bipartite**, the sphere-product pattern.
- Row sums zero give $(p-1)\lambda_{\max}+q\lambda_{\min}=0$ and $(q-1)\lambda_{\max}+p\lambda_{\min}=0$, whose difference forces $p=q$.

**A diagonal critical point saturating Lemma L70 is the balanced sphere product**, with Lemma L23's two-eigenvalue hypothesis dropped rather than assumed. That is T4 for the diagonal half.

### The hunt outside the family

$1{,}020$ critical points, none saturating except the balanced products, and no negative slack anywhere:

| population | count | criticality residual | min slack |
|---|---|---|---|
| generic $n=6$, full $\mathcal W_6$ Newton from random starts | $216$ | $\le1\times10^{-11}$ | $0.724771497$ |
| diagonal, $n=8$ | $400$ | $\le1\times10^{-14}$ | $0.816496581$ |
| diagonal, $n=10$ | $250$ | $\le1\times10^{-14}$ | $0.894427163$ |
| diagonal, $n=12$ | $140$ | $\le1\times10^{-14}$ | $1.369967144$ |

The generic $n=6$ points have $\lambda_{\min}$ of multiplicity $1$ and up to $15$ distinct eigenvalues; the diagonal populations reach $66$ distinct eigenvalues and carry kernels of dimension $9$ and $11$. Named points, all critical to $\le3\times10^{-15}$ and all strictly slack: the $n=8$ non-diagonal witness at $\theta=1.088948053$ (slack $2.047327151$, $\lambda_{\min}$ simple), the frontier points at $\theta=1.224744871$ for $n=6,8,12$ (slack $1.632993$, $3.265986$, $6.531973$, kernels $12/25/63$), $\mathbb{CP}^{3,4,5}$ (slack $2.108185$, $3.944053$, $5.692100$), and padded points, padded $S^3\times S^3$ into $n=8$ and $n=10$ (slack $0.632456$, $1.264911$) and padded $\mathbb{CP}^3$ (slack $3.794733$, $5.481281$). Padding breaks saturation for exactly the reason the structure theorem predicts: the mixed planes join $E_{\mathrm{mid}}$ and fail to commute with $E_{\min}$.

Six further members of the subalgebra family, built and tested independently. $\mathfrak u(m)\subset\mathfrak{so}(2m)$ at $m=3,4,5,6$ and the unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ are **not critical**, residuals $4.6\times10^{-1},3.4\times10^{-1},2.7\times10^{-1},2.3\times10^{-1}$ and $1.1\times10^{-1}$ down to $4.8\times10^{-2}$, matching the record's $5\times10^{-1}$ to $5\times10^{-2}$, and at exactly those points the bound reads **negative slack** ($-0.109307$ at $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, $-0.046410$ at $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$), which is the sharpest available demonstration that criticality is load-bearing and that a non-critical point must never be read as a violation. The multi-block members **are** critical and strictly slack: $\mathfrak{so}(3)^{\oplus4}\subset\mathfrak{so}(12)$ at $\theta=0.638284739$, residual $1.3\times10^{-16}$, slack $1.914854216$; $\mathfrak{so}(4)^{\oplus3}\subset\mathfrak{so}(12)$ at $\theta=0.829156198$, slack $1.105541597$; $\mathfrak{so}(3)^{\oplus3}\subset\mathfrak{so}(9)$ at $\theta=0.769800359$, slack $1.154700538$.

**Verdict: CONFIRMED as stated. The general T4 (non-diagonal, three or more eigenvalues), stays UNDECIDED**, now reduced to: $E_{\mathrm{mid}}$ centralises the symmetric-pair subalgebra generated by $E_{\min}$, with $\dim E_{\mathrm{mid}}\le3$ under irreducibility, and $\lambda_{\max}=\frac n{n-2}\lvert\lambda_{\min}\rvert$.

---

## L5, the Hilbert–Schmidt form: CONFIRMED, and it adds nothing

**The first identity is pure trace algebra.** For $A$ antisymmetric and $W$ symmetric, $[A,W]$ is symmetric and $\lVert[A,W]\rVert^2=2\mathop{\mathrm{tr}}(AWAW)-2\mathop{\mathrm{tr}}(A^2W^2)$, so $\langle v,W^\#v\rangle=-\tfrac12\mathop{\mathrm{tr}}(AWAW)=-\tfrac14\lVert[A,W]\rVert^2-\tfrac12\mathop{\mathrm{tr}}(A^2W^2)$. **No criticality, no unit norm, no Weyl membership**, verified to $6\times10^{-17}$ at $n=6,8$ on random Weyl *and* random non-Weyl symmetric operators, critical and not. Since $\mathop{\mathrm{tr}}(A^2W^2)=-\lVert AW\rVert^2$, the second form $-\tfrac14g_v+\tfrac12\lVert\mathrm{ad}(v)W\rVert^2$ is the same statement, and dividing the critical-point relation by $\lambda_{\min}<0$ gives the claimed $\theta=\lambda_{\min}+\frac{g_v}{4\lvert\lambda_{\min}\rvert}-\frac{\lVert\mathrm{ad}(v)W\rVert^2}{2\lvert\lambda_{\min}\rvert}$ exactly.

**$g_v$ is the record's $g$.** In the eigenbasis $[A,W]_{\alpha\beta}=A_{\alpha\beta}(\lambda_\beta-\lambda_\alpha)$, so $g_v=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2c_{v\alpha\beta}^2$, confirmed to $2.4\times10^{-15}$. It is the [Petersen–Wink](../references/petersen-wink-2021-tachibana-special-holonomy/notes.md) quantity and the record's $\Delta$-companion.

**Is it new information?** Against the two aggregates, yes: $\sum_\gamma g_\gamma=4(n-1)$ and $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ (both reproduced, and both holding at non-critical $W$ as well) are sums of the per-$v$ statement, so the per-$v$ form is strictly stronger than them. **Against L1, no, it is L1.** Writing $\lVert\mathrm{ad}(v)W\rVert^2=\tfrac12\sum c_{v\alpha\beta}^2(\lambda_\alpha^2+\lambda_\beta^2)$,

$$-\tfrac14g_v+\tfrac12\lVert\mathrm{ad}(v)W\rVert^2=\tfrac14\sum c^2\big[\lambda_\alpha^2+\lambda_\beta^2-(\lambda_\alpha-\lambda_\beta)^2\big]=\tfrac12\sum c^2\lambda_\alpha\lambda_\beta,$$

which is L1's ingredient verbatim. The two forms are related by $2ab=a^2+b^2-(a-b)^2$, a change of variables on the same masses and the same spectrum, with the same marginals. **It therefore cannot move L4**: the LP of section L4.2 is stated in the same variables, so its closed form and its $2.30\times\theta_0(12)$ ceiling apply to the $g$-form unchanged. Recording it as a second, independent derivation would be an error; it is the same identity reached by a different route (the adjoint-orbit expansion instead of the eigenbasis), and that is worth saying explicitly in [bounds.md](../findings/bounds.md).

---

## What I would change on the record

- **Close R14 and downgrade T3.** State the elimination $D=\lvert\lambda_{\min}\rvert(\lambda_{\min}+(n-2)\lambda_{\max}-\theta)$ in [bounds.md](../findings/bounds.md) immediately after the identity, so no successor reads the deficiency statement as a reduction. Record the closed-form LP ceiling ($2.000\times\theta_0$ at $n=8$, $2.298\times$ at $n=12$) as a fence post: it kills every lower bound on $D$ built from spectrum, total mass, row cap and the per-row identity.
- **Add the missing hypothesis** $\mathop{\mathrm{tr}}W=0$ (equivalently $\lambda_{\max}\ge0$) to Lemma L70's statement, and delete the unit-norm and Weyl-membership hypotheses, which it does not use.
- **Record that $D$ is constant on $E_{\min}$.** It is stronger than the eigenspace-constancy check the record currently claims, and the subalgebra-family reduction quietly needs it.
- **Record the three-condition structure theorem and the diagonal T4 proof.** T4's diagonal half is closed by the graph argument above.
- **Rephrase the separation claim.** On the population where $\theta=(n-1)\lvert\lambda_{\min}\rvert$, Lemma L70's slack is the spectral quantity $(n-2)\lambda_{\max}-n\lvert\lambda_{\min}\rvert$; saturation is $\Pi$-saturation plus $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$.
