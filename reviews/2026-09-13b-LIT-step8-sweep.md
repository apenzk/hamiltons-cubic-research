# Literature sweep, 2026-09-13b

**Run on Fable after the user's switch, from [2026-09-13b-step8-position.md](2026-09-13b-step8-position.md) alone, appending after every batch.** *The target is one inequality, $\theta\le\sqrt{3/2}$ at every non-diagonal critical point, and a candidate that does not bear on it is not a candidate.*

## Batch 0: the record screened first, by mechanism, before any search

**Ten mechanisms greped across [findings/](../findings/), [ATTEMPTS.md](../ATTEMPTS.md), [reviews/](.) and [references/](../references/), to know what a search would only repeat.**

| mechanism | on the record | what the record says |
| --- | --- | --- |
| symmetric criticality, Palais | yes, 3 findings, 11 reviews | gives NECESSITY, the sphere product is critical for free, and nothing about maximality ([problem.md](../findings/problem.md)) |
| symmetric-tensor Z-eigenvectors, odeco | searched twice, [2026-09-03b](2026-09-03b-LIT-step8-sweep.md) and [2026-09-10](2026-09-10-LIT-step8-sweep.md) | nothing bearing on which eigenvector maximises |
| Fox algebra idempotents, Peirce spectrum | 28 reviews, 17 references | the algebra is not medial ([I88](../plan.md)), so the classification is unavailable |
| Hamilton's reaction term, pinching cones | 5 reviews, 4 references, [F58](../findings/INDEX-traps.md) | $\ell_{a,b}$ is the identity on Weyl tensors, so the pinching machinery is inert here |
| $\theta$-groups, Cartan subspaces, GIT | [reeder-2013](../references/reeder-2013-gradings-positive-rank/), [F66](../findings/INDEX-traps.md) | no reductive group gives $\mathcal W_n$ a minimal-vector structure |
| harmonic cubics, isoparametric | [fox-2019-harmonic-cubics](../references/fox-2019-harmonic-cubics-hessian/), [F65](../findings/INDEX-traps.md) | the trace-form bound's input is exhausted |
| pure curvature operators | [2026-09-12](2026-09-12-LIT-step8-sweep.md) route 2 | closed within a day |
| Motzkin--Straus, graph and hypergraph Lagrangians | 1 review, 0 findings | **UNSCREENED as a mechanism**: the diagonal half was settled through strongly regular parameters, and this is the theorem that makes clique structure extremal for a quadratic on a simplex |
| hyperoctahedral group as the diagonal locus's stabiliser | 2 reviews | named, never used as a route |
| Waterhouse, "do symmetric problems have symmetric solutions" | 1 reference in passing | unscreened |

**So three angles are genuinely unsearched, and every other one a search would only repeat.**

## Batch 1: the three unsearched angles, and one stripped of names, four searches in parallel

**Motzkin--Straus.** *The theorem and its hypergraph generalisations connect a graph's clique number to the maximum of its Lagrangian over the simplex, and [Nesterov](https://optimization-online.org/tag/motzkin-straus-theorem/) expressed the clique and stability numbers as maxima of CUBIC FORMS OVER THE UNIT SPHERE.* **So the shape "a cubic on a sphere is maximised at the most symmetric combinatorial configuration" is a theorem in that field.** *Bearing on the target: the diagonal half of this problem has exactly that shape, a hollow matrix with zero row sums maximising a cubic, and it is PROVED, through strongly regular parameters. The non-diagonal half is not a graph functional, so the mechanism does not transfer as stated. Recorded as a shape, not a route.*

**Waterhouse 1983.** *Linear programmes have an optimal solution in the fixed set of their symmetry group.* **Necessity in a convex setting, the same content as symmetric criticality**, which the record already holds as giving necessity and not maximality. Nothing.

**An invariant cubic maximised on a reflection subgroup's fixed set.** Four phrasings, nothing: the results returned are general reflection-group invariant theory with no extremal statement. **Consistent with [F64](../findings/INDEX-traps.md).**

**Stripped of names, the Ricci-flow phrasing.** *Two hits worth reading rather than skimming, both to be screened against the shelf before anything is claimed:* [Weyl tensors, strongly regular graphs, multiplicative characters, and a quadratic matrix equation](https://www.sciencedirect.com/science/article/abs/pii/S0021869323004350), whose title names the record's own objects, the diagonal Weyl tensors as strongly regular graphs and the criticality equation as a quadratic matrix equation; and [On some new Ricci flow invariant curvature conditions](https://arxiv.org/html/2412.13633v1), which gives quantitative evidence for an unpublished conjecture of Böhm and Wilking. *What each settles is batch 2.*

## Batch 2: both batch-1 hits are on the shelf, and both are mined to the bottom

**[Deninger--Grundhöfer--Kramer](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/README.md)** *studies exactly the record's DIAGONAL criticality equation, hollow $S$ with zero row sums and $S^2+S^{\circ2}=\theta S$ off the diagonal, fully transcribed since 2026-09-02, with its Theorem 5.1 being the record's [Lemma 74](../findings/diagonal-half.md) and its forward citations none.* **It is the diagonal half, which is proved, and says nothing about a non-diagonal critical point.** The title surfaced because the search was phrased in the record's own objects, which is the one phrasing that finds only what the record has.

**[Xu 2024](../references/xu-2024-ricci-flow-invariant-conditions/README.md)**: *the "unpublished conjecture of Böhm and Wilking" IS this programme's conjecture, stated verbatim, and the paper is the origin of [fence post 1](../findings/INDEX-traps.md), that no purely eigenvalue-based inequality can close the gap, since its Tachibana bound on $\mathop{\mathrm{tr}}W^3$ is sharp and that term is negligible at the maximiser.* Nothing new.

**Net of batches 1 and 2: four shape-hits and two already-filed sources, no method.** *Consistent with the four previous sweeps.*

## Batch 3: the equation $R^2+R^{\#}=\lambda R$ as a classification problem, two searches

**Critical points of $P$ on the sphere are exactly the fixed points of the normalised Hamilton ODE**, so the open statement is a statement about all solutions of $R^2+R^{\#}=\lambda R$ in $\mathcal W_n$. *Searched under that phrasing and under the sources the record already knows to be about it.* **Nothing new**: the returns are the Ricci-flow-invariant-cone literature ([Böhm--Wilking](https://annals.math.princeton.edu/wp-content/uploads/annals-v167-n3-p10.pdf), [Brendle](https://arxiv.org/pdf/0706.1218), [noncoercive cones](https://arxiv.org/pdf/1308.1190)), all on the shelf, and none classifies the fixed points. *The only classification of any fixed-point family is [Deninger--Grundhöfer--Kramer](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/README.md)'s, of the DIAGONAL ones, whose Conjecture 8.1 is about that family alone.*

**One incidental hit for the PROVED half**: [Poincaré polynomials and curvature operators of symmetric spaces](https://arxiv.org/abs/2508.11236), explicit curvature operators of every compact irreducible symmetric space, with $\lambda_{\max}$ bounded by the Einstein constant and equality exactly at the Hermitian ones. *Bears on [L47](../findings/problem.md)'s census, which is proved, so it is a possible citation for the record and not a route; screened against the shelf in batch 4.*

## Batch 4: two sources absent from the shelf, both by the author of the record's primary algebraic source, one published after every previous sweep

**Stored**: [fox-2022-sectional-nonassociativity](../references/fox-2022-sectional-nonassociativity/), Daniel Fox, arXiv:2211.01073, 26 pages; and [fox-tkachev-2026-palintropic](../references/fox-tkachev-2026-palintropic/), Fox and Tkachev, arXiv:2606.27496, submitted 2026-06-25. *Both PDFs checked as PDFs and extracted.*

**THE FIRST DEFINES A SECTIONAL-CURVATURE ANALOGUE FOR THE EXACT CLASS THE WEYL ALGEBRA BELONGS TO, AND ITS SECTION 8 IS ABOUT IDEMPOTENTS OF THAT CLASS.** *A Euclidean metrised commutative algebra is a commutative algebra with an invariant inner product, which $(\mathcal W_n,\circ,\langle,\rangle)$ is. Its sectional nonassociativity on a plane spanned by $x,y$ is $K(x,y)=\big(\langle x\circ x,y\circ y\rangle-|x\circ y|^2\big)/|x\wedge y|^2$, with the associator in place of the covariant derivative.* Read at the theorems, lines 1195 to 1345 of the extraction:

> **Lemma 8.2.** Let $(A,\circ,h)$ be a Euclidean metrized commutative algebra of dimension $n\ge2$. If $0\ne e$ is idempotent, then $4K(e,x)\le|e|^{-2}$ for all $x$ with $x\wedge e\ne0$, with equality if and only if $x-h(e,e)^{-1}h(e,x)e\in\ker(L_\circ(e)-\tfrac12\mathrm{Id})$.

*Its proof is display (8.5): with $x=\sum x_i$ over an $h$-orthogonal eigenbasis of $L_\circ(e)$ on $e^\perp$ with eigenvalues $\lambda_i$,* $$K(e,x)=|e|^{-2}\sum_i\lambda_i(1-\lambda_i)\,\frac{|x_i|^2}{|x|^2},$$ *a convex combination of $\lambda_i(1-\lambda_i)$.*

> **Lemma 8.3.** (1) If $K(U)\le b$ for all planes $U\ni e$, then $\mathrm{Spec}^\perp(e)\subset(-\infty,\tfrac{1-\sqrt B}2]\cup[\tfrac{1+\sqrt B}2,\infty)$, $B=\max\{1-4b|e|^2,0\}$. (2) If $K(U)\ge b$ for all such $U$, then $b\le1/(4|e|^2)$ and $\mathrm{Spec}^\perp(e)\subset[\tfrac{1-\sqrt B}2,\tfrac{1+\sqrt B}2]$.

**WHAT THIS SAYS AT A CRITICAL POINT OF $P$.** *$e=W/\theta$ is idempotent with $|e|^2=1/\theta^2$ at unit norm, and the record has $\tfrac12\in\mathrm{Spec}^\perp(e)$ at every critical point, on the orbit tangent ([L24](../findings/second-order.md)'s reading, criticality alone). So by Lemma 8.2's equality case,* $$\theta^2=4\max_{x\perp e}K(e,x),$$ *the maximum attained exactly on the $\tfrac12$-eigenspace.* **Hence $\sup_{\text{critical }W}\theta(W)^2\le4\sup_{U\subset\mathcal W_n}K(U)$ over ALL planes of the algebra, criticality not required**, and the conjecture would FOLLOW from the single quartic inequality $$K(U)\le\tfrac14\theta_0(n)^2\quad\text{for every 2-plane }U\subset\mathcal W_n,$$ *sharp on the balanced product's orbit planes if true.* **It is a sufficient condition and not an equivalence**: $K$ on a plane through no idempotent could in principle exceed $\theta_0^2/4$ while the conjecture holds, and whether it does is the screen below.

**Why this is a different INPUT from the one [F65](../findings/INDEX-traps.md) exhausted.** *F65 closed the bound built from Fox's two TRACE identities, $\mathop{\mathrm{tr}}L_e=0$ and $\mathop{\mathrm{tr}}L_e^2=\kappa|e|^2$, which are averages over the spectrum. Sectional nonassociativity is a POINTWISE quartic inequality on pairs, and Lemma 8.3 turns a bound on it into a bound on every eigenvalue, not on their moments.* **And the field has a technique for sharp bounds of exactly this kind**: Fox's Theorem 6.3 bounds the sectional nonassociativity of the Jordan algebra of Hermitian matrices sharply through the Böttcher--Wenzel commutator inequality $\|[X,Y]\|^2\le2\|X\|^2\|Y\|^2$, and the record already computes commutator norms $g_k=\|[\mathrm{ad}(v_k),W]\|^2$ in [L107](../findings/bounds.md)'s $g$-route.

**The second source**: $(2,3)$-palintropic algebras, defined by $(x^3)^2=(x^2)^3$, containing Jordan, power-associative and medial algebras, with explicit fusion rules for the Peirce spaces of any idempotent at $\lambda\ne\tfrac12$ and $L(c)$ an algebra homomorphism at every nonsingular idempotent. *The Weyl algebra is not medial ([I88](../plan.md)); whether it satisfies the weaker identity is a finite check on objects in hand, run below.* **If it does, every critical point of $P$ acquires fusion rules for its Peirce decomposition off the $\tfrac12$-eigenspace, which is structure the record has never had.**

## Batch 5: the screen, which confirms the identity at idempotents and REFUTES the sufficient inequality

**Run in the record's Frobenius convention, checked first by reproducing $\theta(S^3\times S^3)=\sqrt{10}/3$ to nine digits** (screen only, 45 seconds, [screen_sectional_K.py](../scripts/runs/screen_sectional_K.py)).

| check | $n=6$ | $n=8$ |
| --- | --- | --- |
| $4\max_x K(e,x)$ against $\theta^2$ at the balanced product | $1.111111111=\tfrac{10}9$ both | $1.3125=\tfrac{21}{16}$ both |
| count of $\tfrac12$ in $\mathrm{Spec}^\perp(L_e)$ | $18$ | $16$ |
| $\min\mathrm{Spec}^\perp(L_e)$ | $-\tfrac12$ | $-\tfrac13$ |
| $\max K$ over random planes | $-0.035$ | $-0.052$ |
| $\max K$ over six local ascents | **$1.500000$** | not run |
| what the sufficient route needed | $K\le0.375$ | $K\le0.375$ |

**Lemma 8.2's identity $\theta^2=4\max_{x\perp e}K(e,x)$ holds exactly at both idempotents, and it is a genuine, unrecorded structural fact about every critical point.** *The maximum is attained on the $\tfrac12$-eigenspace, which is the orbit tangent plus whatever excess the point carries, and the $-\tfrac12$ at $n=6$ says the sectional nonassociativity of the Weyl algebra has BOTH signs at the balanced product, so Fox's nonnegativity results (Lemmas 8.5 to 8.7) do not apply to it.*

**BUT THE SUFFICIENT INEQUALITY IS FALSE, BY A FACTOR OF FOUR.** *A local ascent from six random starts at $n=6$ reaches $K=1.500000$ on planes through no idempotent, against the $0.375$ that bounding $\theta$ by $\sqrt{3/2}$ would need. The value is $\tfrac32=\theta_{\max}(6)^2$ itself to six digits, so the planes maximising $K$ appear to be structured, and $\sup_UK(U)$ over the whole algebra is at least four times its value on idempotent planes.* **So no bound on $K$ over all planes can reach the conjecture, and the route is dead as a global inequality before being proposed**, which is what a screen is for.

**What survives is the local statement.** *At every critical point, $\theta^2$ is four times the maximal sectional nonassociativity along planes through its idempotent, and Lemma 8.3 turns any bound on $K$ over THOSE planes alone into a bound on $\mathrm{Spec}^\perp(L_e)$. That restricted family is not the whole Grassmannian, and a bound on it would have to know where the idempotents are, which is the circularity the route cannot escape.* Recorded as a structural identity, not a route.

## Batch 6: the second source, screened

**The Weyl algebra is NOT $(2,3)$-palintropic.** *Relative defect $|(x^3)^2-(x^2)^3|/|(x^3)^2|$ at random unit Weyl tensors: $0.49$ at $n=5$, $0.68$ at $n=6$, order one, with the mediator defect $1.6$ beside it for scale.* So the Fox--Tkachev fusion rules do not reach it, and every critical point of $P$ is in any case a SINGULAR idempotent in their vocabulary, $\tfrac12$ lying in its spectrum, which is exactly the case their homomorphism theorem excludes. **Filed with that verdict at [fox-tkachev-2026-palintropic](../references/fox-tkachev-2026-palintropic/README.md).**

## Phase 3a: the screen of everything the sweep touched, in one table

| candidate | mechanism | screened against | outcome |
| --- | --- | --- | --- |
| Motzkin--Straus and Nesterov | a cubic on a sphere maximised at the most symmetric combinatorial configuration | the diagonal half, [Lemma 74](../findings/diagonal-half.md) | the shape is the diagonal half's, which is proved; nothing for the non-diagonal one |
| Waterhouse, symmetric criticality | fixed sets of the symmetry group carry optima | [problem.md](../findings/problem.md) | necessity only, already recorded |
| the equation $R^2+R^{\#}=\lambda R$ as a classification problem | fixed points of Hamilton's ODE | the Ricci-flow shelf, [DGK](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/README.md) | only the diagonal family is classified anywhere |
| Fox 2022, sectional nonassociativity as a GLOBAL bound | $K(U)\le\theta_0^2/4$ on every plane implies the conjecture | the screen, batch 5 | **REFUTED**: $K=1.5$ at $n=6$, four times the bound |
| Fox 2022, Lemma 8.2 at an idempotent | $\theta^2=4\max_{x\perp e}K(e,x)$ | the screen, batch 5 | **TRUE and new to the record**, an identity, not a route |
| Fox--Tkachev 2026, $(2,3)$-palintropic fusion rules | Peirce fusion at every idempotent | the screen, batch 6 | the identity fails on the Weyl algebra |
| Petrov and alignment classification | algebraic types of the Weyl tensor | 1 finding, 3 reviews | Lorentzian, no extremal content |

## Phase 3b: the routes, ranked on the new rubric, and what I would do

**THE LITERATURE HOLDS NO METHOD FOR THE NON-DIAGONAL INEQUALITY, AND THIS IS THE FIFTH SWEEP TO SAY SO.** *Five sweeps in five days, roughly twenty-five fields between them, four fence posts and now a fifth, with the two closest sources both by the author of the record's primary algebraic tool and both failing on contact: one because the Weyl algebra's sectional nonassociativity is unbounded above relative to its value at idempotents, the other because the algebra fails the identity.*

| route | closes | attackable | margin | analytic | value | distance to a proof of the goal |
| --- | --- | --- | --- | --- | --- | --- |
| **A. Post F67 and record Lemma 8.2's identity as a numbered result**, then work [I71](../plan.md) | $0$ as a route, it is a finding | $3$ | $1$ | $1$ | **$0$** | none: it makes the stall a recorded fact and hands back the graded top |
| **B. The $\tfrac12$-eigenspace count as the diagonality detector.** The screen found $18$ half-eigenvalues at $S^3\times S^3$ against orbit dimension $9$ and $16$ at $S^4\times S^4$ against $16$, so the excess is $9$ at $n=6$ and $0$ at $n=8$: **[I81](../plan.md)'s object, measured.** Route: prove the excess is $0$ at every critical point above $\sqrt{3/2}$, whence Morse--Bott nondegeneracy and R11's classification | $2$ | $1$ | $1$ | $1$ | **$2$**: it is R11 with a number attached, and R11 has waited on this object since it opened |
| **C. Restricted sectional bound.** Bound $K(e,x)$ over planes through IDEMPOTENTS only, using criticality to constrain the plane | $2$ | $1$ | $1$ | $1$ | **$2$**: circular as stated, since the bound must know where the idempotents are |

**What I would do: A, then B.** *A is not a route and I am not dressing it as one: it records the fifth post and the one exact identity the sweep produced, which is owed to the record whatever the user decides. B is the only candidate that arrived with a NUMBER rather than a name, the excess measured at two points, and it is the record's own R11 with its missing object partly supplied. C is the sectional route after the screen killed its global form, and it is circular.*

**And the honest reading of the table is the one the rubric now gives**: nothing above $2$ reaches the open statement, and the next real advance, if there is one, is a hand derivation on B's question rather than another sweep. *A sixth sweep would search the same twenty-five fields with new words.*

## Phase 3c: the user asked for a route rather than a search, and this is the one derived here, on Fable, screened before being written

**ROUTE D, THE FRAME SPLIT.** *Fix an orthonormal frame $F$ and split a critical point as $W=D+N$, with $D=\pi_FW$ its coordinate-diagonal part in $F$, $N$ the rest, and $t=t_F=\lVert D\rVert^2$ at unit norm. Two facts about $\mathcal D_n(F)$, both on the record: it is a subalgebra, $Q(\mathcal D_n)\subset\mathcal D_n$, and $L_D$ commutes with the sign group $\Gamma_F$ so preserves its isotypic components ([L120](../findings/second-order.md)'s mechanism, which needs only $D$ diagonal). Hence $\langle Q(D),N\rangle=0$ and $\pi_F(D\circ N)=0$.*

**Two exact relations, in EVERY frame, from projecting $Q(W)=\theta W$ onto the diagonal and off-diagonal parts and pairing with $D$ and $N$:**
$$\theta\,t=P(D)+\langle L_DN,N\rangle,\qquad\theta(1-t)=2\langle L_DN,N\rangle+P(N).$$
*Their sum is the polarisation $P(D+N)=P(D)+3\langle L_DN,N\rangle+P(N)$ with the cross term $3\langle Q(D),N\rangle$ gone.*

**One inequality at every MAXIMISER, in every frame, from [L24](../findings/second-order.md)'s cap $L_W\le\theta/2$ on $W^\perp$ applied to the test vector $X=tN-(1-t)D\perp W$.** *Expanding $\langle L_WX,X\rangle$ with $L_W=L_D+L_N$, substituting the two relations, and watching every $t^2$ and $t^3$ term cancel leaves $\langle L_WX,X\rangle=P(D)-\theta t^2$, while $\lVert X\rVert^2=t(1-t)$. So*
$$\langle L_DN,N\rangle\;\ge\;\tfrac\theta2\,t(1-t),\qquad\text{equivalently}\qquad P(D)\;\le\;\tfrac\theta2\,t(1+t).$$

**Screened at $S^4\times S^4$, where L24's cap is on record, in sixty random frames with $t\in[0.018,0.192]$**: both relations hold to $3\times10^{-15}$, and neither inequality is violated, worst margin $10^{-2}$. *[screen_sectional_K.py](../scripts/runs/screen_sectional_K.py)'s sibling, to be filed with the derivation.*

**What it reduces the open statement to.** *With $d=D/\sqrt t$ and $\nu=N/\sqrt{1-t}$ unit, the first relation reads $\langle L_d\nu,\nu\rangle=\dfrac{\theta\sqrt t-tP(d)}{1-t}$, and the diagonal half is PROVED, so $|P(d)|\le\theta_0(n)$. Therefore, at a non-diagonal maximiser and in the frame maximising $t$,*
$$\theta\le\sqrt t\,\theta_0(n)+\frac{(1-t)\,\Lambda_n}{\sqrt t},\qquad\Lambda_n:=\sup\{\langle L_d\nu,\nu\rangle:\ d\text{ unit diagonal},\ \nu\text{ unit off-diagonal}\}.$$
**So the non-diagonal inequality follows from two statements about DIAGONAL tensors and FRAMES, neither of which mentions the unknown maximiser:**
1. **$\Lambda_n$ in closed form**, the largest Rayleigh quotient of $L_d$ on off-diagonal tensors over unit diagonal $d$. *[L120](../findings/second-order.md), [L121](../findings/second-order.md) and [L122](../findings/second-order.md) give $L_d$'s blocks explicitly in the sectional matrix, the pair blocks as graph Laplacians and the four-set blocks two-dimensional, so this is a maximisation over hollow zero-row-sum matrices with explicit block spectra.* At the balanced product's own frame the orbit tangent gives $\theta_0/2$, and at padded $\mathbb{CP}^2$'s natural frame the split is $d=W_{S^2\times S^2}$, $t=\tfrac12$, and the relation returns $\langle L_d\nu,\nu\rangle=\sqrt3-\tfrac{\sqrt3}2=\tfrac{\sqrt3}2$ exactly.
2. **A lower bound on $\max_Ft_F$ at every critical point above $\sqrt{3/2}$.** *Schur gives only the average $6/((n+1)(n+2))$ over frames, which is too small, so this needs criticality: the frame maximising $t$ satisfies $D\perp T_W$, the orbit tangent, and $N\perp T_W$ with it, and the second-order frame condition is $\langle W,\mathrm{ad}_\xi^2D\rangle\le-\lVert\pi_F\mathrm{ad}_\xi W\rVert^2$ for every $\xi\in\mathfrak{so}(n)$.* This is where the route can die, and it is the FIRST thing to attempt, because it is the one step with no analogue on file.

**What distinguishes it from [DERIVE-mx1](DERIVE-mx1.md), the record's earlier frame argument, refuted as stated.** *That argument asserted the uncorrected four-index inequality $\Sigma\le\theta^2$ in a frame, which is false off the eigenframe. Nothing here is a four-index inequality: the two relations are exact projections of criticality, the inequality is L24's cap on one explicit test vector, and the frame enters only through $t_F$ and $\Lambda_n$.* **The reviewer's first question should still be whether any step silently uses the eigenframe, since that is how the earlier one fell.**

**What would falsify it.** *A critical point with $L_W\le\theta/2$ on $W^\perp$ and a frame violating $\langle L_DN,N\rangle\ge\tfrac\theta2t(1-t)$, which would mean the algebra above is wrong; or $\Lambda_n$ so large, or $\max_Ft_F$ so small at some critical point, that the bound never reaches $\sqrt{3/2}$. Both are computable before any theorem is attempted, and step 2 decides the route within a cycle.*

| route | closes | attackable | margin | analytic | value | distance to a proof of the goal |
| --- | --- | --- | --- | --- | --- | --- |
| **D. The frame split** | $2$ | $3$ | $1$ | $1$ | **$6$** | reduces the non-diagonal inequality to a closed form for $\Lambda_n$ and a lower bound on the diagonal mass at critical points, both about known objects; the second is untried and may fail |
| B. The excess route | $2$ | $1$ | $1$ | $1$ | $2$ | R11 with a number attached |
| A. Post F67, number the identity | finding | | | | | owed regardless |

**Recommendation revised: D, with A's bookkeeping done alongside.** *D is the first candidate in five sweeps to reach $6$ under the new rubric, it uses the proved diagonal half as its engine, and its risky step is cheap to test. It was derived here on Fable and is on disk in this file, so it is recorded, typed and dispatched on Opus only after the switch back.*
