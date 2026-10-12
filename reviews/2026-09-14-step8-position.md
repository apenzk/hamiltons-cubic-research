# Step 9 position, 2026-09-14, rebuilt from the root of Problem P

**Written on Opus before any sweep, as step 9 requires.** *The next sweep reads this file and nothing else of the record whole.* **Why this one differs from the six before it:** the user asked for the reduction to be re-derived from Problem P itself, because every route of the last two weeks has been aimed at a statement stronger than P, and the six previous positions ([2026-09-02](2026-09-02-step8-position.md) to [2026-09-13c](2026-09-13c-step8-position.md)) all took that statement as given.

## The root

**Problem P, as posed in [README.md](../README.md):** for $n\ge12$, $P(W)=\langle W,Q(W)\rangle$ on the unit sphere of $\mathcal W_n$ is maximised by the Weyl tensor of a product of spheres, granting the diagonal case. **[Lemma L0](../findings/problem.md)** makes it the value statement $\sup P=\Theta_n$, with $\Theta_n=\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ at even $n$, attained by Nienhaus Proposition 2.25. *L0's own note: the equivalence moves the quantifier to the critical set and removes nothing else.*

**The root node, stated about the object P is about.** *Let $W^\ast$ be a global maximiser of $P$ on the unit sphere of $\mathcal W_n$, $n\ge12$. Then $W^\ast$ is coordinate-diagonal in some orthonormal frame.* **[Lemma L57](../findings/problem.md) finishes from there**, giving $P(W^\ast)\le\Theta_n$ at every $n\ge4$, both parities.

## What a global maximiser supplies, and where the record already spends it

| | hypothesis at $W^\ast$ | strength | results on the record that consume it |
| --- | --- | --- | --- |
| **H1** | **value**: $\theta=M(n)\ge\Theta_n$ | global, and **separates $W^\ast$ from padded $W_{\mathbb{CP}^2}$** since $\Theta_n>\sqrt{3/2}$ at $n\ge12$ | [L20](../findings/route-a.md) (tube exclusion, given [L21](../findings/route-a.md)), [L115](../findings/bounds-relaxations.md) ($\theta>\max_\alpha\lambda_\alpha$) |
| **H2** | **criticality**: $Q(W^\ast)=\theta W^\ast$ | first order, shared by every critical point | nearly everything |
| **H3** | **local maximality**: $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$, $e=W^\ast/\theta$ | second order, shared by every local maximum | [L24](../findings/second-order.md), [L214](../findings/second-order.md)'s frame inequality, [L216](../findings/second-order.md) through the gap |
| **H4** | **global comparison**: $P(W^\ast)\ge P(X)$ for every unit $X$ | global, the strongest and least used | [L66](../findings/support-dichotomy.md) (no $\circ$-decomposable maximiser, by additivity against $M(n)$) |

**The margin H1 carries is small at $n=12$ and grows:** $\theta_0(12)-\sqrt{3/2}=1.236033-1.224745=0.0113$, $\theta_0(14)-\sqrt{3/2}=0.0370$, and $\to\sqrt2-\sqrt{3/2}=0.1895$. *Any argument through H1 must be sharp to about one percent at $n=12$.*

## The structural constraint the fences impose

**Padded $W_{\mathbb{CP}^2}$ is critical, non-diagonal (Plücker-obstructed), a local maximum at $n\ge12$, and sits at exactly $\sqrt{3/2}$.** *That is [R6](../routes.md)'s closure, and its clearance criterion reads: separate a maximiser from an obstructed local max by something other than the value.* **Read from the root, the criterion has a sharper form: an argument using only H2 and H3 cannot prove the root node, because padded $W_{\mathbb{CP}^2}$ satisfies H2 and H3 and is not diagonal.** So a proof of the root node must consume H1 or H4. *This is a position, not a lemma: it follows from the witness and needs no further argument, and it is the reading the sweep is asked to test.*

## How the plan's open statement relates to the root

**The plan's remaining open statement** ([plan.md](../plan.md), [INDEX.md](../findings/INDEX.md)'s live-target row) **is $\theta\le\sqrt{3/2}$ at every non-diagonal critical point**, split into $S=0$ ([I1](../plan.md)) and $S>0$ ([I37](../plan.md)). **It implies the root node and is strictly stronger in two ways:**

- **It quantifies over every critical point**, so it keeps H2 and throws away H1, H3 and H4. Every non-diagonal critical point of every value is in its scope.
- **Its threshold is $\sqrt{3/2}$ where the root needs $\Theta_n$**, and padded $W_{\mathbb{CP}^2}$ attains that threshold, so **the target has zero margin at a point that is not a maximiser.** The root node has margin $\Theta_n-\sqrt{3/2}>0$ against that same point.

**Reading of why routes stall, offered for the sweep to test:** by the constraint above, a statement keeping only H2 must be proved by an argument that holds at padded $W_{\mathbb{CP}^2}$ with equality, so it admits no lossy step anywhere, which is the zero-margin condition the grading rubric warns about. **The same holds for [I36](../plan.md)** (local maximisers above $\sqrt{3/2}$) and **[I73](../plan.md)** (maximisers have two eigenvalues) wherever their intended arguments use only H2 and H3.

## The map from the root, with what the record covers

| region of the unit sphere, for a would-be non-diagonal global maximiser | covered by | footing |
| --- | --- | --- |
| $\circ$-decomposable | [L66](../findings/support-dichotomy.md), via H4 | proved, audited twice |
| within $0.5748$ of $SO(n)\cdot W_{\mathbb{CP}^2}$ | [L20](../findings/route-a.md), via H1 | proved **given [L21](../findings/route-a.md)**, whose $\alpha\le\tfrac13$ owes the $m$-independence of four $F_\lambda$ blocks ([I54](../plan-verification.md)) |
| within $r_n$ of a quantitatively nondegenerate critical orbit, e.g. the balanced product | [L216](../findings/second-order.md), no other critical point there | proved, Gate 2 passed |
| spectrum taking two values | [L105](../findings/bounds-relaxations.md) gives $\theta\le\theta_0(n)$ | proved |
| symmetric-space Weyl tensors | Lemmas L46 to L48 | proved, Einstein globally symmetric |
| graded equivariant critical points | [L8](../findings/graded-half.md) | proved on the equivariant graded points only |
| coordinate-diagonal | [L57](../findings/problem.md) | proved, all $n$ |
| **everything else: indecomposable, outside both tubes, at least three eigenvalues, not diagonal** | **nothing** | **the open core of the root node** |

## Directions that use H4, which no previous sweep aimed at as a class

*Stated as questions for the sweep, not as routes, and each is screened against the fences before it is ranked.*

1. **Improvement constructions.** From a non-diagonal indecomposable unit $W$ satisfying H1 to H3, build a unit $X$ with $P(X)>P(W)$. [L66](../findings/support-dichotomy.md)'s additivity is the one instance on file. *Candidates: restriction of $W$ to an invariant subspace and renormalisation, averaging over a subgroup fixing a frame, and moving along a direction where $L_e$ has its top eigenvalue off $W$.*
2. **The operator form of the maximum.** By Banach's theorem on symmetric multilinear forms, $M(n)=\sup_{\lVert x\rVert=1}\lambda_{\max}(L_x)$ ([2026-09-13c](2026-09-13c-LIT-step8-sweep.md) phase 3c, idea 2, never worked). *At a global maximiser this is a global statement about every multiplication operator, H4 in spectral form.*
3. **The value bootstrap beyond $\mathbb{CP}^2$.** L20's argument uses H1 against one rigid orbit, and [I10](../plan.md) proposes the padded $\mathbb{HP}^2$ orbit. *This covers neighbourhoods only, and the sweep should say whether a cover of the far region by such tubes is conceivable at all.*
4. **The literature on maximisers of invariant cubic forms on spheres specifically**, as distinct from critical points: spectral norms of symmetric tensors, where the maximum is attained, Cartan-type cubic forms, and results that characterise global rather than local maximisers.

## What previous sweeps covered, so this one does not repeat them

**Six sweeps, 2026-09-02 to 2026-09-13c**, each with its position file in [reviews/](.). *Recorded as holding no mechanism for the non-diagonal inequality or the localisation:* the moment map and GIT ([F66](../findings/fence-posts.md), [R22](../routes.md)); medial and isospectral algebras ([R23](../routes.md)); fusion-frame packing ([R21](../routes.md)); purity ([R20](../routes.md)); the Killing-constant bound ([R19](../routes.md), [F65](../findings/fence-posts.md)); the frame split ([R24](../routes.md), [F67](../findings/fence-posts.md)); Michel criticality, Łojasiewicz and Milnor--Thom, and Z-eigenvector theory (2026-09-13c, nothing on location). **Every one of them was aimed at the critical-point statement.** *What has not been searched is literature and machinery for the GLOBAL maximiser of a cubic form, which is direction 4 above.*

## The screening questions every candidate answers first

1. **Which of H1 to H4 does it consume?** *One consuming only H2 and H3 is refuted by padded $W_{\mathbb{CP}^2}$ before it starts.*
2. **What does its bound give at the balanced product?** *A relaxation tight there cannot beat $\Theta_n$ ([trap 26](../findings/INDEX-traps.md), [post F67](../findings/fence-posts.md)).*
3. **What does it give at padded $W_{\mathbb{CP}^2}$ at $n=12$**, where H1 has only $0.0113$ of room?
4. **Is its mechanism already in [routes.md](../routes.md), [ATTEMPTS.md](../ATTEMPTS.md)'s index or [INDEX-literature.md](../findings/INDEX-literature.md)?**
