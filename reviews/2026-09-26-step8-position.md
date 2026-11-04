# Step 9 position, 2026-09-26: I73 after the per-vector route reached its end

**Written at the head of the step 9 search the user opened (D2, 2026-09-26) after the reach gate fired on [R39](../routes.md), the per-vector criticality route for [I73](../plan.md) (c).** The deliverable is an analytic proof of P at every $n\ge12$.

## Phase 1: where the project stands

**Closed this session (all on the symmetric three-value family, $\lambda=(-a,0,a)$, $\kappa=\theta\sqrt{2p}$):**
- [L251](../findings/second-order.md), [L252](../findings/second-order.md), [L253](../findings/second-order.md): at $n=12$ the family above $\theta_0(12)$ has $8\le p\le13$. These rest on $n$-specific numbers and certificates.
- $n$-uniform, and the tools that survive: $\kappa\le\min(p-2,n-5)$ (L253, L244); the general per-element ceiling at every three-value spectrum (`general_ceiling`); the coupled fourth moment at every spectrum, $(p_0+2)\mathbb E\mathop{\mathrm{tr}}x^4+\tfrac{4(\lambda_2-\lambda_1)}{\lambda_2-\lambda_0}\mathbb ER_1=6+\tfrac{4(\lambda_0+(n-2)\lambda_2)}{\lambda_2-\lambda_0}-\tfrac3{p_0}\lVert\Omega_0\rVert^2$ (`general_coupled`); the multi-element Eckart–Young bound.

**What the list ran out of.** R39's $n$-uniform bounds exclude $p\le7$ and $p\gtrsim n^2/4$ only. In between, every per-vector ceiling is $\kappa=O(p)$ against a target $\kappa<\Theta_n\sqrt{2p}=O(\sqrt p)$. On the $n=12$ window a single element's per-vector system is exhausted by L249, and three follow-on routes closed (pair separation refuted by [r1206](REVIEW_r1206.md), [r1207](REVIEW_r1207.md); pencil common line; second order on single-plane directions, which gives $\pm1/\kappa$).

**What still stands between the project and the goal.** [I73](../plan.md): a global maximiser has two eigenvalues, after which [L105](../findings/bounds-relaxations.md) closes P. **Standing constraint from the [2026-09-22 position](2026-09-22-step8-position.md)**: padded $W_{\mathbb{CP}^2}$ is critical and locally maximal with three eigenvalues (below $\theta_0$), so any argument forcing two values must consume GLOBAL maximality, or restrict to $\theta$ above $\theta_0(n)$ as (c) does.

## The question for this sweep, stripped of the programme's names

*For a homogeneous cubic form $P$ on a real representation $V$ of a compact group ($O(n)$ on the Weyl tensors), at a critical point $W$ of $P$ on the unit sphere whose value exceeds a known competitor, what forces $W$'s associated self-adjoint operator (here the curvature operator on $\Lambda^2$) to have few eigenvalues?* In particular: **a mechanism whose bound scales with $\sqrt{\dim E_0}$ rather than $\dim E_0$**, which rules out per-vector (single-element) arguments, since those are linear in $p$.

Candidate fields: moment maps and Kirwan–Ness convexity for the $O(n)$ action (the eigenspace structure of a critical point as a moment-map condition); spectral inequalities for Lie-algebra subspaces (Casimir averages over a subspace, which scale like $\dim$); rigidity of linear spaces of low-rank skew matrices, quantitative (the $n=12$ window's missing step); second variation along directions mixing eigenspaces (L233/L234's pair quotients, blocked by the projection corrections, [F78](../findings/fence-posts.md)); Nienhaus's Theorem 4.17 with a weaker a-priori bound (the 2026-09-22 addendum's quantitative question, followed up in [ATTEMPTS.md](../ATTEMPTS.md) under "Repairing Theorem 4.17").

## Fence posts bearing on I73

- [F76](../findings/fence-posts.md): the class-level summed pair test cannot close (c), L173's witness at $\theta=\sqrt{21}/2$ satisfying the whole class system.
- [F77](../findings/fence-posts.md): per-eigenspace ingredients bounded, a row witness at $\kappa=p-3$.
- [F78](../findings/fence-posts.md): L247's certificate band is empty on the symmetric family.
- [F79](../findings/fence-posts.md): traced Bianchi is in the rows.
- [F39](../findings/fence-posts.md): (b) blind.
- [F67](../findings/fence-posts.md), [F43](../findings/bounds-relaxations.md), F15 to F18, F28: decoupled bounds, per-row families at three values, every LP and marginal relaxation.
- **This session**: per-vector criticality rows give ceilings linear in $p$; single-element systems are exhausted by L249; averaged rigidity equals $\mathbb E\mathop{\mathrm{tr}}x^4\le2n/(p+2)$; pencil and pair tests do not force line-sharing at the relevant radius.

## What previous sweeps covered

Ten sweeps on I73, the last on [2026-09-22](2026-09-22-LIT-step8-sweep.md): Łojasiewicz and gradient flow; spectral and isotype censuses (R12); the frame split (R24); tubes (R25); reflection induction (R26); Jin's $L^4$ route (R27); tight fusion frames and extremal cubics; the optimisation-theoretic question of global versus local maximisers of a cubic on a sphere (Z-eigenvalues, best rank-one approximation, nonnegativity of $\theta^2\lVert X\rVert^6-P(X)^2$, Morse theory on the sphere); and Nienhaus 2023 (the second-best Einstein metric), whose Theorem 4.17 is the localisation R25 wants, stopping at $n=11$ through a circularity. **Not yet asked**: the moment-map formulation of the eigenspace condition, and the $\sqrt p$ scaling requirement as a filter.

## Live items (graded)

I73 (grade 6 before the reach gate; `attackable` now $1$, a route must be invented); I36 stands on I73; I111, I113, I106b, I100, I71, I89, I68, I76, I77, I6, I104, I81 at value $\le2$; I1, I7, I37, I3, I4 at $0$.
