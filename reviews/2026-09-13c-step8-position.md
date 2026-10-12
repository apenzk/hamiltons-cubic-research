# Step 9 position, 2026-09-13c

**Written on Opus before any sweep, as step 9 requires.** *The next sweep reads this file and nothing else of the record whole.*

## Why step 9 is due

**Section 1 has no item above 3 with a route.** [I71](../plan.md) was regraded from 4 to 2 the same day, because [bounds.md](../findings/bounds.md)'s own statement of the gap is that the first admissible lever on the rows is $\sum_k\lambda_k^2g_k$ and the conjecture is not obviously expressible in it. The top is then [I36](../plan.md) and [I73](../plan.md) at 3, both marked *no route known*. **The rubric's instruction in that position is to invent a route, which is this step.**

## The one open statement

$\theta\le\sqrt{3/2}$ at every non-diagonal critical point of $P$ on the unit sphere of $\mathcal W_n$, $n\ge12$. The diagonal half is proved ([L57](../findings/problem.md)) and the symmetric-space half is proved ([L47](../findings/problem.md), [L210](../findings/problem.md) to [L213](../findings/problem.md)).

## What the session established that a route can stand on

- **[L216](../findings/second-order.md), an explicit isolation radius**, Gate 2 passed: no critical point lies within $r=4\theta_0\gamma/(9(1+\sqrt{n-2}))$ of a critical orbit with normal gap $\gamma$, except the orbit. *Closed-form gap at every sphere product, $\gamma=1/(n-2)$ at the balanced product. At padded $\mathbb{CP}^2$, $\gamma=\tfrac16$ and the radius is conditional on [I54](../plan-verification.md), the four $F_\lambda$ of L21 being $m$-free.*
- **[L214](../findings/second-order.md), the frame split**, Gate 2 passed: two exact relations in every orthonormal frame and one maximiser inequality. *Its decoupled consequence is [post F67](../findings/fence-posts.md).*
- **[L215](../findings/second-order.md)**, $\lVert Q(X)\rVert\le(n-1)\lVert X\rVert^2$, Gate 2 passed, its engine being [L153](../findings/bounds.md).

## The open nodes, and the fences on each

| node | what it needs | fences a successor must clear |
| --- | --- | --- |
| **the localisation**, every critical point above $\sqrt{3/2}$ lies within $\varepsilon_n$ of a rigid orbit, which with L216 closes the conjecture | a mechanism producing $\varepsilon_n\le\min_ir_i$; **none on the record**, [L19](../findings/problem.md) withdrawn as carrying no proposition | [R4](../routes.md): *not rest on $W_{\mathbb{CP}^2}$ remaining the maximiser*; general finiteness arguments closed as carrying constants far too large; the finiteness shortcut refuted as circular ([nondegeneracy.md](../findings/nondegeneracy.md)) |
| **I7**, the destination on the compact non-pure set | its own section names a Morse-theoretic count, a minimax value or an equivariant index on a critical set at positive distance from the pure orbits, which L216 now makes explicit | [R12](../routes.md)'s closure notes; [post F37](../findings/INDEX-traps.md), the third and fourth variation vacuous on the orbit tangent |
| **I71**, the uncontracted rows at rank five and above | a lever beyond $\sum_k\lambda_k^2g_k$ | the catalogue cannot decide realisability, its isospectral pairs being triality pairs ([bounds.md](../findings/bounds.md)) |
| **I36, I73**, spectral characterisations of the maximiser | a mechanism for either link | [trap 26](../findings/INDEX-traps.md) and [post F67](../findings/fence-posts.md): any relaxation tight at the balanced product cannot beat $\Theta_n$ |

## What previous sweeps covered, so this one does not repeat them

**Five sweeps in five days, the last two today** ([2026-09-13](2026-09-13-LIT-step8-sweep.md), [2026-09-13b](2026-09-13b-LIT-step8-sweep.md)). *Searched and recorded as holding no method for the non-diagonal inequality: symmetric criticality and Waterhouse, symmetric-tensor Z-eigenvectors and odeco, Fox-algebra Peirce theory and Krasnov--Tkachev mediality, Hamilton's reaction term and pinching cones, $\theta$-groups and GIT, harmonic cubics, pure curvature operators, Motzkin--Straus and hypergraph Lagrangians, reflection-group extremal theorems, the fixed-point equation of Hamilton's ODE, Fox's sectional nonassociativity, Fox--Tkachev palintropic algebras, and Petrov alignment.* **A sweep phrased in the record's own objects finds only the record**, so the next one must be phrased in the localisation's objects: critical sets of invariant functions, quantitative Łojasiewicz or Morse--Bott estimates with explicit constants, and minimax on orbit spaces.

## The screening question every candidate answers first

**What does its bound give AT the balanced product?** A relaxation tight there cannot beat $\Theta_n>\sqrt{3/2}$ ([trap 26](../findings/INDEX-traps.md), [post F67](../findings/fence-posts.md)). *L216 passed that screen because it bounds a distance rather than $\theta$.*
