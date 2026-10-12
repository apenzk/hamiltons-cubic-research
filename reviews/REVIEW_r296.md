# Review r296, the non-diagonal $n=8$ witness at $\theta=1.088948$

Independent build from the definitions in [scripts/reviewers/r296/core296.py](../scripts/reviewers/r296/core296.py); nothing under review was imported. The witness was **rebuilt** by solving criticality on $V$ with my own Levenberg–Marquardt, and the saved copy [w_n8_nondiagonal_witness.npy](../scripts/data/w_n8_nondiagonal_witness.npy) used only to cross-check.

## Verdicts

| Claim | Verdict | One line |
|---|---|---|
| **E1**, genuine critical point in the target set | **CONFIRMED** | every quoted number reproduces from an independent build, and the point is nondegenerate transverse to its orbit, so an exact solution exists within $2.4\times10^{-14}$ |
| **E2′**, non-diagonality, certified by an identity | **CONFIRMED, and now explained** | the plane is $\Lambda^2_+(U)$ for a rotated $4$-space $U$, which makes the constancy exact; and a **second, simpler certificate** applies that the record wrongly called silent |
| **E3**, it displaces a recorded ceiling | **PLAUSIBLE as arithmetic, REFUTED as significance** | the witness is **graded**, $\mathfrak{so}(8)=\mathfrak p\oplus\mathfrak m$ with $\mathfrak p\cong\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, so it lies in the half the record calls settled, and the open ungraded remainder keeps its $1.71\times$ margin |
| **E4**, the restriction to $V$ is legitimate | **CONFIRMED, and it is a proof, not a measurement** | $\mathrm{Ad}(s)$-equivariance of $Q$ holds **exactly** ($0.00\times10^{0}$), so no point of $V$ can have off-$V$ gradient mass |

## The independent machinery, and its controls

Built from the brief's lines only, $\phi_{ij}=E_{ij}-E_{ji}$, $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, $c_{abg}=\langle[\phi_a,\phi_b],\phi_g\rangle$, $(W^\#)_{ab}=-\tfrac12\operatorname{tr}(A_aWA_bW)$, $Q=W^2+W^\#$, and $\mathcal W_n$ as the joint kernel of first Bianchi and Ricci **read off the $4$-tensor**:

- $\dim\mathcal W_8=300=\tfrac{n(n+1)(n+2)(n-3)}{12}$; $\dim V=155$, $\dim\mathfrak p=13$, $\dim\mathfrak m=15$, all as claimed;
- [sharp](../scripts/reviewers/r296/core296.py) against the literal $-\tfrac12\operatorname{tr}(A_aWA_bW)$ loop: $8.3\times10^{-17}$; the polarisation $\tfrac12[(X+Y)^\#-X^\#-Y^\#]$ against [sharp_bil](../scripts/reviewers/r296/core296.py): $2.3\times10^{-14}$; the exact Jacobian against central differences: $1.0\times10^{-10}$;
- **control**: $S^3\times S^5$ lies in $V$ to $2.4\times10^{-15}$ and is critical there at $|F|=9.3\times10^{-16}$, $\theta=1.115546702$.

**A machine hazard worth recording.** [scipy.linalg.svd](https://docs.scipy.org/doc/scipy/reference/generated/scipy.linalg.svd.html) on a $156\times155$ matrix takes **13.4 s** here against $0.003$ s for [numpy.linalg.svd](https://numpy.org/doc/stable/reference/generated/numpy.linalg.svd.html), so [scipy.optimize.least_squares](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.least_squares.html) spends $97\%$ of its time in one LAPACK call and a single solve costs $\sim 7$ minutes. The rebuild uses hand-written Levenberg-Marquardt over numpy instead: $3$ s per start. Any future run of [run_f4b_newton.py](../scripts/runs/run_f4b_newton.py) on this machine is paying that tax.

## E1, CONFIRMED

Rebuilt: starting from the sphere product with kicks of $0.05$, my own solver returns $\theta=1.088948$, and the rebuilt operator agrees with the stored one to $10^{-15}$ in the whole spectrum and to twelve digits in $\theta$. **The kick size decides everything**: $0.02$ returns only the control $S^3\times S^5$; $0.05$ returns $1.115547$, $1.088948$, $0.804770$, $0.599021$; $0.1$ and above scatter to $\theta<0.35$, and at the brief's $\mathrm{kick}=0.5$ my $60$ starts produced $33$ distinct critical points with **none above $0.19$**. The recorded run reached the family at $0.5$ from $30$ starts, so this is solver-and-seed luck rather than a protocol; anyone re-running it should use small kicks. Every quoted number, recomputed on the saved copy with the independent machinery:

| quantity | recorded | rebuilt here |
|---|---|---|
| $\lVert W\rVert$ | unit | $1.0$ **bitwise** |
| $\theta$ | $1.088948053$ | $1.088948052505$ |
| $\lVert Q(W)-\theta W\rVert_\infty$ over the **full** $28\times28$ | $5\times10^{-16}$ | $5.01\times10^{-16}$ (Frobenius $2.9\times10^{-15}$) |
| Bianchi / Ricci / trace, from the $4$-tensor | $10^{-16}$ | $2.6\times10^{-16}$ / $5.1\times10^{-16}$ / $4.0\times10^{-16}$ |
| $\Delta$ | $1.512231$ | $1.512230534$ |
| $\sum_\gamma g_\gamma$ | $28=4(n-1)$ | $28.000000000000$ |
| $S_{\mathfrak{mmm}}$ | $1.4\times10^{-28}$ | $1.438\times10^{-28}$ |
| $\dim\mathfrak m$ / $\ker$ / distinct positive eigenvalues | $15$ / trivial / five | $15$ / $0$ / $5$ |

[is_weyl](../scripts/lib/weyl_screen.py) does do what its name says: I rebuilt Bianchi as $R_{ijkl}+R_{iklj}+R_{iljk}$ and Ricci as $\sum_j R_{ijkj}$ from the $4$-tensor rather than from the pairs matrix, and both land at $10^{-16}$.

**Beyond the brief: the point is nondegenerate transverse to its orbit, so it exists exactly.** The Jacobian of the criticality system on $V$ has numerical nullity $12$, and that kernel **is** the $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ orbit tangent inside $V$, all twelve principal angles $1.000000$. Off that kernel $\sigma_{\min}=0.109202$ against $\lVert F\rVert=2.6\times10^{-15}$, so Newton–Kantorovich puts an exact solution within $2.4\times10^{-14}$ of the stored array. Every claim below has margin $\ge10^{-2}$, so none of them can be an artefact of that displacement.

## E2′, CONFIRMED, with the factor pinned, the constancy explained, and a second certificate

### The factor of $2$: the coordinator is right and the repo is half

From the definition, $\omega\wedge\omega$ has $e_i\wedge e_j\wedge e_k\wedge e_l$ coefficient $2(w_{ij}w_{kl}-w_{ik}w_{jl}+w_{il}w_{jk})$. Pin it by hand on $\omega=(e_{12}+e_{34})/\sqrt2$, which is a unit bivector with $\omega\wedge\omega=1\cdot e_{1234}$, hence $\lVert\omega\wedge\omega\rVert=1$. Both [plucker_min](../scripts/lib/review_r56_core.py) and [wedge_norm](../scripts/reviewers/r283/c2_instruments.py) drop the $2$, so they report **half** the standard norm. Nothing in the certificate depends on it, but the record's $\min=0.5000$, and the control values $0.61/0.63/0.50$ at $\mathbb{CP}^4$, $\mathbb{CP}^5$ and padded $W_{\mathbb{CP}^2}$, are all half-convention numbers and should be labelled as such.

**Instrument control table reproduced** (half convention, $4001$ angles): two decomposables $\to$ $\min 0$; decomposable $+$ rank $4$ $\to$ $\min 0$; two orthogonal rank-$4$ generators forming a self-dual pair $\to$ $0.500000$ **constant**. The coordinator's fourth row does not reproduce as a constant: a generic plane inside a coordinate $\mathbb R^4$ gives $\min$ $0.0478$, $0.000026$, $0.000068$, $0.1149$ at seeds $0$–$3$, generic planes in $\Lambda^2\mathbb R^4$ usually come close to the null cone of a $(3,3)$ form, so $0.480000$ is one seed, not a signature.

### The constancy is exact, and here is the mechanism

On the $\lambda=-0.302413017832$ eigenspace (multiplicity exactly $2$, gap $0.143047$ to the next eigenvalue, $\lVert(W-\lambda)E\rVert=9.4\times10^{-17}$):

1. **It is not merely $\lVert\omega\wedge\omega\rVert$ that is constant, $\omega\wedge\omega$ itself is the same $4$-form for every unit $\omega$ in the plane.** $\lVert\omega_1\wedge\omega_1-\omega_2\wedge\omega_2\rVert=2.9\times10^{-15}$ and $\lVert\omega_1\wedge\omega_2\rVert=1.4\times10^{-15}$, which is the whole of it: writing $\omega(t)\wedge\omega(t)=m+\cos2t\,p+\sin2t\,q$, both $p$ and $q$ vanish to $10^{-15}$ and $\lVert m\rVert=1.000000000000000$.
2. **Every unit element is a rank-$4$ bivector with equal singular values** $(\tfrac1{\sqrt2},\tfrac1{\sqrt2},0,0)$, at every sampled angle.
3. **All of them have the same $4$-dimensional support $U\subset\mathbb R^8$**, the principal angles between the images of $\omega(0)$, $\omega(0.5)$, $\omega(1.2)$ are $1,1,1,1$, and $\lVert M-P_UMP_U\rVert\le3.0\times10^{-15}$.
4. **Inside $\Lambda^2U$ the plane is self-dual**: the anti-self-dual parts of the two generators are $4.7\times10^{-16}$ and $2.8\times10^{-16}$, against self-dual parts of $1.414213562373096$ each.

On $\Lambda^2_+(U)$ one has $\omega\wedge\omega=\lVert\omega\rVert^2\mathrm{vol}_U$ identically, so $\lVert\omega\wedge\omega\rVert\equiv1$ on the unit circle **as an identity**, and the only zero is $\omega=0$. That is the mechanism the record says is unestablished, and the record's stated refutation of it, *"not a plane of self-dual forms inside a coordinate $4$-space, refuted by the coordinate support being all eight directions"*, conflates *$4$-space* with *coordinate $4$-space*. $U$ is a rotated $4$-space: it meets the coordinate $\mathbb R^3$ in a $2$-plane and the coordinate $\mathbb R^5$ in a $2$-plane (principal-angle cosines $[1,1,0]$ and $[1,1,0,0]$), which is exactly why the support is spread over all eight directions while the plane still lies in a single $\Lambda^2 U$.

**A second, group-theoretic reading of the same fact.** $\dim\mathfrak k(W)=\dim\{A:[\operatorname{ad}A,W]=0\}=5$, and $\mathfrak k(W)$ acts on the $2$-plane by genuinely nonzero skew $2\times2$ blocks (symmetric part $2.2\times10^{-16}$, norms $0.41$ to $1.47$). A circle subgroup of the isotropy therefore acts transitively on the plane's unit circle, and $\omega\mapsto\lVert\omega\wedge\omega\rVert$ is $O(8)$-invariant. Constancy is forced.

**The one way an eigenspace certificate can be broken, and why it is not broken here.** If the true multiplicity were larger than the computed one, the certified plane would be a proper subspace of a bigger eigenspace, and a $2$-plane inside a coordinate-spanned $3$-space can perfectly well miss the Grassmann cone, $\mathrm{span}\{e_{12}+e_{34},\,e_{12}+e_{56}\}$ does. That is the attack, and it needs the multiplicity to grow under a $10^{-14}$ perturbation across a gap of $0.143047$, which is impossible. Multiplicity *dropping* only strengthens the certificate, since each eigenline separately has $\lVert\omega\wedge\omega\rVert=1$.

**The eigenbasis inside the degenerate space is not unique, and it does not matter.** Constancy is a statement about every unit vector of the plane, so it is basis-free by construction; measured anyway, over $200$ random rotations of the eigenbasis the value moves by $4.4\times10^{-16}$.

### The record's "inconclusive weaker instrument" is in fact decisive

[Lemma L37](../findings/target.md)'s own sufficient test, spelled out in [b_frame_independent_diagonality.py](../scripts/lib/b_frame_independent_diagonality.py), *if a **simple** eigenvalue has an eigenvector of bivector rank $>2$ then $W$ is diagonal in no frame*, **applies here and settles it**. The witness has two simple eigenvalues, $0.114549164418$ and $0.573114703487$, and each eigenvector has singular values $(0.8545,0.8545,0.5194,0.5194,0,0,0,0)$: **rank $4$**. In a diagonalising frame a simple eigenvalue's eigenline would have to *be* a coordinate $2$-plane, of rank $2$. So E2's parenthetical that Lemma L37 "is silent, $\dim\ker\Phi_W=8=n$" is wrong, the dimension count is at threshold, but the lemma's rank corollary needs no dimension count and decides the case outright. **Non-diagonality is certified twice over, by two independent instruments.**

### Controls, and the attempt to break it

- Two other $2$-dimensional eigenspaces, at $\lambda=-0.159366$ and $\lambda=+0.316806$, have $\lVert\omega\wedge\omega\rVert\equiv0$ over their whole circles, every element decomposable. The instrument separates.
- **Robustness.** The certificate compares $1.0$ against $0$; $\lVert\omega\wedge\omega\rVert$ is Lipschitz on the unit sphere with constant $\le2\sqrt2$, so the plane would have to move by $\sim0.35$ radians before any element became decomposable, against an eigenprojector uncertainty of $\lVert F\rVert/\mathrm{gap}\approx10^{-14}$. There is no floor question.

## E3, the arithmetic holds; the significance does not

**What is true.** Nothing recorded on $\{$critical, $S=0$, $\Delta>0\}$ exceeds $1.088948$. Every value above it in [findings/INDEX.md](../findings/INDEX.md) is a symmetric-space point with $\Delta=0$, I recomputed $\Delta=0.000$ exactly at $S^3\times S^5$ ($1.115547$), $S^4\times S^4$ ($1.145644$) and $\mathbb{CP}^4$ ($0.986013$) with my own defect code. And the margins are arithmetically right: $\sqrt{3/2}/1.088948=1.1247$ against $\sqrt{3/2}/0.716134=1.7102$.

**What breaks it: the witness is GRADED.** Take $\mathfrak p$ and $\mathfrak m$ to be its positive and negative eigenspaces, $\dim13$ and $\dim15$. Then

$$[\mathfrak p,\mathfrak p]\subseteq\mathfrak p,\qquad[\mathfrak p,\mathfrak m]\subseteq\mathfrak m,\qquad[\mathfrak m,\mathfrak m]\subseteq\mathfrak p,$$

with maximum absolute leak $2.2\times10^{-15}$ on each of the three (and $S_{\mathfrak{mpp}}=1.19\times10^{-28}$, the same size as $S_{\mathfrak{mmm}}$). So $\mathfrak{so}(8)=\mathfrak p\oplus\mathfrak m$ is a $\mathbb Z_2$-grading, with **trivial kernel**, so the record's own load-bearing caveat is satisfied and this is gradedness of $\mathfrak{so}(8)$, not of a subalgebra. Identifying the pair: the Killing form of $\mathfrak p$ has eigenvalues $-6$ (multiplicity $10$) and $-2$ (multiplicity $3$), and $\mathfrak p$ has a $2$-dimensional symmetric commutant on $\mathbb R^8$ splitting it as $3+5$, so $\mathfrak p=\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ in its reducible embedding, the **same symmetric pair as $S^3\times S^5$**. Rotating into the adapted frame ([e3_adapted.py](../scripts/reviewers/r296/e3_adapted.py)) leaves $\theta$ and the Weyl residuals unchanged and puts all thirteen positive eigenvalues on the $\mathfrak p$-block and all fifteen negative on the $\mathfrak m$-block, off-block mass $1.1\times10^{-15}$.

Four consequences, in increasing order of cost to the record:

1. **$S_{\mathfrak{mmm}}=0$ is structural, not numerical.** For a symmetric pair $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$ holds identically, so $S=0$ here is forced, and the $1.4\times10^{-28}$ is round-off around an exact zero. Good news for E1, and worth saying in the record instead of quoting a tiny number.
2. **The witness lies in the half the record calls settled.** [plan.md](../plan.md) and [results.md](../results.md) both split the target as "$\Delta=0\Rightarrow$ graded, the graded half is settled, so what remains is $\{S=0,\Delta>0\}$". That split only removes the *graded* points from the open set; it does not follow that the surviving $\{\Delta>0\}$ points are ungraded, and this one is not. By the record's own criterion, [target.md](../findings/target.md) line 541, *"because $\Delta=12>0$ it is not graded, so it escapes step H"*, the witness is **step H's territory**. So the collapse of the margin from $1.71\times$ to $1.12\times$ is a collapse in the *stated* set $\{S=0,\Delta>0\}$ and **not** in the set that is actually open. On $\{S=0,\ \text{ungraded}\}$ the ceiling is untouched.
3. **The record contradicts itself about what that costs, and this witness is where it matters.** [plan.md](../plan.md) and [results.md](../results.md) say the graded half is settled; [graded-half.md](../findings/graded-half.md) says the graded enumeration assumed the two-eigenvalue form, never searched points with unequal values across the factors of $\mathfrak k$, and so "cannot be called settled". The witness has **five** distinct positive eigenvalues on $\mathfrak p$, so it is outside the enumeration and inside the class plan.md grants. Both readings cost the claim: on the first the point is already covered and the margin collapse is illusory; on the second the graded half is open and this is a graded falsifier, not a $\{\Delta>0\}$ one. Either way "the margin for route V2 fell to $1.12\times$" is not established.
4. **The line 541 inference is itself invalid, and this witness is its counterexample.** $\Delta=0\Rightarrow$ graded is proved; the converse is false, and here it fails with $\Delta=1.512$. (The conclusion at $C_5$ survives for another reason, $S_{\mathfrak{mpp}}=80\ne0$ there, so $C_5$ really is ungraded.)

**The family, rebuilt.** From $120$ starts on $V$ at kicks $0.03$–$0.09$ my solver returns $29$ distinct $\theta>0.5$. Everything above $1.079$ is graded with $S=0$:

| $\theta$ | $\Delta$ | $\dim\mathfrak m$ | $\ker$ | distinct $+$ | graded | simple eigenvalues of rank $>2$ |
|---|---|---|---|---|---|---|
| $1.115547$ | $0$ | $15$ | $0$ | $2$ | yes |, (this is the control, $S^3\times S^5$) |
| $\mathbf{1.088948}$ | $1.5122$ | $15$ | $0$ | $5$ | **yes** | $2$, rank $4$ |
| $1.081605$ | $0.7912$ | $12$ | $7$ | $5$ | subalgebra only | $3$, rank $4$ |
| $1.081549$ | $2.4009$ | $15$ | $0$ | $7$ | **yes** | $6$, rank $6$ |
| $1.079759$ | $2.7628$ | $15$ | $0$ | $8$ | **yes** | $4$, rank $6$ |
| $1.079511$, $1.079206$, $1.079149$ | $1.2$–$1.3$ | $12$ | $7$ | $3$–$6$ | subalgebra only | rank $6$ |

So the record's "three siblings" understates it, on $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ alone there are at least six, and I reproduce $1.081549$ exactly while $1.083689$ and $1.080092$ do not appear here, consistent with the brief's note that two of the siblings sit at $\dim\mathfrak m=16$, i.e. on $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$. **Every one of them is below $S^3\times S^5$**, the two-eigenvalue graded point of the same pair: the family looks like off-slice graded critical points of one symmetric pair, sitting under its symmetric-space value, exactly the population [graded-half.md](../findings/graded-half.md) says the graded enumeration never searched, and evidence that the graded half is **not** settled rather than that the ungraded margin collapsed.

## E4, CONFIRMED, and it is a theorem, not a measurement

$s=\mathrm{diag}(I_3,-I_5)$, $\sigma=\Lambda^2(s)$. Measured and, more usefully, argued:

- $\Lambda^2(s)$ equals $\mathrm{diag}(+1\ \text{on}\ \mathfrak p,\ -1\ \text{on}\ \mathfrak m)$ to $0.0$, and its conjugation fixes exactly the block-diagonal matrices, $V$ is the fixed-point set on the nose, $\dim V=155$, basis $\mathrm{Ad}(s)$-invariance $9.8\times10^{-16}$.
- $\mathrm{Ad}(s)$ is an automorphism of $\mathfrak{so}(8)$ preserving $\langle\cdot,\cdot\rangle$, so $\#$ is equivariant: $\lVert(\sigma X\sigma)^\#-\sigma X^\#\sigma\rVert=0.00\times10^{0}$ **exactly**, for a general symmetric $X$, not only for $X\in V$. Hence $Q(\sigma X\sigma)=\sigma Q(X)\sigma$ exactly.
- $\mathcal W_8$ is $\mathrm{Ad}(s)$-invariant ($1.9\times10^{-15}$), so $\Pi_{\mathcal W}$ commutes with $\sigma$.

Therefore at any $W\in V$ the gradient $3\,\Pi_{\mathcal W}Q(W)$ is $\sigma$-fixed, i.e. in $V$: **the brief's request to "construct a point of $V$ where the full gradient has mass off $V$" cannot be met**. Measured anyway over $200$ random $W\in V$: off-block $\lVert Q(W)\rVert_\infty\le1.1\times10^{-16}$ and off-block $\lVert\Pi_{\mathcal W}Q(W)\rVert_\infty\le1.3\times10^{-16}$. Palais applies to the $\mathbb Z_2$-action on the unit sphere of $\mathcal W_8$, whose fixed-point set is $V\cap S$. Nothing here is vacuous: $\dim V=155$ inside $\dim\mathcal W_8=300$, and the witness genuinely lies in it ($\lVert W-\Pi_VW\rVert=2.8\times10^{-15}$).

## The attempt to refute E2 by diagonalising

The right instrument is a descent over $O(8)$ on the off-diagonal mass with an **analytic** gradient, $\nabla_A f=2\operatorname{tr}([Y_{\mathrm{off}},Y]\operatorname{ad}A)$ at $Y=\Lambda^2(R)^{\mathsf T}W\Lambda^2(R)$, and it must be validated before it is quoted. A randomly rotated $S^3\times S^5$ starts at mass $0.9687$ and comes back to $4.9\times10^{-16}$, **from every one of $25$ starts** (all deciles $0.0000$). [b_diagonality_split.min_off_diagonal_mass](../scripts/lib/b_diagonality_split.py)'s own control only reaches $1.3\times10^{-2}$, so this instrument is the sharper one.

On the witness, descending from its own frame, the same instrument stalls at an off-diagonal mass of $0.352545$, below [b_diagonality_split](../scripts/lib/b_diagonality_split.py)'s recorded $0.373$, as a sharper minimiser should be, and fifteen orders of magnitude above where the control lands. It is stationary there rather than out of budget: the step size is driven to $10^{-16}$ with no further decrease. (A wider $80$-start sweep was still running when this report closed; on this machine [scipy.linalg.expm](https://docs.scipy.org/doc/scipy/reference/generated/scipy.linalg.expm.html) is caught by the same LAPACK pathology as the SVD and each start costs minutes.)

That number is a search and proves nothing on its own, which is exactly why E2′ matters. The two certificates above are what settle the question, and they agree with the search.

## Corrections owed to the record

1. **[bounds.md](../findings/bounds.md) line 141** says the mechanism behind the constancy "is not established" and explicitly rules out "a plane of self-dual forms inside a coordinate $4$-space". The mechanism **is** a plane of self-dual forms inside a $4$-space, a rotated one. Replace the negation with the positive statement: *the eigenspace is a $2$-plane in $\Lambda^2_+(U)$ for a $4$-dimensional $U\subset\mathbb R^8$ meeting the coordinate $\mathbb R^3$ and $\mathbb R^5$ in $2$-planes each; on $\Lambda^2_+(U)$, $\omega\wedge\omega=\lVert\omega\rVert^2\mathrm{vol}_U$, so the modulus is constant by an identity.*
2. **The same line** records Lemma L37 as inconclusive. It is not: two simple eigenvalues carry rank-$4$ eigenvectors, which is the lemma's own sufficient test. Non-diagonality has two independent certificates, and the cheaper one was available all along.
3. **$\lVert\omega\wedge\omega\rVert=0.5000$** is half the standard norm. Either restore the factor $2$ in [plucker_min](../scripts/lib/review_r56_core.py) and [wedge_norm](../scripts/reviewers/r283/c2_instruments.py) or label the convention where the $0.61/0.63/0.50$ controls are quoted.
4. **The witness is graded.** [bounds.md](../findings/bounds.md), [INDEX.md](../findings/INDEX.md), [plan.md](../plan.md), [results.md](../results.md) and [ATTEMPTS.md](../ATTEMPTS.md) all present $1.088948$ as the ceiling on the open target without recording that $\mathfrak{so}(8)=\mathfrak p\oplus\mathfrak m$ is a $\mathbb Z_2$-grading there with $\mathfrak p\cong\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ and trivial kernel. [run_f4b_graded_multi.py](../scripts/runs/run_f4b_graded_multi.py) was written to hunt exactly this object, "*is there a graded $S=0$ critical point with three or more positive eigenvalues?*", so the answer is yes, with five, and it belongs in the graded discussion as much as in the $\Delta>0$ one.
5. **[target.md](../findings/target.md) line 541**'s "*because $\Delta>0$ it is not graded*" is an invalid converse and should be restated as the $S_{\mathfrak{mpp}}$ computation that actually decides it.
6. **The margin sentence.** "The margin falls from $1.71\times$ to $1.12\times$" is true of $\{S=0,\Delta>0\}$ and false of the set that is open once the graded half is granted. Whichever half the record means, it should say which, because the grade of route V2 turns on it.

## What I could not break

- The screening. Unit norm is bitwise, and Bianchi/Ricci/trace rebuilt from the $4$-tensor rather than from [is_weyl](../scripts/lib/weyl_screen.py) all land at $10^{-16}$.
- The non-diagonality. Two independent certificates, a validated search agreeing with them, and a perturbation margin of $\sim0.35$ radians against a $10^{-14}$ uncertainty.
- The symmetric-criticality licence, which is exact rather than measured.
- $\theta$ and $\Delta$: rebuilt from the structure constants with no shared code, agreeing with the recorded $1.088948053$ and $1.512231$ to every digit quoted, and with the ledger's independently rebuilt $1.088948052463$ to $4\times10^{-11}$.

## Open, and worth a cycle

- **Does the family climb with $n$?** Every member found here sits below $S^3\times S^5$'s $1.115547$, itself below $\theta_0(8)=1.145644$. The interesting question is whether off-slice graded critical points of a symmetric pair can ever exceed the pair's two-eigenvalue point, if not, the graded half closes for a reason, and this family is the evidence rather than the threat.
- **Is the $n=12$ point at $0.716134$ graded?** Unchecked here. $C_5$ is definitely ungraded ($S_{\mathfrak{mpp}}=80$), so the ungraded ceiling is at least $0.670820$; whether it is $0.716134$ decides what the honest margin for V2 is.

*Scripts: [scripts/reviewers/r296/](../scripts/reviewers/r296/). Log: [agent_logs/r296-nondiagonal-witness.log](../agent_logs/r296-nondiagonal-witness.log).*
