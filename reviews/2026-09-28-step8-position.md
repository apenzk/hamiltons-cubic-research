# Step 8 position, 2026-09-28: a method for (MG), I121's nonclosed branch

*The user's decision of 2026-09-28, relayed by the manager: park [I122](../plan.md) and aim step 9 at the top item's open node, the nonclosed branch of [I121](../plan.md), which is the mixing gap (MG) itself. The sweep's job is to invent a method for (MG) or to find where it fails.*

## The node, exactly

At a unit global maximiser $W$ of $P$ on $\mathcal W_n$, $Q(W)=\rho W$, in an orthonormal frame globally maximising $\lVert\pi_{\mathcal D}W\rVert^2$, with $W=A+B$, $A=\pi_{\mathcal D}W$:
$$(\mathrm{MG})\qquad\rho\le\max\Big\{\sqrt{3/2},\ \frac{P(A)}{\lVert A\rVert^3}\Big\}.$$
**At a global maximiser (MG) is Conjecture A at $n\ge12$**: a counterexample has $\rho>\Theta_n\ge P(A)/\lVert A\rVert^3$ by [L57](../findings/problem.md), so (MG) there says $\rho\le\sqrt{3/2}<\Theta_n$. *So a counterexample hunt for (MG) at global maximisers is the conjecture's own falsifier hunt; what (MG) adds is the frame and the dichotomy, and whether it holds beyond global maximisers is the informative question.* The closed branch $C=0$ of [L284](../findings/second-order.md) is reduced (Gate 2 passed) and parked as [I122](../plan.md); **the node is $C\ne0$**.

## Tools now on the record for this node

| tool | what it gives | status |
|---|---|---|
| [L284](../findings/second-order.md), identity (86) | $\rho^2t^2b^2\lVert C\rVert^2=\lVert q_\perp\rVert^2+\sum\lVert Y_U\rVert^2+\sum p_U(\lambda_U-\bar\lambda)^2$, three independent defects, at every critical point in every frame | proved, Lean |
| [L214](../findings/second-order.md) | the frame split's two relations and the cap inequality; $\eta\ge0$ is its inequality | proved, Lean |
| the Peirce budget | $\lvert C\rvert^2\le\eta(\tfrac32-\eta)$ at a global maximiser, from $-\rho\le L_W\le\tfrac\rho2$ on $W^\perp$ | the author's, follows from [L24](../findings/second-order.md) |
| the finite-angle inequality | $\lvert c_U\rvert\le\lVert A\rVert^2-c_0$ for every $g\in O(n)$ and sign twist | Gate 2 passed, untyped ([note](2026-09-28-I121-MG-audit.md)) |
| the one-plane bound | $\langle\delta,x\rangle=0$, $\lVert x\rVert\le\lVert\delta\rVert$ per pair block in a globally maximal frame | Gate 2 passed, core in Lean |
| the double-rotation inequality | a four-set block bounded by the diagonal's rectangle difference plus pair slack; exact for all three pairings | Gate 2 passed, core in Lean |
| [L219](../findings/second-order.md) | the reflection split at every unit $u$, $\lVert c_u\rVert^2\le\tfrac34$ at a global maximiser | proved, Lean, typed in full |
| R51 | $3d-2(\theta_V/\theta)d^{3/2}\le1$ for any $Q$-subalgebra $V$ | derived, not audited, fenced on the diagonal locus |

## Fence posts bearing on the node

| post | what it closes |
|---|---|
| [F38](../findings/fence-posts.md) | a mass on $\mathfrak p$ across arbitrary gradings; **the canonical-grading version is open and is this node** |
| [F67](../findings/fence-posts.md) | bounding the frame split's two terms separately: never beats $\Theta_n$ |
| [trap 26](../findings/INDEX-traps.md) | any bound exact at the diagonal end and monotone below it |
| [F11](../findings/second-order.md) | using the size of the sharp term alone |
| [F39](../findings/fence-posts.md), [F76](../findings/fence-posts.md)–[F79](../findings/fence-posts.md) | second-order test directions and per-vector rows |
| the author's own | an estimate using only $q_\perp$, only the ordinary Hessian, or only one hyperplane cannot prove (MG) |

## What previous sweeps covered

- [2026-09-27c](2026-09-27c-LIT-step8-sweep.md): the method sweep for I73 that chose R52; Peirce spectra, polarisation, invariant cubics on $O(n)$-modules, nothing that bounds the number of eigenvalues.
- The outside author's Part II, read in full for I121: (86), the closed branch, the certified sub-cases, the finite-angle family, the rectangle SOS; **27.2 names no inequality**.
- 2026-09-25 rounds 1 to 3 and 2026-09-26/27: few-eigenvalue curvature operators, eigenspace realisability, $R^\#$ eigenvalue bounds, the sharp half (I117).
- This session: commutator norms of skew-symmetric matrices ([Bloch–Iserles](../references/bloch-iserles-2005-skew-commutators/notes.md)); commutator energy of subspaces of $\mathfrak{so}(n)$ (nothing found).

## What the sweep must decide

1. **Does (MG) hold beyond global maximisers?** Test it at the catalogued non-diagonal critical points with $\theta>\sqrt{3/2}$ in their maximal frames. *A failure there says any proof must use global maximality (the finite-angle inequality, the Peirce budget), and says which; a pass on all of them says (MG) may be a statement about critical points, with second-order and frame data enough.*
2. **Can the finite-angle family at a genuinely global rotation (the double rotation is one) be combined with (86)'s three defects** into a lower bound on $\lVert C\rVert$ at $\rho>\sqrt{3/2}$, against the Peirce budget's upper bound $\eta(\tfrac32-\eta)$?
3. **Is there an outside method for "a maximiser in a maximal frame is nearly diagonal"**: Jacobi-type diagonalisation arguments for symmetric tensors, maximal-diagonal-mass frames for fourth-order tensors, Schur–Horn-type majorisation on $\Lambda^2$.
