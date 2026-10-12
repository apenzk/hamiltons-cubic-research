# Position at step 9, 2026-09-12

**Written on Opus before the sweep, so the reading is done on the cheap side and the judgement on the other.** *The previous pass is [2026-09-10b](2026-09-10b-step8-position.md) with its sweep [2026-09-10b-LIT](2026-09-10b-LIT-step8-sweep.md).*

## Why the plan is at step 9

**Nothing in section 1 is startable.** Its top three items, [I36](../plan.md), [I73](../plan.md) and [I68](../plan.md), all score $3$ with `attackable` $=1$, meaning a method must be invented. The items that had methods two days ago have all closed or been withdrawn:

| item | what happened |
|---|---|
| **I77**, the triangle-type relaxation | the marginals-only programme is closed at an exact LP optimum of $4.4907$ at $n=12$; the (B) repair collapses the padded competitor to its exact value and is REFUTED as a route by a realisable witness, $W_{\mathbb{CP}^2}\oplus W_{\mathbb{CP}^2}$ giving $7\sqrt3/6$ against a true $\sqrt3/2$ with the gap widening in $n$ |
| **I76**, coordinate-diagonality at two eigenvalues | the $\kappa=1$ stratum is CLOSED with a one-element classification, the perfect-matching tensor. Everything above $\kappa=1$ is open, and this cycle's refutation attempt was WITHDRAWN: the integrality defect constrains a basis and cannot decide a property of the operator |
| **I75**, the route's first link | supplied on the two-eigenvalue locus by the Vandermonde relations, so [I73](../plan.md) now implies it. Unsupplied elsewhere |
| **I71**, the uncontracted rows | its owed question is answered: the $\mathrm{Alt}(W^2)$ bound is $\sqrt{(m-1)/(3m)}$ at $m=\lfloor n/2\rfloor$, attained, and attained by $W_{\mathbb{CP}^2}$ itself |

## What is proved and durable

- **[L201](../findings/diagonal-half.md)**: an orthonormal basis of $\mathfrak{so}(n)$ by rank-two elements whose pairwise brackets are each zero or of unit norm is the standard basis of some frame, up to signs. Gate 2 passed. *Its scope limit, learned expensively: it constrains a BASIS, not an eigenspace.*
- **The $\kappa=1$ theorem**: at $a=n/2$ the planes are mutually orthogonal, so $W$ is coordinate-diagonal, and the unique object up to $O(n)$ is the perfect-matching tensor, a product of two-spheres.
- **[L204](../findings/bounds.md)**: $\lVert\mathrm{Alt}(A)\rVert\le\sqrt{(m-1)/(3m)}\operatorname{tr}A$ for positive $A$, sharp and attained, with $m$ entering as the rank of $\omega^2$.
- **The bridge** $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$, which makes the plane geometry and the record's $T$-calculus one object on the decomposable locus.
- **The Vandermonde relations**: the $\Lambda^4$ obstructions lie in the kernel of a $2\times s$ Vandermonde, so they vanish at two distinct eigenvalues and reduce to $s-2$ conditions in general.

## The fence posts that bear on any new route

- **[F64](../findings/fence-posts.md)**: no route in the literature at any item that would close the goal, confirmed over four passes and six phrasings each.
- **The marginals are $\theta$-blind**: every $\lambda$-weighted contraction of $S_{\alpha\beta}$ is a $\{p,q,0\}$ pattern of $T$ while $\theta$'s dependence is $\{1,1,1\}$.
- **Relaxations in $T$ alone are exhausted**: the marginals-only LP, its dual, and the (B)-augmented programme all fail, the last by a realisable witness. A successor must couple $T$ to something other than the spectrum through $T$'s own marginals.
- **[R6](../routes.md)'s clearance criterion**, unmet: separate a maximiser from an obstructed local max by something other than the value.
- **$\sigma_\Delta$ explains the near-misses**: a spectrum whose objective-carrying triples have $\sigma_\Delta=\lambda_a+\lambda_b+\lambda_c$ positive pays its budget out of the objective, and every relaxation that looked tight was tight at a spectrum where $\sigma=0$.

## The scoreboard, unmoved

$\theta\le3.0509$ at $n=12$ against $\theta_0(12)=1.236033$, a factor of $2.47$. **No bound derived this week improves it.**

## What the sweep must look for

**A route that reasons about the SUBSPACE $A$ or about the operator, not about a chosen basis or a marginal of $T$.** The two failures of this week are exactly those two shapes. Candidate directions the record has never used: the Lie structure of $A$ as a subspace of $\mathfrak{so}(n)$ beyond the bracket norms; second-order information at a maximiser, since criticality alone has been exhausted; and anything that bounds the number of distinct eigenvalues, which the Vandermonde relations would then convert into the first link for free.
