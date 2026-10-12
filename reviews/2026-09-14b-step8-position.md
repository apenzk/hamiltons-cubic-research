# Step 9 position, 2026-09-14b, the far region of route R25

**Written on Opus before the sweep, as step 9 requires.** *The sweep reads this file and nothing else of the record whole, and appends to [2026-09-14b-LIT-step8-sweep.md](2026-09-14b-LIT-step8-sweep.md) after every batch.* **It follows [this morning's root position](2026-09-14-step8-position.md), which the user chose route A from; read that file's "root" and "what a maximiser supplies" sections for the setting, which is unchanged.**

## What changed since the morning position

- **The near region is closed.** [L217](../findings/second-order.md), Gate 2 passed: a global maximiser within geodesic angle $\arcsin\frac3{n-2}$ of the balanced orbit has value $\Theta_n$, by L20's expansion with H4 on the cubic remainder and the gap $\gamma=\frac1{n-2}$. Exclusion tubes hold at every gapped sub-maximal orbit.
- **The Banach falsifier is dead.** [L218](../findings/second-order.md), Gate 2 passed: $\Lambda_n=\sup\langle L_DN,N\rangle=\tfrac{\sqrt3}2$ exactly, below $\Theta_n$ at every $n\ge5$.
- **The far region was attacked at the $t$-maximising frame and SPLIT, not closed** ([I100 position](2026-09-14-I100-position.md), [derivation](2026-09-14-I100-derivation.md)). The frame split's scalar system is satisfiable at every $t<1$, so no lower bound on the diagonal mass comes from it.
- **The single-four-set case became I101, and four attempts moved it without shrinking it.** It is exactly Conjecture A on the subalgebra $\mathcal S_Q=\mathcal D_n\oplus V_Q$, the fixed space of $\ker\chi_Q$, which contains padded $W_{\mathbb{CP}^2}$ at $0.9\%$ below $\Theta_{12}$. Proved on the way: $P(q+\nu+r)=P(q+\nu)+3\langle L_qr,r\rangle+P(r)$ on $\mathcal S_Q$, and $\langle L_qr,r\rangle\le\max(x,y,z)\lVert r\rVert^2\le\lVert r\rVert^2/\sqrt3$ on the pattern complement. Failed: L57's chain through the forcing ($1.37$ against $1.236$), the decoupled coupling bound, and the row-mass split ($+0.28$). Passed by screen only with margin $0.0015$: the coupling value as statistic, which leaves L57 with one quadratic constraint.
- **The n=14 maximiser hunt** (user-approved, 150 random and 150 index-supported starts in dimension 3080) found only catalogued values, none above $\Theta_{14}$; the final tally is in [ATTEMPTS.md](../ATTEMPTS.md).

## The finding the sweep should start from

**Post [F67](../findings/fence-posts.md)'s shape recurred three times in one day, at three different levels:** the frame split ($P(d)$ against $\langle L_d\nu,\nu\rangle$), the pattern split inside $\mathcal D_n$ (coupling against $P(r)$), and the row-mass split. *Each time the identity was exact and the two terms, bounded by separate suprema, lost the conjecture, because the maximisers of the two terms are different vectors while at the competitor they are the same vector.* **Read as a position: every orthogonal splitting $\mathcal A=\mathcal B\oplus\mathcal C$ with $\mathcal B$ a subalgebra and $\langle\mathcal B\circ\mathcal B,\mathcal C\rangle=0$ gives $P=P_{\mathcal B}+3\langle L_bc,c\rangle+P(c)$, and a proof by such splittings needs a JOINT statistic on $c$, never two suprema.** The last attempt found one that works by screen, with no room.

## Open nodes

| node | status | margin at $n=12$ |
| --- | --- | --- |
| **Far region**: a global maximiser outside the L217 tube is diagonal | open, no route | $\Theta_{12}-\sqrt{3/2}=0.0113$ against padded $W_{\mathbb{CP}^2}$ |
| I100 mixed case: $N$ spread over several blocks | no route | the pair-block analogue of $e$ under the frame condition |
| I101: Conjecture A on $\mathcal S_Q$ | four attempts, screened true | $0.0113$ in $\theta$, $0.0315$ in (J) |
| Node (b): a stability form of L57 | not on record | none needed at $\delta\to0$ |
| [I36](../plan.md), [I73](../plan.md) | no mechanism, grade 3 by closes | zero margin in their current H2/H3 forms |

## Fences bearing on the far region

- **[F67](../findings/fence-posts.md)**, and its three recurrences above: no decoupled split.
- **[F37](../findings/fence-posts.md)**: the variation calculus is an identity on the orbit tangent.
- **[Trap 26](../findings/INDEX-traps.md)**: no bound exact at the diagonal end and monotone below it.
- **[R6](../routes.md)**: padded $W_{\mathbb{CP}^2}$ is a non-diagonal local maximum, so H2 and H3 alone cannot prove the root node.
- **[R1](../routes.md)**: a machine certificate is not the deliverable. *An SOS over $\mathcal W_{12}$ is also out of reach: a degree-6 moment matrix in 1638 variables.*

## What previous sweeps covered

**Ten sweeps**, [2026-09-02](2026-09-02-LIT-step8-sweep.md), [09-03](2026-09-03-LIT-step8-sweep.md), [09-03b](2026-09-03b-LIT-step8-sweep.md), [09-10](2026-09-10-LIT-step8-sweep.md), [09-10b](2026-09-10b-LIT-step8-sweep.md), [09-12](2026-09-12-LIT-step8-sweep.md), [09-13](2026-09-13-LIT-step8-sweep.md), [09-13b](2026-09-13b-LIT-step8-sweep.md), [09-13c](2026-09-13c-LIT-step8-sweep.md), and [this morning's](2026-09-14-LIT-step8-sweep.md). *Recorded as holding no mechanism:* moment map and GIT (R22, F66), medial and isospectral algebras (R23), fusion-frame packing (R21), purity (R20), the Killing-constant bound (R19, F65), the frame split (R24, F67), Michel criticality, Łojasiewicz and Milnor--Thom, Z-eigenvector theory, and **this morning**: the literature on global maximisers of cubic forms (batch 1, nothing reaching the root), improvement constructions (every subalgebra projection is L214 again), the great-circle form of H4 (joint constraint, not closing on a plane).

## Directions for this sweep, each to be screened against the fences

1. **Joint statistics for splittings.** The F67 finding asks for inequalities that bound $\alpha\langle L_bc,c\rangle+\beta P(c)$ jointly. *In the literature: spectral bounds for cubic forms with a quadratic side constraint, S-lemma type results for cubics, trust-region subproblems for cubic objectives, and the theory of "Lagrangian duality with one quadratic constraint" for polynomial optimisation, where exactness is known in special cases.*
2. **L57 with one quadratic constraint.** L57's own proof (Dirichlet step, projection $Z(v)$, fourth moment) with a Lagrange term $\eta E(d)$: is there a published extremal result for $\sum_{i<j}K_{ij}^3+3\sum K_{ij}K_{jk}K_{ki}$ on zero-row-sum hollow matrices under a second quadratic constraint? *This is graph-theoretic (weighted triangle density with a degree condition), so flag algebras and spectral extremal graph theory are the adjacent fields, used as analytic inequalities rather than certificates.*
3. **Symmetrisation.** Does a rearrangement or polarisation on the $O(n)$-orbit, or on the sign group's characters, increase $P$ and move a tensor toward the diagonal? *A monotone symmetrisation would prove the root node without any splitting, and the record has no entry on it.*
4. **Stability of L57** (node (b)): quantitative forms of the diagonal theorem, which the sweep should search as stability of extremal problems for triangle densities.
5. **Outside the problem's boundary**: what field do "a cubic form on a nonassociative commutative algebra, maximised on the sphere, attained at an idempotent of a subalgebra" belong to once the Weyl names are removed? *Nonassociative algebra (Krasnov and Tkachev's Hsiang algebras were read in R23), Jordan-algebra norm inequalities, and the spectral norm of symmetric tensors are the obvious ones.*

## Rules for the sweep

Analysis only, screens of seconds on objects in hand allowed and reported as screens. Store every source under [references/](../references/) with its `notes.md`. Screen each candidate by grepping [findings/](../findings/) for its mechanism, and read [INDEX-literature.md](../findings/INDEX-literature.md) first. Present two to four routes as a scored table on section 1's rubric, with the distance to a proof of the goal, then stop for the user's choice.
