### Reviewer 315: the graded-slice reduction, the equivariant point's maximality on the slice, and the uniqueness premise

Every number below comes from a build written this cycle from the definitions alone ([core.py](../scripts/reviewers/r315/core.py), [geom.py](../scripts/reviewers/r315/geom.py), [slice8.py](../scripts/reviewers/r315/slice8.py), [lop.py](../scripts/reviewers/r315/lop.py)), no repository script is imported anywhere in the chain, and no repository prose was taken as input to a computation. Calibration before use: the sharp is fixed by $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, reproduced exactly at $n=5,6,8$; the trilinear form $\langle A\#B,C\rangle$ is verified fully symmetric to $10^{-13}$; $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ comes out $84,300,770,1638$ at $n=6,8,10,12$; $Q$ maps $\mathcal W_n$ into itself at relative residual $7\times10^{-16}$; and the equivariant $\theta$ values $1.115546702$, $1.145643924$ at $n=8$ and $1.201561484$, $1.228239158$, $1.236033081$ at $n=12$ come out matching the record to nine digits from a chain that never read them.

**Verdicts.**

| | claim | verdict |
|---|---|---|
| **I1** | the reduction: $V$ linear, $\dim V=155$, and failure-on-slice $\Rightarrow$ failure-in-full | **CONFIRMED**, $V$ is linear trivially, $155$ reproduced two independent ways, the implication is valid and is the trivial direction; three scope facts the record does not state are added below |
| **I2** | the equivariant point is a local maximum on $S(V)$ | **CONFIRMED as a statement, its stated inference REFUTED**, "inherits the $\le\frac12$ bound, hence a local maximum modulo its orbit" is a non-sequitur; the true reason is stronger and makes the point a *strict, nondegenerate, orbit-free* local maximum on $S(V)$ |
| **I3** | uniqueness, the equivariant point is the only local maximum on $S(V)$ | **REFUTED**, with certified witnesses at $n=8$ **and at $n=12$**. The route is dead, and it is dead by the plan's own [Lemma L69](../findings/graded-half.md) |

---

## I1, the reduction

### $V$ is linear, and $155$ is right

$V$ is the fixed-point set of $W\mapsto JWJ$ with $J=\Lambda^2\mathrm{diag}(I_p,-I_q)$. That map is a linear involution of the linear space $\mathcal W_n$ (it is conjugation by an element of $O(n)$, which preserves $\mathcal W_n$), so its fixed set is a linear subspace. Measured: the conjugation's spectrum on $\mathcal W_8$ is exactly $\{\pm1\}$, nothing else.

Dimensions, by eigenvalue count on my own $\mathcal W_n$ basis:

| $n$ | split | $\dim\mathcal W_n$ | $\dim V$ |
|---|---|---|---|
| $8$ | $(3,5)$ | $300$ | $\mathbf{155}$ |
| $8$ | $(4,4)$ | $300$ | $156$ |
| $8$ | $(2,6)$ | $300$ | $160$ |
| $10$ | $(5,5)$ | $770$ | $395$ |
| $12$ | $(6,6)$ | $1638$ | $834$ |

$155$ is confirmed a second way, by characters and with no linear algebra at all. With $\sigma=\mathrm{diag}(I_3,-I_5)$ and $\mathrm{Sym}^2(\Lambda^2)=\mathcal W\oplus\Lambda^4\oplus\mathrm{Sym}^2\mathbb R^n$,

$$\operatorname{tr}_{\mathcal W}(\sigma)=\tfrac12\big(\chi_{\Lambda^2}(\sigma)^2+\chi_{\Lambda^2}(\sigma^2)\big)-\chi_{\Lambda^4}(\sigma)-\tfrac12\big(\chi(\sigma)^2+\chi(\sigma^2)\big)=16-0-6=10,$$

and $\dim V=\tfrac12(300+10)=155$. The same computation gives $12$ and $156$ at $(4,4)$, and $30$ and $834$ at $(6,6)$, $n=12$, all matching the measured values.

### The implication is valid, and it is the trivial direction

$S(V)\subset S(\mathcal W_n)$, so any nearby point of $S(V)$ with a larger $P$ is a nearby point of $S(\mathcal W_n)$ with a larger $P$. Nothing else is used. Stated precisely, what the reduction does and does not give:

- **It gives:** $W\in V$ not a local maximum of $P|_{S(V)}$ $\Rightarrow$ $W$ not a local maximum of $P|_{S(\mathcal W_n)}$ $\Rightarrow$ $W$ is not a maximiser. Correct, and it does indeed avoid any $\lambda_{\max}(L_e)>\tfrac12$ estimate.
- **It does not give:** the converse. A point can be a local maximum on $S(V)$ and a saddle in the full space, and the reduction says nothing about such a point.

The brief asks whether that asymmetry breaks the argument's direction. It does not break the *implication*; it makes the *premise* strictly harder. The set of local maxima of $P|_{S(V)}$ contains the set of local maxima of $P|_{S(\mathcal W_n)}$ that lie in $V$, and is generally larger. So "the equivariant point is the only local maximum on $S(V)$" is a **stronger** hypothesis than "the equivariant point is the only local maximum in $V$ of $P$ on the full sphere", and it is the stronger one the reduction needs. That is precisely where the route dies (I3).

### Three facts about $V$ the record does not state

1. **Symmetric criticality is exact here, in both directions.** $Q$ commutes with the $O(n)$ action, and conjugation by $J$ is one, so $Q(V)\subseteq V$, measured at relative residual $2\times10^{-15}$ on random $W\in V$. Hence $\nabla P=3Q(W)$ is tangent to $V$, and **every critical point of $P|_{S(V)}$ is a critical point of $P$ on the full sphere**. Checked: a random slice-ascent limit has full-space residual $\lVert Q(W)-\theta W\rVert=9.2\times10^{-15}$. This is stronger than the record's one-directional "the equivariant point is critical there, by symmetric criticality", and it is what makes the slice landscape a genuine sub-landscape of critical points rather than an artefact.

2. **$V$ is far larger than "the graded points of the pair".** $J$ is diagonal in the $e_i\wedge e_j$ basis, so *every* operator diagonal in that basis lies in $V$. In particular $V$ contains the Weyl tensor of **every** coordinate sphere product $S^a\times S^{n-a}$, for every split of the $n$ coordinates, not just the slice's own $(p,q)$, measured distance to the $(6,6)$ slice at $n=12$: $3.4\times10^{-15}$, $3.6\times10^{-15}$, $3.7\times10^{-15}$, $3.7\times10^{-15}$ for $a=6,5,4,3$. It also contains paddings of lower-dimensional Weyl tensors into $J$-invariant coordinate subspaces, padded $W_{\mathbb{CP}^2}$ on coordinates $\{4,5,6,7\}$ sits in the $n=8$ $(3,5)$ slice at $1.5\times10^{-15}$ (while the same tensor on coordinates $\{0,1,2,3\}$ sits at distance $0.71$, so the membership is a real condition and the test is not vacuous). **This is the mechanism that kills I3**, and it is visible before any computation.

3. **The reduction is a per-grading statement.** The record's own r313/r314 finding is that a critical point carries several inequivalent gradings. A graded point is eliminated only if it fails to be a local maximum on the slice of *some* grading it possesses; the choice of grading is part of the claim and is not currently named in it.

---

## I2, the equivariant point on the slice

### The eigenvalue statement, verified on my own build at three splits with $p,q\ge5$

Full space, $L_e=L_W/\theta$ restricted to $W^\perp$:

| $n$ | split | $\theta$ | $\lambda_{\max}(L_e|_{W^\perp})$ | $\dim(\lambda=\tfrac12)$ | orbit tangent | eigenspace $=$ orbit? | next eigenvalue | gap | $\tfrac1{2(M-1)}$ |
|---|---|---|---|---|---|---|---|---|---|
| $10$ | $(5,5)$ | $1.200000000$ | $0.500000000$ | $25$ | $25$ | yes, both ways to $10^{-12}$ | $0.375000000$ | $0.125$ | $0.125$ |
| $12$ | $(5,7)$ | $1.228239158$ | $0.500000000$ | $35$ | $35$ | yes, both ways to $10^{-12}$ | $0.416666667$ | $0.0833333$ | $0.0833333$ |
| $12$ | $(6,6)$ | $1.236033081$ | $0.500000000$ | $36$ | $36$ | yes, both ways to $10^{-12}$ | $0.400000000$ | $0.100$ | $0.100$ |

Nothing exceeds $\tfrac12$; the $\tfrac12$-eigenspace has dimension exactly $pq=\dim\mathfrak m$ and coincides with the orbit tangent as a subspace (mutual containment ratios $1.000000000000$, not merely equal dimensions); the gap to the next eigenvalue is exactly $\tfrac1{2(M-1)}$, $M=\max(p,q)$, confirming the record's corrected margin. The eigenvalue statement of Lemma L69 is **CONFIRMED**.

### The inference the record draws from it is a non-sequitur, and the repair is available and stronger

The record's sentence is: $\lambda_{\max}=\tfrac12$ attained exactly on the orbit tangent over the full space, *"so the restriction to $V$ inherits the bound, and the point is a local maximum there modulo its orbit."*

Inheriting $\lambda_{\max}\le\tfrac12$ is a **necessary** condition (Lemma L24's direction) and never by itself implies a local maximum: a direction with $\lambda=\tfrac12$ exactly leaves the second variation zero, and whether $P$ rises there is decided at third order. The record's own [Observation L9](../findings/graded-half.md) supplies the cautionary example, the $m=3$ Ricci-flat Kähler member has negative semidefinite second variation and *rises cubically* along its flat directions. So the converse needs one of: strictness off a group orbit, Morse–Bott nondegeneracy with the degenerate directions exactly tangent to an orbit along which $P$ is constant, or a third-order sign.

**The needed input is available, and it is better than the record claims: the orbit tangent is orthogonal to $V$, so on the slice there is no degeneracy at all.** For $X\in\mathfrak k$, $[\mathrm{ad}X,W]=0$ by equivariance. For $X\in\mathfrak m$, $\mathrm{ad}X$ anticommutes with the grading involution, hence $J[\mathrm{ad}X,W]J=-[\mathrm{ad}X,W]$ and the direction lies in the $(-1)$-eigenspace, i.e. in $V^\perp$. Measured, the dimension of the orbit tangent inside the slice is $0$ at $(3,5)$ and $(4,4)$ at $n=8$, $(5,5)$ at $n=10$, and $(6,6)$ at $n=12$, and the slice spectrum has nothing at $\tfrac12$:

| $n$ | split | $\theta$ | $\lambda_{\max}(L_e|_{V\cap W^\perp})$ | $\dim(\lambda=\tfrac12)$ in $V$ | orbit tangent in $V$ |
|---|---|---|---|---|---|
| $8$ | $(3,5)$ | $1.115546702$ | $0.375000000$ | $0$ | $0$ |
| $8$ | $(4,4)$ | $1.145643924$ | $0.333333333$ | $0$ | $0$ |
| $10$ | $(5,5)$ | $1.200000000$ | $0.375000000$ | $0$ | $0$ |
| $12$ | $(6,6)$ | $1.236033081$ | $0.400000000$ | $0$ | $0$ |

So the equivariant point is a **strict, isolated, nondegenerate local maximum of $P|_{S(V)}$**, not "a local maximum modulo its orbit". No third-order condition is needed, and none is owed. **The claim's conclusion stands; the reason recorded for it does not, and the correct reason should replace it**, because the recorded reason would license the same step at points where it is false.

---

## I3, uniqueness: REFUTED

### The commutant, recomputed

The $\mathrm{ad}(\mathfrak k)$-commutant inside $\mathcal W_n$ is one-dimensional at every pair I tested, $(3,5)$, $(4,4)$, $(2,6)$ at $n=8$ against $\dim\mathcal W_8=300$, and $(5,5)$ at $n=10$ against $770$ (the brief asked for two pairs; four are reported). Normalising the single direction and evaluating gives $Q(W)=\theta W$ at residuals $1.0\times10^{-15}$, $1.5\times10^{-15}$, $2.7\times10^{-15}$, $1.8\times10^{-15}$ with $\theta=1.115546702$, $1.145643924$, $0.986013297$, $1.200000000$. **CONFIRMED**, and with it the record's reading that the equivariant point is the unique *invariant* point on the slice.

### The refutation, at $n=12$, from the plan's own Lemma L69

The premise is false for every even $n\ge12$, and the proof needs no new machinery:

1. $V$, the $(\tfrac n2,\tfrac n2)$ coordinate slice, contains the Weyl tensor of **every** coordinate sphere product $S^a\times S^{n-a}$ (I1, fact 2, they are diagonal in the $e_i\wedge e_j$ basis, and $J$ is too).
2. [Lemma L69](../findings/graded-half.md) asserts that every $S^p\times S^q$ with $p,q\ge5$ is Morse–Bott nondegenerate with $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ attained exactly on the orbit tangent, that is, **a local maximum of $P$ on the full sphere**.
3. A local maximum on the full sphere is a local maximum on any subsphere through it.
4. For every even $n\ge12$ there are at least two splits with both factors $\ge5$: $(\tfrac n2,\tfrac n2)$ and $(5,n-5)$.

Hence $S(V)$ always carries at least two local-maximum orbits with distinct $\theta$. **Lemma L69, which C3 invokes to supply the equivariant point's maximality, simultaneously destroys the uniqueness it is to be combined with.**

Measured at $n=12$ on the $(6,6)$ slice, $\dim V=834$:

| point | $\theta$ | in the slice | $\lambda_{\max}(L_e|_{V\cap W^\perp})$ | $\dim(\lambda=\tfrac12)$ | $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$-orbit tangent in $V$ | next eigenvalue |
|---|---|---|---|---|---|---|
| $S^6\times S^6$ (equivariant) | $1.236033081$ | $3.4\times10^{-15}$ | $0.400000000$ | $0$ | $0$ | $0.400000000$ |
| $S^5\times S^7$ | $1.228239158$ | $3.6\times10^{-15}$ | $0.500000000$ | $5$ | $5$ | $0.416666667$ |
| padded $W_{\mathbb{CP}^2}$ | $1.224744871=\sqrt{3/2}$ | $3.5\times10^{-15}$ | $0.500000000$ | (|), | nothing above $\tfrac12$ |
| $S^4\times S^8$ | $1.201561484$ | $3.7\times10^{-15}$ | $0.500000000$ | $8$ | $8$ | $0.428571429$ |
| $S^3\times S^9$ | $1.141798451$ | $3.7\times10^{-15}$ | $0.500000000$ | $9$ | $9$ | $0.437500000$ |

For $S^5\times S^7$ the $\tfrac12$-eigenspace and the slice orbit tangent are the **same subspace**, not merely the same dimension: mutual containment $1.000000000000$ both ways. The dimension is predicted exactly, $\dim(\mathfrak{so}(6)\oplus\mathfrak{so}(6))-\dim(\mathfrak{so}(5)\oplus\mathfrak{so}(6))=30-25=5$, and likewise $8$ and $9$ for the $(4,8)$ and $(3,9)$ splits. So each of these is a Morse–Bott nondegenerate local maximum of $P|_{S(V)}$: $P$ is exactly constant along the degenerate directions (they are tangent to a group orbit inside $V$) and strictly decreasing transversally.

**Witness, stated plainly.** At $n=12$, on the $(6,6)$ graded slice, $W_{S^5\times S^7}$ is a local maximum of $P|_{S(V)}$ with $\theta=1.228239158\neq1.236033081$. It is *above* $\sqrt{3/2}$, so it is inside Lemma L69's own range. The uniqueness premise is false.

### Independent confirmation by ascent, and the size of the basins

Riemannian gradient ascent with backtracking, from random starts on $S(V)$, converging to $\lVert\nabla_{\!S}P\rVert<10^{-11}$:

| slice | starts | $\theta$ values of the limits, with counts |
|---|---|---|
| $n=12$, $(6,6)$, $\dim V=834$ | $60$ | $1.236033$ (**19**, equivariant) · $1.228239$ (15) · $1.224745$ (**24**) · $1.201561$ (1) · $1.115547$ (1) |
| $n=8$, $(3,5)$, $\dim V=155$ | $400$ | $1.0825318$ (6) · $1.0954451$ (1) · $1.1155467$ (**9**, equivariant) · $1.1456439$ (37) · $1.2247449$ (**346**) |
| $n=8$, $(4,4)$, $\dim V=156$ | $400$ | $1.0825318$ (1) · $1.1155467$ (15) · $1.1456439$ (**28**, equivariant) · $1.2247449$ (**355**) |

Five distinct limit values on each of the $n=12$ $(6,6)$ and $n=8$ $(3,5)$ slices. Gradient flow converges to a strict saddle only from a measure-zero set, so a value reached from a positive fraction of random starts is a local maximum; the certifications above make that independent of the flow argument for the named points. **The equivariant point does not even have the largest basin**, at $n=12$ it takes $19/60$ against padded $W_{\mathbb{CP}^2}$'s $24/60$, and at $n=8$ on $(3,5)$ it takes $9/400$ against $346/400$.

Certified on the $n=8$ $(3,5)$ slice by the same Morse–Bott test (eigenspace $=$ orbit tangent, both containments $1.0000000000$):

| point | $\theta$ | $\lambda_{\max}$ on slice | $\dim(\lambda=\tfrac12)=$ orbit tangent | next |
|---|---|---|---|---|
| $S^3\times S^5$ (equivariant) | $1.115546702$ | $0.375000000$ | $0$ | $0.375$ |
| $S^4\times S^4$ | $1.145643924$ | $0.500000000$ | $4$ | $0.333333$ |
| padded $W_{\mathbb{CP}^2}$ | $1.224744871$ | $0.500000000$ | $6$ | $0.333333$ |
| $S^2\times S^6$ | $0.986013297$ | $0.600000000$ | $2$ (and **$10$ directions above $\tfrac12$**) |, |

$S^2\times S^6$ is the control: the same machinery reports it as *not* a local maximum, so the test discriminates.

At $n=8$ the equivariant point is not even the **global** maximum on its own slice, padded $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$ beats it by $9.8\%$. At $n=12$ the value ordering is restored ($1.236033>1.224745$), which is exactly the $n\ge12$ threshold at work, but uniqueness is not.

### What the claim would have bought, and what survives

Had uniqueness held, the chain would have been sound: uniqueness $\Rightarrow$ every non-equivariant graded critical point fails to be a local maximum on $S(V)$ $\Rightarrow$ (I1) fails to be a local maximum outright $\Rightarrow$ not a maximiser; with Lemma L69 on the equivariant side, the graded half closes. The logic is fine. The premise is false at the dimension the conjecture is about.

**A weaker successor is not obviously dead**, and it is what the data actually supports:

> Every local maximum of $P|_{S(V)}$ is $\mathrm{ad}(\mathfrak p)$-equivariant for some grading it carries.

Each surviving rival above (the other coordinate sphere products, padded $W_{\mathbb{CP}^2}$), is a symmetric-space Weyl tensor and therefore equivariant *for its own pair*, just not for the slice's. That version still closes the graded half through Lemma L69 plus the classification, and it never asks for uniqueness. **It needs its own audit before being adopted**, because of the next item.

### One loose end the brief did not ask about

Six of the $400$ ascents on the $n=8$ $(3,5)$ slice, and one of the $400$ on $(4,4)$, converge to $\theta=1.0825318=\tfrac{5\sqrt3}8$, a value not on this record. Its $W$ has spectrum $\{\tfrac{\sqrt3}4^{\times3},\ \tfrac{\sqrt3}{12}^{\times3},\ -\tfrac{\sqrt3}8^{\times8},\ 0^{\times14}\}$: support of dimension $14$ inside $\Lambda^2\mathbb R^8$, split $3+3+8$. Those are the dimensions of $\mathfrak g_2$ and of its $\mathfrak{su}(3)$-decomposition $8\oplus3\oplus\bar3$, which is **not** a symmetric-pair grading. A further ascent limit at $\theta=1.0954451=\sqrt{6/5}$ is the padded $S^3\times S^4$: with $f(m)=m/(8(m-1))$, $f(3)+f(4)-\tfrac7{48}=\tfrac5{24}$ and $\theta=1/(2\sqrt{5/24})=1.0954451$ exactly. I did not identify the $\tfrac{5\sqrt3}8$ point and make no claim about it; both sit well below the equivariant value at $n=8$ and threaten no maximiser. **What they are worth is as the first test of the weaker successor above**: if the $\tfrac{5\sqrt3}8$ point is a local maximum on the slice and carries no grading for which it is equivariant, the successor falls too, and it falls cheaply. That check costs one run.

---

**Logging.** [agent_logs/r315-c3-reduction.log](../agent_logs/r315-c3-reduction.log). **Scripts.** [scripts/reviewers/r315/](../scripts/reviewers/r315/), [core.py](../scripts/reviewers/r315/core.py) (algebra, $\mathcal W_n$, $Q$, $L_W$), [geom.py](../scripts/reviewers/r315/geom.py) (slices, commutants), [lop.py](../scripts/reviewers/r315/lop.py) (spectra), [slice8.py](../scripts/reviewers/r315/slice8.py) (slice trilinear tensor and ascent), [certify8.py](../scripts/reviewers/r315/certify8.py), [run_n2.py](../scripts/reviewers/r315/run_n2.py), [run_n2b.py](../scripts/reviewers/r315/run_n2b.py), [run_n3.py](../scripts/reviewers/r315/run_n3.py), [run_n12.py](../scripts/reviewers/r315/run_n12.py), [run_n12b.py](../scripts/reviewers/r315/run_n12b.py).
