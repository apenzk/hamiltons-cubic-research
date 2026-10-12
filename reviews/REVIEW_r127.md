# Gate 2, reviewer 127, the vertex-matrix PSD statement, its counting corollary, and the off-locus negative

Cold review of three claims about $K^2-\lambda K$ on the diagonal locus. Machinery written from scratch ([review_r127_lib.py](../scripts/review_r127_lib.py)) and cross-validated against the classical diagonal $\#$-formula $Q_{(ij)(ij)}=\lambda_{ij}^2+\sum_{k}\lambda_{ik}\lambda_{jk}$ to $10^{-16}$ at $n=4,5,6$ before anything else was computed. The record was opened only after the numbers below existed.

**Verdicts.** Claim 1 is correct and its "strictly stronger" rider is overstated. Claim 2 is correct, already in the record, and far weaker than what is provable in closed form. Claim 3 is over-recorded on three separate counts and one of its data points is triple-counted.

---

## Claim 1, the matrix statement

### (a) The algebra, checked two ways, and where $D$ comes from

**Correct, and the identification of $D$ is right.** The off-diagonal criticality equation is $K_{ab}^2+(K^2)_{ab}=\lambda K_{ab}$ for $a\ne b$; $\Lambda^2$ has no $(aa)$ index, so completing it to a matrix equation requires adding back what the missing diagonal would have carried. The left side has diagonal $K_{aa}^2+(K^2)_{aa}=0+\sum_bK_{ab}^2$ and the right side has $\lambda K_{aa}=0$, so the correction is exactly $D=\operatorname{diag}(\operatorname{diag}K^2)$, $D_{aa}=\sum_bK_{ab}^2$.

Pairing with an arbitrary $v$:

$$v^{\mathsf T}Dv-v^{\mathsf T}K^{\circ2}v=\sum_{a,b}K_{ab}^2v_a^2-\sum_{a,b}K_{ab}^2v_av_b=\tfrac12\sum_{a,b}K_{ab}^2(v_a-v_b)^2\ \ge\ 0,$$

the symmetrisation being legitimate because $K_{ab}^2=K_{ba}^2$. So $K^2-\lambda K\succeq0$ and $\operatorname{spec}(K)\cap(0,\lambda)=\emptyset$. Verified to $10^{-16}$ at eleven sphere products.

**The care the brief asks for lands on a different point, and the equation survives it.** The variational problem is constrained ($W$ must stay Weyl) so the criticality condition is a priori $P_{\langle W\rangle}(Q(W))=\lambda W$, and a projector could have contributed an extra $u_a+u_b$ to every off-diagonal entry. Two independent computations say it does not:

- **Direct.** Projecting a symmetric matrix onto $V=\{\text{hollow},\ K\mathbf1=0\}$ removes $\operatorname{Diag}(d)+u\mathbf1^{\mathsf T}+\mathbf1u^{\mathsf T}$; solving the two conditions for $A=K^{\circ2}+K^2$ gives $(n-2)u_a+\textstyle\sum u=0$ hence $u\equiv0$, because $A_{aa}=(A\mathbf 1)_a$ holds for this particular $A$.
- **Structural.** $\sum_{b\ne a}K_{ab}^2=D_a$ and $\sum_{b\ne a}(K^2)_{ab}=-D_a$ since $K\mathbf1=0$, so the hollow matrix $K^{\circ2}+K^2-D$ **already** has vanishing row sums. That is $Q(W)$ being Weyl, [BW08](../references/boehm-wilking-2008-space-forms/) eq. (6), quoted in [problem.md](../findings/problem.md) as $\operatorname{scal}(Q(W))=0$. Confirmed numerically: $|\mathrm{Ric}(Q(W))|=2.5\cdot10^{-14}$ and $|b_1(Q(W))|=1.2\cdot10^{-14}$ at random Weyl tensors, $n=6$.

So no projector appears, and the brief's worry about $D$'s origin resolves in the claim's favour.

### (b) It is not stronger than the scalar inequality in the way stated

**$K^2-\lambda K$ is a polynomial in $K$, so it commutes with $K$ and shares an eigenbasis.** PSD is therefore *equivalent* to $\mu_i^2-\lambda\mu_i\ge0$ at each eigenvector of $K$, that is, to the scalar Poincaré inequality evaluated at every eigenvector rather than at one. The matrix form adds nothing over that family, and the whole gain is the observation that the scalar derivation never used $u$ being the top eigenvector. The record's "strictly more: it constrains the *whole* spectrum" is true against $v=u_1$ and false against "$v$ ranges over eigenvectors"; the wording should say which.

**What arbitrary $v$ does buy is the non-spectral instances.** Taking $v=\mathbf1_S$ gives

$$\lVert K\mathbf1_S\rVert^2-\lambda\,\mathbf1_S^{\mathsf T}K\mathbf1_S\ =\ \sum_{a\in S,\,b\notin S}K_{ab}^2,$$

a cut identity on the weighted graph with no spectral counterpart. That is where a general test vector is worth writing down, and it is a different sentence from the one currently recorded.

---

## Claim 2, the counting corollary

### (c) $t=2$ exactly, and the bound is very lossy

**$t=2$ on the diagonal locus, not $t\le2$**, $\lVert M\rVert_F^2=\sum_{a<b}K_{ab}^2=t/2$ when $M$ is coordinate-diagonal, so the normalisation pins it. The record already states this ([diagonal-half.md](../findings/diagonal-half.md)), so (c)'s premise is answered there; using $t\le2$ inside the corollary is conservative rather than wrong.

**Two sharpenings the record does not carry.** With $\operatorname{tr}K=0$, $t=2$ and $r=1$: writing $p$ for the single positive eigenvalue and $s$ for the number of negatives, $\sum|{\rm neg}|=p$ and $\sum{\rm neg}^2=2-p^2$, so Cauchy–Schwarz gives $p^2\le s(2-p^2)$ and

$$\lambda\ \le\ p\ <\ \sqrt2,\qquad s\ \ge\ \frac{\lambda^2}{2-\lambda^2}\ =\ 3.235\ \text{ at }\Theta_{12},\ \text{ hence }s\ge4,\ n\ge6 .$$

Checked: $p_{\max}=1.3484,\,1.3108,\,1.3399,\,1.2456$ at $S^6{\times}S^6$, $S^4{\times}S^8$, $S^5{\times}S^7$, $S^3{\times}S^9$, all below $\sqrt2$, all with $s=10$.

**The eight-sphere-product check is subsumed by a closed form.** For $S^p\times S^q$ the vertex matrix is block-constant with $\gamma=-\lambda/(n-1)$ off-block, $\alpha=q|\gamma|/(p-1)$, $\beta=p|\gamma|/(q-1)$, and its spectrum is

$$\Big\{\,n|\gamma|\ (\times1),\quad 0\ (\times1),\quad -\alpha\ (\times\,p-1),\quad -\beta\ (\times\,q-1)\,\Big\},\qquad \lambda=\sqrt{\tfrac{2(n-1)(p-1)(q-1)}{pq(n-2)}},$$

which reduces to $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ at $p=q$. So $r=1$ at **every** sphere product, in every dimension and both parities, with the single positive eigenvalue $n\lambda/(n-1)>\lambda$, no dimension hypothesis and no sampling. Reproduced to $10^{-16}$ at all eleven products tested. The corollary is not what forces $r=1$ here: $S^2\times S^{n-2}$ has $\lambda^2=(n-1)(n-3)/(n-2)^2<1$, so $2/\lambda^2>2$ and the corollary permits $r=2$, yet $r=1$ regardless.

**What the corollary really says is block-irreducibility.** An orthogonal direct sum of $k$ diagonal critical points is again one, with $c_i=\lambda/\lambda_i$ and $1/\lambda^2=\sum_i1/\lambda_i^2$; since $\lambda_i<\sqrt2$ always, $\lambda^2<2/k$, so $k\ge2$ forces $\lambda<1$ while $r=\sum r_i\ge k$. The recorded contrapositive "$r\ge2\Rightarrow\theta\le1$" is therefore the statement that a critical point at $\Theta_{12}$ has no orthogonal block decomposition. Witness: $S^3{\times}S^3\oplus S^2{\times}S^4$ at $n=12$, critical to $1.1\cdot10^{-16}$, $\lambda=0.713074$, $t=2$, $r=2$, PSD intact.

---

## Claim 3, the off-locus negative is over-recorded

### The three-point evidence base is one point

Zero-padding a dimension-4 trace-free tensor keeps it trace-free at every $n$ (the extra Ricci summands are zero), and $Q$ of a padded tensor is the padded $Q$. So padded $W_{\mathbb{CP}^2}$ is *the same tensor* at $n=6,8,10,12$, identical $\lambda=1.224745$, $t=1$, $r=1$, $\lambda_{\min}(K^2-\lambda K)=-0.33333$, all to $10^{-16}$. The alternative reading, padding the raw $\mathbb{CP}^2$ curvature and Weyl-projecting in dimension $n$, is **not critical at all** (residual $0.19,\,0.065,\,0.050$ at $n=6,8,12$), so it is not what was tested. The row should read "padded $W_{\mathbb{CP}^2}$, all $n$", one column.

### "Fails maximally" is false

At $S^3{\times}S^3\oplus\mathbb{CP}^2$, $n=10$, critical to $5.6\cdot10^{-17}$, $\lambda=0.798935$ from the harmonic-square law, the two positive eigenvalues are $0.95872$ and $0.53262$: the first sits **above** $\lambda$. At $S^2{\times}S^4\oplus\mathrm{SU}(3)$ ($n=14$, $\lambda=0.633059$) three positives, one above $\lambda$. The reason is structural: the harmonic-law coefficients $c_i=\lambda/\lambda_i$ make the ratio $\mu/\lambda=\mu_i/\lambda_i$ **scale-invariant**, so a direct sum inherits each block's verdict unchanged and can only mix them. Maximal failure is an artefact of testing irreducible Kähler points only.

*That same invariance answers the brief's recipe for (d) in the negative: block sums can never repair a failing block, so they cannot produce a counterexample to the PSD statement on their own.*

### The 500-frame experiment measures frame-dependence, not diagonality

The same failure occurs at points that **are** diagonal:

| | random frames tested | PSD fails | $t$ range over frames |
|---|---|---|---|
| $S^3{\times}S^3$ (diagonal critical) | 120 | **120** | $0.033$ – $0.907$ |
| $S^4{\times}S^4$ (diagonal critical) | 120 | **120** | $0.033$ – $0.509$ |
| $\mathbb{CP}^2$ | 120 | 120 | $0.0004$ – $0.989$ |
| $\mathbb{CP}^3$ | 120 | 120 | $0.063$ – $0.626$ |

And the converse holds: PSD survives *off* the coordinate-diagonal locus. Rotating $S^3\times S^3$ by $\exp(\varepsilon A)$,

| $\varepsilon$ | 0 | 0.10 | 0.30 | 0.50 | 0.70 | 1.00 |
|---|---|---|---|---|---|---|
| off-diagonal mass of $M$ | 0 | 0.027 | 0.080 | 0.128 | 0.169 | 0.211 |
| $t$ | 2.000 | 1.982 | 1.845 | 1.598 | 1.293 | 0.855 |
| $\lambda_{\min}(K^2-\lambda K)$ | 0 | 0 | 0 | 0 | $-0.045$ | $-0.207$ |

PSD holds at $\varepsilon=0.5$, where $M$ is manifestly not coordinate-diagonal, and in **40 of 40** random directions at $\varepsilon=0.05$. So "off the diagonal locus the statement fails" is literally false, and the recorded resolution, that a rotation preserves PSD while it moves $K^2-\lambda K$ by less than the spectral gap $\varepsilon_1$, is the correct sentence. Claim 3 as briefed contradicts the record's own paragraph.

### Six new non-Kähler, non-diagonal witnesses, the negative is real, just not for the stated reason

The Kähler-only table left open whether Kählerness was the operative feature. It is not. All of the following are critical to $10^{-17}$, none is Kähler, and every positive eigenvalue of $K$ lies inside $(0,\lambda)$ at each:

| point | $n$ | $\lambda$ | $t$ | $t/\lambda^2$ | $r$ | in $(0,\lambda)$ | $\lambda_{\min}(K^2-\lambda K)$ |
|---|---|---|---|---|---|---|---|
| $S^p\times S^q$ (7 tested) | 6–12 | $0.968$–$1.236$ | $2.000$ | $1.31$–$2.13$ | 1 | **0** | $0$ |
| $\mathbb{CP}^2\dots\mathbb{CP}^6$ | 4–12 | $0.925$–$1.225$ | $0.429$–$1.000$ | $0.50$–$0.68$ | 1–5 | all | $-0.153$ – $-0.333$ |
| $\mathbb{HP}^2$ | 8 | $1.115547$ | $0.600$ | $0.482$ | 1 | 1 | $-0.28571$ |
| $\mathbb{HP}^3$ | 12 | $0.852944$ | $0.4286$ | $0.589$ | 2 | 2 | $-0.18182$ |
| $\mathrm{SU}(3)$ bi-invariant | 8 | $0.836660$ | $0.4833$ | $0.690$ | 2 | 2 | $-0.16071$ |
| $\mathrm{SO}(5)$ bi-invariant | 10 | $0.717137$ | $0.2857$ | $0.556$ | 4 | 4 | $-0.10317$ |
| $\mathrm{SU}(4)$ bi-invariant | 15 | $0.557773$ | $0.3148$ | $1.012$ | 5 | 5 | $-0.07757$ |
| $\mathrm{SO}(6)$ bi-invariant | 15 | $0.557773$ | $0.2500$ | $0.804$ | 5 | 5 | $-0.06786$ |

$\mathrm{SU}(4)$ and $\mathrm{SO}(6)$ landing on the same $\lambda$ is the isomorphism $\mathfrak{su}(4)\cong\mathfrak{so}(6)$, an internal check. Bi-invariant metrics on compact simple groups are neither symmetric nor Kähler, so this is the widest witness set the record has for the negative.

### The one number that separates the two regimes, and the identity behind it

**PSD forces $r\le t/\lambda^2$.** On the diagonal locus $t=2$ exactly and $\lambda\le\theta_0(n)<\sqrt2$, so $t/\lambda^2\in[1.31,2.13]$ and the bound never bites. Off the locus $t<2$ strictly, and every non-diagonal point above has $t/\lambda^2<r$. **But that is not the whole mechanism**: at $S^3{\times}S^3\oplus\mathbb{CP}^2$ the counting bound is *satisfied* ($r=2\le2.47$) and PSD still fails.

The exact statement is the weighted-Laplacian one, valid at **every** critical point in **every** frame. Define the off-diagonal defect $U:=\lambda K-K^{\circ2}-K^2$ with the diagonal set to zero. Then

$$K^2-\lambda K\ =\ L(w),\qquad w_{ab}=K_{ab}^2+U_{ab},\qquad\text{and}\qquad U\mathbf1=0 .$$

The row-sum property is forced, not assumed: $\sum_{b\ne a}\big[K_{ab}^2+(K^2)_{ab}+U_{ab}\big]=\lambda\sum_bK_{ab}=0$ and the first two sums cancel. So $U\in V$, $-\sum_{a\ne b}U_{ab}v_av_b=\tfrac12\sum U_{ab}(v_a-v_b)^2$, and

$$v^{\mathsf T}(K^2-\lambda K)v\ =\ \tfrac12\sum_{a,b}\big(K_{ab}^2+U_{ab}\big)(v_a-v_b)^2\quad\text{at every critical point, in every frame.}$$

Verified to $10^{-17}$ at $\mathbb{CP}^{2..5}$, $S^3{\times}S^3$, $S^4{\times}S^4$ and a randomly rotated $S^3{\times}S^3$; $U=0$ identically on the coordinate-diagonal locus. Nonnegative weights are sufficient, and the sphere products have a strictly positive margin, $w_{\min}=0.0444,\,0.0268,\,0.0178$ at $S^3{\times}S^3$, $S^4{\times}S^4$, $S^5{\times}S^5$, which is exactly why small rotations survive and why $\mathbb{CP}^m$ ($8$ of $12$ weights negative at $\mathbb{CP}^2$) does not. This is the record's $E$-identity with the missing structural fact attached: $E$ is not merely hollow, it has vanishing row sums.

---

## (e) Is "$K$ has an eigenvalue in $(0,\lambda)$" a diagonality test?

**No, in either of its two readings, and it is worse than [post F22](../findings/INDEX.md)'s $\ker\Phi_W$ on both.**

- **In a given frame** it is a property of the pair (operator, frame) rather than of $W$: it fails at $S^3\times S^3$ in $120/120$ random frames and holds at $40/40$ small rotations of the same point. A test that gives both answers at one operator classifies nothing.
- **Frame-free**, as "$\exists$ a frame with $\operatorname{spec}(K)\cap(0,\lambda)=\emptyset$", it is satisfied by $\mathbb{CP}^2$: there is a frame in which $K$ vanishes identically ($t=9.1\cdot10^{-18}$, found by minimising $t$ over $O(4)$), and $K^2-\lambda K=0$ is PSD there vacuously. The frame optimiser reaches $\lambda_{\min}=0$ from essentially every random start by driving $K\to0$, so the existential version is degenerate.

The record already holds the sharp frame-free test in the right currency: $\max_{\text{frames}}t=2$ **iff** $W$ is diagonalisable ([target.md](../findings/target.md)), a single scalar with an exact threshold and no non-convex $O(n)$ search behind it. Like $\ker\Phi_W$ it carries no $\theta$ information, so the PSD statement is strictly dominated here, same class of information, worse instrument.

---

## What should be recorded

**Keep**, restated: the Laplacian identity with $w_{ab}=K_{ab}^2+U_{ab}$ and $U\mathbf1=0$; the counting corollary $r\le t/\lambda^2$ with $t=2$ on the locus; the closed-form sphere-product spectrum replacing the eight-point check; $\lambda\le p<\sqrt2$ and $s\ge4$ at $\Theta_{12}$; the six new non-Kähler witnesses.

**Cut or rewrite**: "strictly stronger than the scalar inequality" (it is the eigenvector family, restated); the $n=6,8,12$ triple (one point); "fails maximally" (false off the Kähler family); "off the diagonal locus the statement fails" (false, small rotations satisfy it); the 500-frame count as evidence about $\mathbb{CP}^2$ (the same count holds at diagonal points).

**The negative should be recorded narrowly**: the free positivity argument is unavailable wherever the defect $U$ drives a weight negative, which is a statement about the size of the off-diagonal mass of $M$ relative to $K^{\circ2}$, not about criticality, not about Kählerness, and not about the diagonal locus.

*Scripts: [review_r127_lib.py](../scripts/review_r127_lib.py), [review_r127_pts.py](../scripts/review_r127_pts.py), [review_r127_frames.py](../scripts/review_r127_frames.py), [review_r127_more.py](../scripts/review_r127_more.py), [review_r127_diag.py](../scripts/review_r127_diag.py). Log: [gate2_127.log](../agent_logs/gate2_127.log).*
