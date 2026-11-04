# Reviewer 118, the product bound $\Pi\le2\sqrt6$: two witnesses retire it

Gate 2, adversarial. Independent implementation written from the definitions alone; the project's scripts were opened only after every number below existed, and then only to cross-check. Verdicts on the four claims of [bounds.md](../findings/bounds.md) §"the bound sharpens for free" … §"where $\Pi\le2\sqrt6$ fails", plus the adjudication [plan.md](../plan.md) asked for.

| # | claim | verdict | the number that decides it |
|---|---|---|---|
| 1 | the sharpening $\theta\le[\Pi-\lambda^+_{\min}\Delta]/4$ | **CONFIRMED**, and inert where it matters | gain $=0.000000$ at every $\Delta=0$ point; $0.004$–$0.18$ at random $W$ |
| 2 | the reduction $\Pi\le2\sqrt6\Rightarrow\sup\theta\le\sqrt{3/2}$ | **CONFIRMED but vacuous**, the hypothesis is false | $\Pi=5.726473$ at a *critical*, $S=0$, non-diagonal point at $n=12$ |
| 3 | $\Pi(\text{padded }W_{\mathbb{CP}^2})=2\sqrt6$ at every $n$ | **CONFIRMED** as a theorem, every step | $\Pi-2\sqrt6\le8.9\times10^{-16}$ at $n=4,5,6,7,9,10,12,13$ |
| 4 | two eigenvalues $+\ \Delta=0\Rightarrow$ equality; crossover $n>6+2\sqrt7$ | **CONFIRMED**, one hypothesis superfluous | $\Pi-2\sqrt6=-0.683,-0.316,-0.099,+0.045,+0.148$ at $n=6,8,10,12,14$ |
| 5 | the failure at balanced products "carries no information" | **REFUTED** | $\Pi=4.954462>2\sqrt6$ and $\theta=1.236031>\sqrt{3/2}$ at a **non-diagonal** $S=0$ point at $n=12$ |

## The implementation, and what anchors it

$\mathfrak{so}(n)$ in the orthonormal basis $E_{ij}$ for $\langle A,B\rangle=\mathop{\mathrm{tr}}(A^{\mathsf T}B)/2$; structure constants $c_{\alpha\beta\gamma}$ by direct bracket; $R_{ijkl}$ read off the operator; first Bianchi and Ricci imposed as a linear system whose nullspace dimension reproduces $n(n+1)(n+2)(n-3)/12$ ($35,84,168,300$ at $n=5,6,7,8$), before anything else was computed. The only convention that had to be fixed by hand is the $\tfrac12$ in $W^\#$, and it is fixed twice over independently: it is the unique normalisation giving $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$ and $\theta(S^k\times S^k)=\theta_0(2k)$. With it, criticality residuals are $\le3\times10^{-16}$ and **both recorded contractions reproduce exactly**: $\sum_\gamma g_\gamma=4(n-1)$ and $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ at every point tested.

Two diagonality certificates, both used:

- **necessary condition.** If $W$ is diagonal in some orthonormal frame then every $A$ diagonal in that frame has $[W,\delta_A]=0$, so $\dim\ker\Phi_W\ge n$. $\dim\ker\Phi_W<n$ therefore certifies non-diagonality.
- **sufficient refutation, frame-free.** A coordinate-diagonal $W$ has an eigenbasis of decomposables, so a **simple** eigenvalue's eigenvector must have bivector rank $2$. A simple eigenvalue with an eigenvector of rank $>2$ certifies that $W$ is diagonal in **no** frame.

Controls behave: $S^6\times S^6$ returns $\dim\ker\Phi_W=42$ and no high-rank simple eigenvector; padded $W_{\mathbb{CP}^2}$ returns the rank-$4$ Kähler form at the simple eigenvalue $0.8165$, reproducing the record's own frame-independence claim.

## 1. The sharpening, CONFIRMED, and it gains nothing where the bound is tight

The proof is correct as written. $4\theta=\sum_{\mathfrak m}|\lambda_\gamma|g_\gamma-\sum_{\mathfrak p}\lambda_\gamma g_\gamma$, then $|\lambda_\gamma|\le|\lambda_{\min}|$ on $\mathfrak m$ and $\lambda_\gamma\ge\lambda^+_{\min}$ on $\mathfrak p$. No violation at $24$ random Weyl tensors at $n=5,6,7,8$, and the sharpened value is never above the recorded one.

"Equality between them exactly when $\Delta=0$" is also right, and the reason the claim does not give is worth recording: $\mathop{\mathrm{tr}}W=0$ with $\lVert W\rVert=1$ forces $\mathfrak p\ne\emptyset$, so $\lambda^+_{\min}>0$ strictly and $\lambda^+_{\min}\Delta=0\iff\Delta=0$. The degenerate reading ($\mathfrak p$ empty, $\lambda^+_{\min}$ undefined), cannot occur.

**What the claim quietly excludes is its own use case.** All nine equality points on record have $\Delta=0$, so the gain there is exactly $0.000000$; the measured gain lives entirely at random points, where the parent bound already has $0.1$–$1.4$ of slack. The sharpening is real and free and changes no verdict anywhere on the target set.

**And the sentence justifying that in [run_lambda_product.py](../scripts/runs/run_lambda_product.py) is false.** It reads: "the recorded bound's failure is entirely at $\Delta=0$, and $\Delta=0$ on $\{S=0\}$ with trivial kernel means $W$ is GRADED, a case step H already owns." Witness A below has $S=1.1\times10^{-28}$, $\ker W=0$, $\Delta=2.04\times10^{-5}>0$, and $\theta=1.236031>\sqrt{3/2}$. It is also the falsifier named at [bounds.md](../findings/bounds.md) for the open question *does $\theta>\sqrt{3/2}$ force $\Delta=0$?*, "a point with $\theta>\sqrt{3/2}$, trivial kernel and $\Delta>0$". The answer is **no**, unless that question silently means critical points.

## 2. The reduction, a true implication whose hypothesis is false, and which is nowhere easier than the target

As an implication it is one line of chaining and it is correct: $\theta\le\Pi/4\le2\sqrt6/4=\sqrt{3/2}$, with $\sup$ over the same set on both sides. There is no gap.

**The tautology is structural, and it is the reason the reduction cannot help.** By claim 1's own equality analysis, $\theta=\Pi/4$ exactly on $\{\Delta=0\}$. So on $\{\Delta=0\}$ the proposed inequality $\Pi\le2\sqrt6$ *is* the target $\theta\le\sqrt{3/2}$, restated, and $\{\Delta=0\}$ contains every point where the target is hard: all nine symmetric-space points, all three frontier points at $\sqrt{3/2}$, and the balanced products. Off $\{\Delta=0\}$ the reduction is *strictly stronger* than the target, since $\theta\le(\Pi-\lambda^+_{\min}\Delta)/4<\Pi/4$. A reduction that is equivalent to its target where the target bites and strictly stronger everywhere else can only be harder. Claim 2 buys a change of variables, not a reduction.

**And it is worse than harder: it is false.** See §5.

## 3. Sharpness at padded $W_{\mathbb{CP}^2}$, CONFIRMED, step by step

Every ingredient reproduces, independently:

| step | claimed | measured |
|---|---|---|
| row marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ | $4,8,12$ at $n=4,6,8$ | $\{4.0\},\{8.0\},\{12.0\}$, every row |
| $\kappa^2$ on $\Lambda^+\cong\mathfrak{su}(2)$ | $2$ | $\{0,2\}$ exactly |
| $g_\gamma$ for each $\gamma\in\mathfrak m$ | $18\kappa^2c^2=6$ | $\sum_{\mathfrak m}g=12.000000000000$ at every $n$ |
| $\Pi$ | $2\sqrt6$ | $4.898979485566$, error $\le8.9\times10^{-16}$, at $n=4,5,6,7,9,10,12,13$ |

The three vanishing arguments in step (ii) are exhaustive and I re-derived each: $[\Lambda^+,\Lambda^-]=0$ and $[\Lambda^-,\Lambda^-]\subseteq\Lambda^-$ kill the anti-self-dual pairs; padded–padded pairs are killed by the weight, and this is the only place the weight does the work, those brackets *do* reach $\Lambda^+$, since $[e_i\wedge e_a,e_j\wedge e_a]=e_i\wedge e_j\in\mathfrak{so}(4)$; padded-with-$\mathfrak{so}(4)$ brackets land in the mixed block. Nothing is missing, and the claim holds at **odd** $n$ too, which the write-up does not say.

Two things the lemma uses without naming. The eigenbasis of the kernel is not unique, and the argument is legitimate only because $g_\gamma=\lVert[\mathop{\mathrm{ad}}v_\gamma,W]\rVert^2$ is independent of that choice. And $\Delta=0$ at this point is *not* incidental, $g$ vanishes on the top eigenvector because the two negative eigenvalues are **equal**, so the weight $(\lambda_--\lambda_-)^2$ vanishes; that is what puts padded $W_{\mathbb{CP}^2}$ into the equality case of claim 1 at all.

**The case it quietly excludes is the one that kills the route.** Padded $W_{\mathbb{CP}^2}$ at $n=12$ has $\dim\ker W=63$ and is an orthogonal sum $W_{\mathbb{CP}^2}\oplus0$ on $\mathbb R^4\oplus\mathbb R^8$. Witness B below is $c_2W_{\mathbb{CP}^2}\oplus c_1W_{S^4\times S^4}$ on the same $\mathbb R^4\oplus\mathbb R^8$ (the same shape, both critical, both $S=0$, both non-diagonal), with $\Pi=5.726473$. Any hypothesis added to exclude the second excludes the first, and with it the reduction's claimed sharpness.

## 4. The crossover, CONFIRMED, with one superfluous hypothesis

The equality lemma is correct and the arithmetic is exact. Measured: $\Pi/4=\theta=\theta_0(2k)$ at $k=3,\dots,7$ to $10^{-15}$, with $\Delta=0$ and $G_0=0$ throughout, and $\Pi-2\sqrt6=-0.683,-0.316,-0.099,+0.045,+0.148$ at $n=6,8,10,12,14$. The polynomial is right: $\theta_0(n)>\sqrt{3/2}\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.2915$, so $n=12$ is the first even dimension of failure.

**"At a critical point" is doing no work.** The proof uses only that $\mathfrak m$ is one eigenspace and $\Delta=0$; criticality appears nowhere in it, and the lemma holds verbatim for any two-eigenvalue $W$ with $\Delta=0$. Stating it for critical points makes the result look narrower than it is and hides that it is a statement about the spectrum alone.

**"Two eigenvalues and $\Delta=0$ (both on record)" is one fact, not two.** For a $\mathbb Z_2$-graded $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$, brackets reaching $\mathfrak k$ come only from $[\mathfrak k,\mathfrak k]$ and $[\mathfrak m,\mathfrak m]$, and both pair equal eigenvalues, so the weight annihilates them: $\Delta=0$ *follows* from the two-eigenvalue grading. Worth recording as a derivation rather than as a measured input.

## 5. The adjudication, the "no information" defence is REFUTED, twice

The defence is: $\Pi>2\sqrt6$ at the balanced products is forced by the bound's exactness there, and those points are diagonal, so the hypothesis of the target excludes them. The hidden problem is a topological one. **The diagonal operators are a closed set; non-diagonality is an open condition.** So a diagonal point sitting above the threshold contaminates its whole neighbourhood, and the question is only whether $\{S=0\}$ reaches into that neighbourhood off the diagonal locus. It does.

### Witness A, non-diagonal, $S=0$, $\Pi>2\sqrt6$, and $\theta>\sqrt{3/2}$, at $n=12$

Fix $\mathbb R^{12}=\mathbb R^6\oplus\mathbb R^6$ and the induced grading $\mathfrak{so}(12)=\mathfrak k\oplus\mathfrak m$, $\dim\mathfrak k=30$, $\dim\mathfrak m=36=\lfloor n^2/4\rfloor$. Any Weyl $W$ preserving the grading with $W|_{\mathfrak k}\succ0$ and $W|_{\mathfrak m}\prec0$ has its negative eigenspace inside $\mathfrak m$, which is isotropic for the Cartan 3-form because $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$, so $S(W)=0$ **identically on that set**, with no tuning. The set is open in the space of graded Weyl tensors, which I computed to be **$834$-dimensional** at $n=12$ (against $\dim\mathrm{Weyl}_{12}=1638$), and it contains $W_{S^6\times S^6}$.

The diagonalizable Weyl operators form a closed set of dimension at most $\dim SO(n)+\dim\{\text{hollow symmetric, zero row sums}\}=66+54=120$. Since $120<834$, the diagonal locus has empty interior inside the graded space, so **non-diagonal $S=0$ Weyl operators accumulate at $W_{S^6\times S^6}$**, and by continuity of $\theta$ and $\Pi$,

$$\sup\{\theta:S=0,\ \text{non-diagonal}\}\ \ge\ \theta_0(n)\ >\ \sqrt{3/2},\qquad \sup\{\Pi:S=0,\ \text{non-diagonal}\}\ \ge\ 4\theta_0(n)\ >\ 2\sqrt6$$

for every even $n\ge12$. That is a proof, not a measurement; the explicit point confirms it. Taking $V$ a generic element of the $834$-space and $W_t=(W^*+tV)/\lVert\cdot\rVert$ at $t=0.001$:

| quantity | value |
|---|---|
| Weyl residual (Bianchi, Ricci, $\lVert W\rVert-1$) | $2.2\times10^{-16}$ |
| $S$ | $1.1\times10^{-28}$ |
| $\dim\ker\Phi_W$ | $\mathbf 1$ (against $\ge n=12$ for any diagonal $W$) |
| simple eigenvalues with eigenvector of bivector rank $12$ | many; the spectrum is $66$ distinct values |
| $\dim\ker W$ | $0$, so $W$ is $\perp$-**indecomposable** |
| $\Delta$ | $2.04\times10^{-5}>0$ |
| $\theta$ | $\mathbf{1.236031160}$ against $\sqrt{3/2}=1.224744871$ |
| $\Pi$ | $\mathbf{4.954461706}$ against $2\sqrt6=4.898979486$ |

**So the target as it is written in [findings/INDEX.md](../findings/INDEX.md), [plan.md](../plan.md), [target.md](../findings/target.md) and [bounds.md](../findings/bounds.md) ($\sup\{\theta:S=0,\ W\text{ non-diagonal}\}\le\sqrt{3/2}$), is FALSE at every even $n\ge12$.** The missing hypothesis is **criticality**. It is carried in the Route B architecture ("the maximizer is a critical point, so it suffices to control the critical set") and in [plan.md](../plan.md)'s falsifier line, and it is dropped from every statement of the target and of the reduction. Witness A is not critical (residual $1.4\times10^{-3}$), so it costs the programme nothing mathematically, but it means no proof of $\Pi\le2\sqrt6$ on the stated set can exist, and the four Gate 2 rounds spent on the stated set were spent on a false statement.

### Witness B, the same, but CRITICAL, at every even $n\ge12$

Orthogonal sums are the blind spot. $\theta$ is subadditive on them ($1/\theta^2=1/\theta_1^2+1/\theta_2^2$, the record's own lemma) but $\Pi$ is **not**: one summand can supply $|\lambda_{\min}|$ while the other supplies $\sum_{\mathfrak m}g$, and the product of the two maxima is charged to a single point. Take $W=(\theta/\theta_1)W_{S^k\times S^k}\oplus(\theta/\theta_2)W_{\mathbb{CP}^2}$ on $\mathbb R^{2k}\oplus\mathbb R^4$:

| $n$ | $\theta$ | criticality residual | $S$ | non-diagonal? | $\Pi$ | $\Pi-2\sqrt6$ |
|---|---|---|---|---|---|---|
| $10$ | $0.798935$ | $2.1\times10^{-16}$ | $0$ | yes | $4.419643$ | $-0.479$ |
| $12$ | $0.836660$ | $4.2\times10^{-16}$ | $0$ | yes | $\mathbf{5.726473}$ | $+0.827$ |
| $14$ | $0.857143$ | $2.7\times10^{-16}$ | $0$ | yes | $\mathbf{6.927114}$ | $+2.028$ |
| $16$ | $0.869989$ | $5.5\times10^{-16}$ | $0$ | yes | $\mathbf{8.077328}$ | $+3.178$ |

$S=0$ holds exactly: $[\mathfrak m_1,\mathfrak m_2]=0$ between orthogonal blocks, $[\mathfrak m_1,\mathfrak m_1]\subseteq\mathfrak k_1$, and inside $\Lambda^+$ the bracket of the two $(-c)$-eigenvectors is the top eigenvector. Non-diagonality is certified frame-free: the simple eigenvalue $0.557773$ carries the $\mathbb{CP}^2$ Kähler form, of bivector rank $4$, the same certificate the record uses for padded $W_{\mathbb{CP}^2}$ itself. And $\Pi\to\infty$ along the family as $k\to\infty$, so **$\Pi$ is unbounded on $\{S=0,\ \text{non-diagonal},\ \text{critical}\}$**, the falsifier [plan.md](../plan.md) item 3 names, in its strongest form.

Adding criticality does not save the reduction. Adding $\perp$-indecomposability would exclude witness B, and would exclude padded $W_{\mathbb{CP}^2}$ at every $n>4$ with it, which is the reduction's own sharpness point, and would leave witness A, which is indecomposable. **The two witnesses have disjoint escapes; no single hypothesis removes both.**

### What is left standing

$\theta\le\Pi/4$ is a theorem and stays one. What dies is the claim that $\Pi\le2\sqrt6$ is a *reformulation* of the target: on $\{\Delta=0\}$ it is the target verbatim, and off it, it is a strictly stronger statement that is false on an explicit, critical, $n$-unbounded family. The recorded justification ("the failure carries no information against the route"), is exactly backwards: the failure at the balanced products is the first term of a family that reaches into the non-diagonal set and does not stop.

## Disagreements with the record, itemised

1. **[bounds.md](../findings/bounds.md), "the failure carries no information against the route"**, refuted. Two witnesses above; the falsifier the same section names is met.
2. **[bounds.md](../findings/bounds.md) and [run_lambda_product.py](../scripts/runs/run_lambda_product.py), "the recorded bound's failure is entirely at $\Delta=0$"**, false. Witness A: $\Delta=2.04\times10^{-5}$, $\ker W=0$, $\theta>\sqrt{3/2}$.
3. **The named open question "does $\theta>\sqrt{3/2}$ force $\Delta=0$?"**, answered **no** by witness A, for the question as literally posed. If it was meant of critical points only, it should say so.
4. **The target statement itself**, in all four places it appears, omits criticality and is false as written at every even $n\ge12$.
5. **[problem.md](../findings/problem.md) item 12**, "None [of the subalgebra family] is coordinate-diagonalizable", the balanced sphere product is a member ($\mathfrak h=\mathfrak{so}(k)\oplus\mathfrak{so}(k)$ gives $a/b=-(N-r)/r=-k/(k-1)$, the sphere-product ratio) and it *is* coordinate-diagonal, with $\dim\ker\Phi_W=42$. Minor, but the sentence is used to certify non-diagonality of that family.
6. **The screen's catalogue is blind by construction.** [run_lambda_product.py](../scripts/runs/run_lambda_product.py) tests balanced and unbalanced sphere products and padded $W_{\mathbb{CP}^2}$, every one either diagonal or a single padded symmetric space. No $\perp$-sum of two nonzero critical points, and no non-diagonal point off the named list, appears anywhere in it. Both witnesses were unreachable by it.

**No convention disagreement.** Both witnesses were re-run through the project's own `bounds()` in [run_lambda_product.py](../scripts/runs/run_lambda_product.py) after my numbers existed, and it returns them to nine digits: witness A $\theta=1.236031160$, $\Pi=4.954461706$; witness B $\theta=0.836660027$, $\Pi=5.726473070$. The disagreement is about which points exist, not about how they are measured.
