# Review r322, the walk identity, the block truncation, and whether the count closes

Gate 2, adversarial. Everything below is computed from an implementation written from the definitions in the brief, [core.py](../scripts/reviewers/r322/core.py), [points.py](../scripts/reviewers/r322/points.py), [walk.py](../scripts/reviewers/r322/walk.py), [diagcrit.py](../scripts/reviewers/r322/diagcrit.py), [relax.py](../scripts/reviewers/r322/relax.py), with no import of repository code and no figure transcribed from prose. Calibration before anything else: the build returns $\theta=1.054092553$, $1.145643924$, $1.200000000$, $1.236033081$ at $S^3\times S^3$, $S^4\times S^4$, $S^5\times S^5$, $S^6\times S^6$, i.e. $\theta_0(6),\theta_0(8),\theta_0(10),\theta_0(12)$ to every recorded digit, and $\theta=1.088948053$ at the $n=8$ witness and $0.670820393=3/\sqrt{20}$ at an independently reconstructed $C_5$ blow-up.

| claim | verdict |
|---|---|
| **U1** walk identity, mass $2(n-2)$, $\lambda_{\min}(\theta-\lambda_{\min})$, sign of $\#$ | **CONFIRMED**, and all three are stronger than recorded |
| **U2** the two biconditionals; signs of the surviving sums | **REFUTED**, one $n=8$ critical point kills both "only if" halves and the "strictly positive" |
| **U3** can the count be completed; does post F10 bite | **REFUTED as posed**, the truncation is *inert*, and post F10 is not the binding obstruction |

---

## U1, the walk identity. CONFIRMED.

### Sign of $\#$

Settled independently of the record. Hamilton's $\#$ preserves the cone of nonnegative curvature operators, so the convention is fixed by the test "$W\succeq0\Rightarrow W^\#\succeq0$". With $\mathrm{sharp}(n,W)_{ab}=-\tfrac12\operatorname{tr}(A_aWA_bW)$ and $A_a=\mathrm{ad}(\varphi_a)$, random positive definite $W$ at $n=4,5,6,7$ give $\lambda_{\min}(W^\#)/\lVert W^\#\rVert$ equal to $+0.0035$, $+0.087$, $+0.087$, $+0.127$, positive at every trial. **The stated sign is right**, and the calibration above (four values of $\theta_0$ reproduced exactly) fixes the scale as well, so no factor is loose.

Structure constants $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ come out totally antisymmetric to $0.0$ (exact), and $\dim\mathcal W_n$ matches $n(n+1)(n+2)(n-3)/12$ at $n=4,5,6$.

### The identity

Diagonalising $W\varphi_a=\lambda_a\varphi_a$ and using $(A_a)_{bc}=c_{acb}$ with $A_a$ skew,
$$\operatorname{tr}(A_1WA_1W)=\sum_{a,b}\lambda_a\lambda_b(A_1)_{ab}(A_1)_{ba}=-\sum_{a,b}\lambda_a\lambda_bc_{1ab}^2 ,$$
so $\langle v,W^\#v\rangle=\tfrac12\sum\lambda_a\lambda_bc_{1ab}^2$ **identically**, for every $W$ and every eigenvector, critical or not. It is a rearrangement of the definition, not a fact about Weyl operators. Measured residual $<10^{-16}$ at all six points below.

### The mass is exact and universal, and the record understates it

$\sum_{a,b}c_{1ab}^2=\sum_a\lVert[v,\varphi_a]\rVert^2=-\operatorname{tr}(\mathrm{ad}_v^2)$, and the Killing form of $\mathfrak{so}(n)$ is $\operatorname{tr}(\mathrm{ad}_X\mathrm{ad}_Y)=(n-2)\operatorname{tr}(XY)=-2(n-2)\langle X,Y\rangle$. Hence

$$\sum_{a,b}c_{1ab}^2=2(n-2)\lVert v\rVert^2 ,$$

for **any** unit $v\in\mathfrak{so}(n)$, no eigenvector hypothesis, no $W$, no critical point. Verified for random unit $v$ at $n=4,5,6,7$: $4.000000$, $6.000000$, $8.000000$, $10.000000$. The record's "$2(n-2)$ at every one" of four points is therefore not sample evidence but a theorem; it is exact and universal, and calling it "independent of the point" undersells it, since it is independent of $W$ altogether.

### The critical-point form, with a caveat that turns out not to exist

$\langle v,W^\#v\rangle=\lambda_{\min}(\theta-\lambda_{\min})$ needs $Q(W)=\theta W$ *exactly*, not after projection to $\mathcal W_n$, because $vv^{\mathsf T}\notin\mathcal W_n$. That is a real gap in principle and it closes: **$Q$ maps $\mathcal W_n$ into $\mathcal W_n$.** For random $W\in\mathcal W_n$ at $n=5,6,7$ the Bianchi defect of $Q(W)$ is $\le5.6\times10^{-17}$, $\mathrm{Ric}(Q(W))\le1.7\times10^{-16}$, and $\lVert Q-P_{\mathcal W}Q\rVert/\lVert Q\rVert\le5.7\times10^{-16}$. So the criticality equation carries no projection and the entrywise identity is legitimate.

Free by-product, checked at $n=5,6,7,8$ and not in the record here: **$\operatorname{tr}(W^\#)=-\operatorname{tr}(W^2)$ identically on $\mathcal W_n$** (measured $-1.000000000$ at unit norm, at non-critical points too). Equivalently $\tfrac12\sum_{p,q}\lambda_p\lambda_q\lVert[\varphi_p,\varphi_q]\rVert^2=-1$, a global constraint coupling the spectrum to the bracket two-tensor, available for free to any successor.

### Measurements

| point | $n$ | $\theta$ | $\lambda_{\min}$ | mult | mass | $2(n-2)$ | $\langle v,W^\#v\rangle$ | $\lambda_{\min}(\theta-\lambda_{\min})$ |
|---|---|---|---|---|---|---|---|---|
| $S^3\times S^3$ | 6 | 1.0540926 | $-0.210819$ | 9 | 8.000000 | 8 | $-0.2666667$ | $-0.2666667$ |
| $S^4\times S^4$ | 8 | 1.1456439 | $-0.163663$ | 16 | 12.000000 | 12 | $-0.2142857$ | $-0.2142857$ |
| $S^3\times S^5$ | 8 | 1.1155467 | $-0.159364$ | 15 | 12.000000 | 12 | $-0.2031746$ | $-0.2031746$ |
| $S^5\times S^5$ | 10 | 1.2000000 | $-0.133333$ | 25 | 16.000000 | 16 | $-0.1777778$ | $-0.1777778$ |
| $C_5$ blow-up | 10 | 0.6708204 | $-0.149071$ | 20 | 16.000000 | 16 | $-0.1222222$ | $-0.1222222$ |
| $n=8$ witness | 8 | 1.0889481 | $-0.302413$ | 2 | 12.000000 | 12 | $-0.4207657$ | $-0.4207657$ |

---

## U2, which block vanishes under which hypothesis. REFUTED.

### What the blocks actually characterise

Both weights are strictly positive: on $\mathfrak m\times\mathfrak m$, $\lambda_a\lambda_b>0$; on $\mathfrak p\times\mathfrak p$, $\lambda_a\lambda_b>0$. So each block is a sum of nonnegative terms and vanishes **iff every term does**. With $c_{1ab}=\langle v,[\varphi_a,\varphi_b]\rangle$,

$$\mathfrak m\times\mathfrak m=0\iff v\perp[\mathfrak m,\mathfrak m],\qquad \mathfrak p\times\mathfrak p=0\iff v\perp[\mathfrak p,\mathfrak p].$$

These are conditions **at the single vector $v$**, strictly weaker than $\mathfrak m\perp[\mathfrak m,\mathfrak m]$ ($S_{\mathfrak{mmm}}=0$) and $\mathfrak m\perp[\mathfrak p,\mathfrak p]$ ($S_{\mathfrak{mpp}}=0$). The "if" halves hold and are the halves route R13 uses; the "only if" halves are false.

### The witness, one point kills both

Reproduce with `python3 scripts/reviewers/r322/witness_u2.py` ([witness_u2.py](../scripts/reviewers/r322/witness_u2.py), deterministic from seed 1). A coordinate-diagonal $\mathrm{Weyl}_8$ critical point, $W$ diagonal on the bivector basis with entries $M_{ij}$:

- $\theta=0.296338262037$, $\lVert W\rVert=1$, $\lVert Q(W)-\theta W\rVert=1.0\times10^{-13}$, $\mathrm{Ric}(W)=2.0\times10^{-15}$, Bianchi defect $0$, $\lVert Q-P_{\mathcal W}Q\rVert=7.9\times10^{-16}$;
- $\lambda_{\min}=-0.268906555577$, **multiplicity 1**, $\dim\mathfrak m=19$, $\dim\mathfrak p=9$, **trivial kernel**;
- mass $=12.000000000000=2(n-2)$; $\langle v,W^\#v\rangle=-0.151998036963=\lambda_{\min}(\theta-\lambda_{\min})$;
- **blocks: $\mathfrak m\times\mathfrak m=0$ exactly, $\mathfrak p\times\mathfrak p=0$ exactly, $\mathfrak m\times\mathfrak p=-0.151998036963$;**
- **$S_{\mathfrak{mmm}}=84$, $S_{\mathfrak{mpp}}=24$.**

So the $\mathfrak m\times\mathfrak m$ block vanishes with $S_{\mathfrak{mmm}}=84\ne0$, and the $\mathfrak p\times\mathfrak p$ block vanishes with $S_{\mathfrak{mpp}}=24\ne0$. Both "only if" directions are refuted at one point, with $\lambda_{\min}$ simple so no choice of $v$ is involved.

The zeros are structural, not numerical. On the diagonal locus the eigen-bivectors are the $\varphi_{ij}$ and $[\varphi_{ik},\varphi_{jk}]=-\varphi_{ij}$, so brackets are supported exactly on triangles of $K_n$. Hence

- $S_{\mathfrak{mmm}}=0\iff$ the negative graph is triangle-free (the record's reading, correct);
- $\mathfrak m\times\mathfrak m$ block $=\sum_k M_{ik}M_{jk}$ over $k$ with $(ik),(jk)$ both negative $\iff$ **the $\lambda_{\min}$ edge lies in no negative triangle**;
- $\mathfrak p\times\mathfrak p$ block $\iff$ the $\lambda_{\min}$ edge lies in no triangle with two positive edges.

At the witness the $\lambda_{\min}$ edge is $(2,3)$, weight $-0.268906556$; the negative graph has $19$ edges and **14 triangles**, none through $(2,3)$, and no vertex $k$ has $(2k)$ and $(3k)$ both positive. That is the whole mechanism: **the blocks see a local condition at $v$, the $S$-tensors see a global one.**

### The signs of the surviving sums

| record | verdict |
|---|---|
| $\mathfrak m\times\mathfrak p$ sum strictly negative | **holds whenever $\theta>\lambda_{\min}$, and that is provable rather than measured**, but it can vanish |
| $\mathfrak p\times\mathfrak p$ sum strictly positive | **FALSE**, and contradicted by the record's own next sentence |

Proof of the first: $\lambda_{\min}(\theta-\lambda_{\min})=\mathfrak{mm}+\mathfrak{mp}+\mathfrak{pp}$ with $\mathfrak{mm},\mathfrak{pp}\ge0$, so $\mathfrak{mp}\le\lambda_{\min}(\theta-\lambda_{\min})<0$ as soon as $\theta>\lambda_{\min}$, which is automatic when $\theta>0>\lambda_{\min}$. **It fails outside that range.** Scanning $109$ diagonal critical points at $n=6,7,8$, **nine have $\theta\le\lambda_{\min}$ and every one has $\mathfrak m\times\mathfrak p=0$ exactly**, e.g. $n=6$, $\theta=-0.942809=-2\sqrt2/3$, $\lambda_{\min}=-0.707107=-1/\sqrt2$; and $n=8$, $\theta=-0.612372$, $\lambda_{\min}=-0.408248$. So "strictly negative" needs the hypothesis $\theta>\lambda_{\min}$ attached.

The second is refuted by every point in the U1 table except the blow-up: $\mathfrak p\times\mathfrak p=0$ at all four sphere products and at the $n=8$ witness, and $0$ again at the U2 witness above. The record says so itself two lines later ("on graded points the second sum vanishes too"), so the two sentences contradict each other. The correct statement is $\mathfrak{pp}\ge0$, with equality iff $v\perp[\mathfrak p,\mathfrak p]$.

### The reported $\mathfrak p\times\mathfrak p$ numbers do not reproduce, and cannot both be right

Record: "$1.00$ and $0.347$ at the $C_5$ blow-up and its conjugate". I get $\mathfrak{pp}=0.011111111=1/90$ at **both**, together with $\mathfrak{mm}=0$ and $\mathfrak{mp}=-2/15$, summing to $-11/90=\lambda_{\min}(\theta-\lambda_{\min})$ exactly.

Two independent reasons the recorded pair is wrong. First, a generic $SO(10)$ conjugate is an isometry of everything in sight (spectrum, eigenspaces, brackets) so every block value is invariant; two different numbers for the same point up to conjugation is impossible. Second, the only freedom is the choice of $v$ inside the $20$-dimensional $\lambda_{\min}$ eigenspace (which at this point *is* $\mathfrak m$), and **the block values are constant on it**: eight random unit $v\in\mathfrak m$ give $\mathfrak{mm}=0$, $\mathfrak{mp}=-0.133333333$, $\mathfrak{pp}=0.011111111$ every time, unweighted $\mathfrak p\times\mathfrak p$ mass $=4.000000$ every time. Neither $1.00$ nor $0.347$ nor $0.347/1.00$ appears under any normalisation I tried. **The qualitative claim survives** ($\mathfrak{pp}\ne0$ at the blow-up, $=0$ at the sphere products and the witness), **the two numbers do not.**

*Beware the degeneracy generally*: $\lambda_{\min}$ has multiplicity $9,16,15,25,20$ at the five symmetric points, so "the $\lambda_{\min}$ eigenvector" is not well defined at any of them. It happens to be harmless here because the block values are constant on the eigenspace at each; that is a fact to be checked, not assumed, and the record does not check it.

---

## U3, completing the count. The truncation is INERT; post F10 is not the obstruction.

### Nosal's proof, derived

Triangle-free $G$ with $m$ edges: $\sum_i\lambda_i^2=\operatorname{tr}A^2=2m$ and $\sum_i\lambda_i^3=\operatorname{tr}A^3=6\cdot\#\text{triangles}=0$. With $\lambda=\lambda_1$ largest and $|\lambda_i|\le\lambda$,
$$\lambda^3=-\sum_{i\ge2}\lambda_i^3\le\lambda\sum_{i\ge2}\lambda_i^2=\lambda(2m-\lambda^2)\ \Longrightarrow\ \lambda^2\le m,$$
equality forcing the spectrum $\{\lambda,0^{\times},-\lambda\}$, i.e. complete bipartite. The load-bearing feature: **triangle-freeness enters as the vanishing of a term that would otherwise sit on the *large* side of the inequality.** With $t$ triangles the bound degrades to $\lambda^3\le6t+\lambda(2m-\lambda^2)$. The hypothesis buys something because it removes a *positive* contribution to the quantity being bounded above.

### Why the transfer fails at exactly that step

Here the identity is $\lambda_{\min}(\theta-\lambda_{\min})=\mathfrak{mm}+\mathfrak{mp}+\mathfrak{pp}$ and, since $\lambda_{\min}<0$,
$$\theta=\lambda_{\min}+\frac{\mathfrak{mm}+\mathfrak{mp}+\mathfrak{pp}}{\lambda_{\min}} .$$
An **upper** bound on $\theta$ therefore requires a **lower** bound on $\mathfrak{mm}+\mathfrak{mp}+\mathfrak{pp}$. But $\mathfrak{mm}\ge0$ and $\mathfrak{pp}\ge0$: they are already on the helpful side, and any lower bound discards them for free. Setting $\mathfrak{mm}=0$ is the **worst** case of the bound, not the case the hypothesis rescues.

**So $S_{\mathfrak{mmm}}=0$ contributes nothing to any upper bound on $\theta$ obtained from this identity.** This is the opposite sign situation from Nosal, where triangle-freeness removes an obstruction; here it removes the only slack.

Measured, to make sure this is not a rhetorical point. [relax.py](../scripts/reviewers/r322/relax.py) maximises $\theta$ over everything the truncated identity supplies, the identity itself; total mass $2(n-2)$; the per-row cap $\sum_bc_{1ab}^2\le2$ (proved below); $c_{11b}=0$; $\sum\lambda=0$, $\sum\lambda^2=1$; and Lemma L36's $\dim\mathfrak m\le\lfloor n^2/4\rfloor$, keeping the $\lambda_a\lambda_b\leftrightarrow c_{1ab}^2$ pairing throughout and discarding only frame-realizability of $t_{ab}=c_{1ab}^2$:

| $n$ | with the truncation $t_{ab}=0$ on $\mathfrak m\times\mathfrak m$ | without it | $\theta_0(n)$ |
|---|---|---|---|
| 6 | $2.392147$ | $2.392105$ | $1.054093$ |
| 8 | $2.636355$ | $2.636086$ | $1.145644$ |

The two columns agree to optimiser noise, as the argument says they must, the LP sets the $\mathfrak m\times\mathfrak m$ mass to zero of its own accord. **The truncation is worth nothing.**

### What the surviving term actually is, and why $S_{\mathfrak{mmm}}=0$ makes it worse

For $a\in\mathfrak m$, $b\in\mathfrak p$ and $v\in\mathfrak m$, $c_{1ab}=\langle[v,\varphi_a],\varphi_b\rangle$ has all of $v,\varphi_a\in\mathfrak m$ and $\varphi_b\in\mathfrak p$, it is a component of the $[\mathfrak m,\mathfrak m]\to\mathfrak p$ tensor, not of $[\mathfrak m,\mathfrak p]$. Writing $S_{\mathfrak{mmp}}=\sum_{u,u'\in\mathfrak m,\,w\in\mathfrak p}\langle[u,u'],w\rangle^2$, summing the unweighted $\mathfrak m\times\mathfrak p$ mass over an orthonormal basis of $\mathfrak m$ returns $S_{\mathfrak{mmp}}$ exactly:

| point | $S_{\mathfrak{mmm}}$ | $S_{\mathfrak{mmp}}$ | $\sum_{v\in\mathfrak m}$ (mp mass) | $\lVert[\mathfrak m,\mathfrak m]\rVert^2$ |
|---|---|---|---|---|
| $S^3\times S^3$ | 0 | 36 | 36.0000 | 36 |
| $S^5\times S^5$ | 0 | 200 | 200.0000 | 200 |
| $C_5$ blow-up | 0 | 120 | 120.0000 | 120 |
| U2 witness | 84 | 60 | 60.0000 | 144 |
| $n=8$ witness | 0 | 90 | 90.0000 | 90 |

Since $S_{\mathfrak{mmm}}+S_{\mathfrak{mmp}}=\lVert[\mathfrak m,\mathfrak m]\rVert^2$, the hypothesis $S_{\mathfrak{mmm}}=0$ moves **all** of the $[\mathfrak m,\mathfrak m]$ bracket mass into $S_{\mathfrak{mmp}}$, i.e. into precisely the term whose magnitude must be bounded above. The target set is the *maximally unfavourable* configuration for this identity.

### Does post F10 bite?

Post F10 says marginals cannot bound $P$. It is **true and irrelevant here**, because a bound that keeps the pairing does no better:

- the relaxation above keeps the pairing in full and still returns $2.392$ at $n=6$ against $\theta_0(6)=1.054093$, a factor $2.27$ overshoot, **worse than the $1.6059$ the marginal LP already achieved**;
- the marginal input it uses is proved rather than assumed: $\sup\lVert[v,\varphi]\rVert^2=2.000000$ over unit $v,\varphi\in\mathfrak{so}(n)$, identically at $n=6,8,10$ (L-BFGS, 20 restarts each), so $\sum_bc_{1ab}^2\le2$ for every $a$. Dropping that cap sends the relaxation to $3.624930$ ($n=6$) and $5.517603$ ($n=8$).

Lemma L36 **is** active, the optimum sits exactly at $\dim\mathfrak m=\lfloor n^2/4\rfloor$ ($9$ at $n=6$, $16$ at $n=8$), because a large $\mathfrak m$ is how the relaxation makes $|\lambda_{\min}|$ small and $\theta=\lambda_{\min}+\cdots/\lambda_{\min}$ large. So the cap is doing work; it is simply nowhere near enough.

### Verdict and what a successor must clear

**The count cannot be completed in this form.** Naming it precisely, in the order a successor should attack:

1. **The hypothesis is inert in the direction the bound needs.** Any argument of the shape "bound $\mathfrak{mm}+\mathfrak{mp}+\mathfrak{pp}$ from below" cannot use $S_{\mathfrak{mmm}}=0$, because the terms it kills are nonnegative and are dropped for free. A successor must find a route in which $S_{\mathfrak{mmm}}=0$ constrains the $[\mathfrak m,\mathfrak m]\to\mathfrak p$ tensor, and it constrains it in the *wrong* direction, since $S_{\mathfrak{mmm}}=0$ maximises $S_{\mathfrak{mmp}}$ at fixed $\lVert[\mathfrak m,\mathfrak m]\rVert^2$. Something must cap $\lVert[\mathfrak m,\mathfrak m]\rVert^2$ itself.
2. **The record's stated repair ("keep the pairing"), is demonstrably insufficient.** Measured: $2.392$ against $1.054$ at $n=6$, with pairing fully retained and Lemma L36 imposed.
3. **The sign structure of the transfer is inverted.** In Nosal the vanishing third moment removes a positive term from the side being bounded above; here the vanishing block removes a positive term from the side that helps. Any successor claiming the Nosal template must say which quantity plays the role of $\operatorname{tr}A^3$ *with the right sign*. The natural candidate is $\theta=\operatorname{tr}(W^3)+\tfrac12\sum_{abc}\lambda_a\lambda_b\lambda_cc_{abc}^2$ (derived here, and on the diagonal locus $=\sum_{i<j}M_{ij}^3+\tfrac12\operatorname{tr}M^3$), where $S_{\mathfrak{mmm}}=0$ *does* delete terms of the unfavourable sign, but that is the full three-index identity, not the one-index walk at $v$.
4. **One free global constraint is available and unused**: $\operatorname{tr}(W^\#)=-\operatorname{tr}(W^2)$ identically on $\mathcal W_n$, i.e. $\tfrac12\sum_{p,q}\lambda_p\lambda_q\lVert[\varphi_p,\varphi_q]\rVert^2=-\lVert W\rVert^2$.
5. **The single-index identity is one of $N$ and the others are not independent**: $\sum_c\langle\varphi_c,W^\#\varphi_c\rangle=\operatorname{tr}W^\#=-1$ and $\sum_c\lambda_c\langle\varphi_c,W^\#\varphi_c\rangle=\theta-\operatorname{tr}(W^3)$ reproduce items already known, so aggregating the identities over $c$ adds nothing. A successor needs the identities *pointwise* with a joint constraint between them, which is frame-realizability again, the thing every relaxation here discards.

---

## Found but not asked about

- **$Q$ preserves $\mathcal W_n$.** Checked at $n=5,6,7$ on random $W$: $\mathrm{Ric}(Q(W))$ and the Bianchi defect are $O(10^{-16})$. Several statements in the record are stated as if a Weyl projection stood between $Q(W)$ and $\theta W$; it does not, and the entrywise reading of criticality is safe.
- **$\operatorname{tr}(W^\#)=-\operatorname{tr}(W^2)$ on $\mathcal W_n$**, at non-critical points too.
- **$\sup\lVert[v,\varphi]\rVert^2=2$** over unit bivectors, independent of $n$ ($6,8,10$).
- **The mass claim is $W$-independent**, holding for any unit $v\in\mathfrak{so}(n)$; it is the Killing form and carries no information about the point.
- **Critical points with $\theta\le\lambda_{\min}$ exist** and are not rare, $9$ of $109$ sampled diagonal critical points at $n=6,7,8$, at $\theta=-2\sqrt2/3$, $-0.968246$, $-0.866025$, $-0.612372$. At every one $\mathfrak m\times\mathfrak p=0$ exactly. Any statement of the form "the $\mathfrak m$–$\mathfrak p$ sum is strictly negative" must carry $\theta>\lambda_{\min}$.
- **The $C_5$ blow-up's block values are exact rationals**: $\mathfrak{mm}=0$, $\mathfrak{mp}=-2/15$, $\mathfrak{pp}=1/90$, total $-11/90$, with $\lambda_{\min}=-1/\sqrt{45}$ and $\theta=3/\sqrt{20}$.
- **The $\lambda_{\min}$ eigenvalue is highly degenerate at every symmetric test point** (multiplicity $9,16,15,25,20$), so any per-$v$ statistic recorded at those points needs an eigenspace-constancy check before it is citable.
