# Step 9 literature sweep, 2026-09-23, second round

**On Fable, from [the position file](2026-09-23-step9-position-round2.md) and nothing else of the record whole.** *Appended after every batch. The first round is [here](2026-09-23-LIT-step9-sweep.md), and its R-C is the route [post F33](../findings/fence-posts.md) had already killed.*

**The screen every candidate meets first**: does its input survive a Weyl tensor, where scalar curvature, the Ricci part and every normalisation built from them vanish. Then the fence posts the position file lists, then a grep of [findings/](../findings/) for the mechanism's own name.

## Batch 0, the reframing this round starts from, already on the record

**In $W$'s own eigenframe the target is a cubic in the eigenvalues with nonnegative coupling**: $\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ ([stratum-two-negative.md](../findings/stratum-two-negative.md) line 594), with $T_{\alpha\beta\gamma}$ the squared structure constants of $\mathfrak{so}(n)$ in that frame. *Equivalently $\langle W^\#,W\rangle\propto\langle\Lambda^3(W)\,\omega,\omega\rangle$ for the Cartan 3-form $\omega$, which [isotropy-cap.md](../findings/isotropy-cap.md) already treats.* **So the stripped problem is: maximise a cubic with a FIXED diagonal part and a nonnegative coupling tensor that VARIES with the orthonormal frame, subject to linear (Bianchi, trace-free) constraints on $\lambda$.** The obstruction the pattern line names, eigenspace alignment, is exactly that $T$ moves with the frame.

## Batch 1, four fields at once, nothing proposable

| query | what came back | verdict |
|---|---|---|
| the Cartan 3-form as a calibration, its comass ([Lê, J. Geom. Phys. 70 (2013)](https://arxiv.org/abs/1103.1201)) | structure theorems for manifolds carrying a parallel simple Cartan 3-form, multisymplecticity iff semisimple | **no extremal statement about $\langle\Lambda^3(W)\omega,\omega\rangle$**, and the isotropy content is the record's [isotropy-cap.md](../findings/isotropy-cap.md) |
| Tkachev, idempotents and the Peirce spectrum in metrised algebras ([1808.03808](https://arxiv.org/abs/1808.03808), [2210.08245](https://arxiv.org/abs/2210.08245), [Fox, Forum Math. Sigma](https://www.cambridge.org/core/journals/forum-of-mathematics-sigma/article/commutative-nonassociative-algebra-of-metric-curvature-tensors/15155E41E20AB76E7EED7A5FD64A3E49)) | extrema of $\langle x\circ x,x\rangle$ on the sphere are idempotents, $\tfrac12$ is universal in the Peirce spectrum, medial and isospectral classes | **already the record's [I87](../plan.md)–[I89](../plan.md)**: the spectrum separates, the algebra is not medial, and the Fox product is on file |
| second-order conditions at a symmetric-tensor spectral-norm maximiser ([Qi–Wang–Wang](https://www.polyu.edu.hk/ama/staff/new/qilq/QWW.pdf), [1110.0541](https://arxiv.org/abs/1110.0541)) | Z-eigenvectors, $\nabla^2=m(m-1)\mathcal A x^{m-2}$, best rank-one approximation | the fixed-frame second-order test the record already runs; **nothing on a spectrum being forced two-valued** |
| Michel's theorem on critical orbits ([Michel–Zhilinskii, Phys. Rep. 341 (2001)](https://www.ihes.fr/~/vergne/LouisMichel/publications/PhysRep.341_11_2001.pdf)) | maximal strata carry critical points of EVERY invariant function, the inert states | **inert is not maximal**: the theorem places critical points and says nothing about which orbit carries the maximum |
| structure-constant sums over subspaces, "Lie algebra frame" | nothing beyond $B(X_a,X_b)=\gamma\gamma$ | no literature under this phrasing |
| arXiv 2025–2026 on the Lie algebra square as an algebraic extremal problem | nothing | confirms [post F64](../findings/fence-posts.md) under its own name for one more year |

## Batch 2, landscape arguments and nonnegative tensors: ONE mechanism survives the screens

| query | what came back | verdict |
|---|---|---|
| **Benedetto--Fickus, the frame potential has no spurious local minima** ([Mixon--Needham--Shonkwiler--Villar, three proofs](https://arxiv.org/abs/2112.02916), read from the PDF) | *Proof 1*: at a first-order critical non-tight frame take two eigenspaces $E,E'$ of the frame operator with eigenvalues $\alpha>\beta$, $u\in E'$, $v$ in the constraint kernel supported on the columns spanning $E$, $Y=uv^*$; the Lagrangian Hessian along $Y$ is $\propto\beta-\alpha<0$. *Proof 2* is convexity via Schur--Horn, *proof 3* is Kempf--Ness | **proof 1 is a mechanism the record does not name**: a second-order test direction that COUPLES two eigenspaces and lies in the constraint kernel, with the sign decided by the eigenvalue gap. Proofs 2 and 3 are closed here by the first round's Schur--Horn batch and by [post F66](../findings/fence-posts.md) |
| Perron--Frobenius for nonnegative symmetric tensors ([Chang--Pearson--Zhang](https://arxiv.org/abs/1104.0316), [Friedland--Gaubert--Han](https://www.sciencedirect.com/science/article/pii/S0024379511001765)) | the top Z-eigenvector of a nonnegative tensor is nonnegative, unique when irreducible | **the eigenframe cubic has nonnegative coupling but SIGNED weights**, trace-free forcing $\sum\lambda_\alpha=0$, so the Perron vector is excluded by the constraint and the theorem does not apply |
| the cubic Weyl bound in [Damene--Tyrrell 2603.03775](https://arxiv.org/abs/2603.03775), read from the PDF | a hypersurface computation in a Darboux frame with $W^+$ diagonal and $W^\pm$ equal-spectrum, the cubic expressed through the second fundamental form | **dimension four in the $3\times3$ trace-free picture**, which is the record's own $n=4$ case; no method for general $n$ |
| extremal cubics on $S^2$ ([2110.07946](https://arxiv.org/abs/2110.07946)) | local maxima of a cubic on $S^2$ at affinely independent points of equal value are global | two dimensions, no transfer |
| Tkachev--Fox, idempotents at local maxima | $L_c\vert_{c^\perp}\le\tfrac12$, $1$ simple | **this is [L24](../findings/second-order.md) verbatim**, on the record since 2026-08 |

## Batch 3, the hypergraph Lagrangian, ALREADY A STORED REFERENCE

[Liu--Ni--Wang--Kang, arXiv:2408.03122](../references/spectral-turan-hypergraph-2024/README.md) was stored on 2026-09-01 for exactly this analogy, the bracket tensor $T_{abc}$ as a weighted 3-uniform hypergraph, and its verdict reads *"the fallback register if the graph-level transfer stalls. Unread beyond the frame; notes owed before any claim is drawn from it."* **So the field is on file and was never worked.** *Motzkin--Straus and the Frankl--Füredi line ([1211.6508](https://arxiv.org/abs/1211.6508), [1312.7529](https://arxiv.org/abs/1312.7529)) put a hypergraph Lagrangian's maximiser uniformly on a clique, which is the two-value shape.* **What blocks the transfer**: the simplex and nonnegative weights, where the eigenframe cubic has signed weights on a sphere and a coupling tensor that moves with the frame. *Recorded as searched; not proposed as a route, because the mechanism would have to be re-invented for signed weights, which is `attackable` $1$ by the scale.*

**A concern raised and settled from the record during this batch.** *$W_{\mathbb{CP}^2}$ has three values on $\Lambda^2$, $\{2c,-c,-c,0,\dots\}$, and $W^2\notin\operatorname{span}\{W,\mathrm{Id}\}$ there, so for a moment [R30](../routes.md)'s target looked false at the extremiser.* **It is not**: the goal is $n\ge12$ with the maximiser on products of spheres, whose spectrum is two-valued (pure against mixed, multiplicities $n(n-2)/4$ and $n^2/4$, the $r$ [L105](../findings/bounds-relaxations.md) names), and padded $\mathbb{CP}^2$ is a NON-diagonal critical point at $\sqrt{3/2}<\Theta_n$, the very thing the open statement bounds. *Written down so the next sweep does not spend the same twenty minutes.*

## Batch 4, the position file's three remaining fields, searched and empty

| field | what came back | verdict |
|---|---|---|
| Euclidean Jordan algebras and their cubic trace form | the classical picture: $\operatorname{tr}(x^3)$ on the sphere is maximised at primitive idempotents, spectral cones, rank-three Cayley--Hamilton ([Spectral cones](https://www.sciencedirect.com/science/article/pii/S0024379516303317), [1211.7223](https://arxiv.org/abs/1211.7223)) | the two-value conclusion holds there because the GRADIENT is a polynomial in $x$; here the gradient carries $W^\#$, which is the whole difficulty. **No Jordan structure on $\Lambda^2$ makes $\#$ a polynomial in $W$**, and none was found |
| symmetric criticality and torus fixed points ([Palais, PSC](https://arxiv.org/abs/math-ph/9910014)) | PSC places critical points in fixed-point sets, never maxima | same verdict as Michel's theorem in batch 1 |
| spherical designs and cubature identities for $\mathfrak{so}(n)$ bases ([1204.1779](https://arxiv.org/abs/1204.1779)) | Hilbert identities and invariant cubature | averaging identities over the whole basis are the marginals [post F6](../findings/fence-posts.md) and [post F42](../findings/fence-posts.md) already exhaust; nothing on a third moment |

**Recorded as searched, nothing found, so the next sweep does not repeat them.** *Twenty-one queries across ten fields this round.*

## Phase 3, the routes, graded on section 1's rubric

**Every candidate met the screens in this order**: the input survives a Weyl tensor; the six posts in the position file; a grep of [findings/](../findings/) for the mechanism's own name; and, for R-D, the seven closures behind [post F39](../findings/fence-posts.md), whose successor clause it must clear.

| route | mechanism | closes | attackable | margin | analytic | value | how close to P |
|---|---|---|---|---|---|---|---|
| **R-D, the eigenspace-pair second-order test** | at a maximiser with three or more values, take $u\in E_\alpha$, $v\in E_\beta$, $\alpha\ne\beta$, and the admissible direction $Y=\pi_{\mathcal W_n}(u\odot v)$, which is automatically $\perp W$; [L125](../findings/second-order.md) then gives $\langle Y,L_eY\rangle\le\tfrac12\lVert Y\rVert^2$ for EVERY such pair, one inequality in $(\lambda,T)$ per pair, to be run against the first-order per-index rows | 2 | **2** | 1 | 1 | **4** | an instrument for [I73](../plan.md) sub-step (ii): it settles nothing alone and is what that sub-step lacks. *Closing it leaves L105's finish, which is done* |
| **R-E, hypergraph-Lagrangian symmetrisation** | Motzkin--Straus shifting on the eigenframe cubic, weight moved between vertices with equal links | 2 | 1 | 1 | 1 | 2 | the field is [stored and unread](../references/spectral-turan-hypergraph-2024/README.md); the mechanism needs re-inventing for signed weights on a sphere |
| **R32, invariant curvature cones** | unchanged from the first round | 2 | 1 | 1 | 1 | 2 | a research programme, as the first round said |

**Why R-D and not more.** *Ten fields, twenty-one queries, and one mechanism the record does not name.* The Benedetto--Fickus first proof is the only thing found whose shape is a SECOND-ORDER argument forcing a spectrum to collapse, and its ingredients all exist here: the eigenvalue bound is [L24](../findings/second-order.md), the off-$W^\perp$ form is [L125](../findings/second-order.md), the first-order rows in the eigenframe are the record's per-index relations, and the coupling tensor $T_{\alpha\beta\gamma}$ is the frame's structure constants squared.

**What R-D borrows, and the domain of each.** *L24 and L125 hold at a local maximiser with $\theta>0$, automatic at a global one. $T_{\alpha\beta\gamma}$ is defined in the eigenframe of ANY $W$. The per-index relations hold at any critical point. The projection $\pi_{\mathcal W_n}$ is what makes $Y$ admissible and is where the alignment enters: for $u\in\Lambda^+$, $v\in\Lambda^-$ at $n=4$ it is ZERO, so the test is empty across that pair, and the first sub-step has to say for which pairs it is nonempty.*

**What running it takes.** (i) Derive $\langle Y,L_eY\rangle$ for $Y=\pi(u\odot v)$ in closed form, the unprojected value being $\tfrac12(\lambda_\alpha+\lambda_\beta)+\kappa\sum_\gamma\lambda_\gamma T_{\alpha\beta\gamma}$ with $\kappa$ the record's $\#$ normalisation, and the projection's correction beside it. (ii) Screen it at the record's non-diagonal critical points, padded $\mathbb{CP}^2$ and the $n=8$ witness of F39, seconds of arithmetic. (iii) Combine the pair inequalities with the per-index rows at three values and ask whether $\theta>\sqrt{3/2}$ survives.

**What falsifies it.** *A witness at which every pair direction scores at most $\tfrac12$ AND the combined system admits a three-value solution above $\sqrt{3/2}$*, which would be F39's eighth closure and would say second-order optimality does not see the spectrum at all.

**Why `attackable` is 2 and not 3.** The pair family is untried, and it is the seventh-plus attempt to draw a test direction from second-order optimality on this problem, [F39](../findings/fence-posts.md) recording that the previous seven found none. *A route with an untried step and a spent shape is partly spent by the scale.*

**The recommendation names an order, and it is ONE route.** Work R-D and stop there. R-E is registered so the stored reference stops reading as a live lead, and R32 stays where the first round put it. **If R-D's sub-step (ii) fails**, F39 gets its eighth row and the programme records itself as waiting on an instrument, which is the position the decisions file already names as the honest alternative.

