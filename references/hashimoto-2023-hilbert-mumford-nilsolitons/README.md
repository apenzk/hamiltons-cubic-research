# Hashimoto, A Hilbert–Mumford criterion for nilsolitons

| | |
| --- | --- |
| **Source** | [A Hilbert–Mumford criterion for nilsolitons](https://arxiv.org/abs/2311.12469) · Trans. Amer. Math. Soc., to appear |
| **Identifier** | arXiv:2311.12469v3, 18 Nov 2025 |
| **Retrieved** | 2026-09-01 |

## Consulted for

Plan item [T9](../../plan.md): the current state of the art on the realizability question in the nilsoliton corner, is there a criterion, and does it live in the linear-system-with-positivity layer or above it? Read as the successor to [Nikolayevsky](../nikolayevsky-2011-pre-einstein-derivation/notes.md), whose nice-basis hypothesis it removes.

## Statements that matter

- **Theorem 1.1**, a homogeneous nilmanifold admits a left-invariant Ricci soliton **iff** $\nu(\lambda;\mu)\ge0$ for every self-adjoint $\lambda$ commuting with and orthogonal to $S=\mathbb R(I_n-\varphi_\mu)$, with equality iff $\lambda$ is a derivation. The weight is $\nu(\lambda;\mu)=-\min\{\lambda_i+\lambda_j-\lambda_k:\mu^k_{ij}\ne0\}$, **a function of the support of $\mu$ alone**.
- **Theorem 1.2(i)**, $\nu(\lambda;\mu)>0$ for all $\lambda\in\mathfrak p_B\setminus\mathrm{Der}(\mu)$ iff $P_0$, the projection of the origin to the affine span of $F_B$, lies in the interior of $\mathrm{Conv}(F_B)$.
- **Theorem 1.2(ii)**, that convex condition holds iff there are $\alpha_1,\dots,\alpha_m>0$ with $\sum_i\alpha_i=\lVert P_0\rVert^{-2}$ and $Y_BY_B^{\mathsf T}\alpha=[1]_m$. **Existence reduces to a positive solution of a linear system in the squares, plus one normalisation.**
- **The caveat the author states himself**, the reduction requires determining $F_B$ for *every* orthonormal basis diagonalising $\varphi_\mu$, "which should be a highly non-trivial problem".
- **Theorem 1.4**, a modified Taketomi–Tamaru conjecture, giving a genuine **obstruction** to the existence of nilsolitons from non-transitivity of $\mathrm{Aut}(\mu)\cap G$ on the associated symmetric space.

## Verdict

**The most recent word, and it confirms both halves of the T9 picture.** At a fixed support the whole existence question is a positive solution of a linear system in the squared structure constants (Nikolayevsky's equivalence, now with no nice-basis hypothesis) so relaxation-exactness at a fixed support is a theorem in the analogue and not a coincidence. What has no criterion is the layer above: which supports occur, and the reduction's own hard step is enumerating the admissible frames. The obstruction in Theorem 1.4 is a group-theoretic non-transitivity condition rather than anything a linear program can express, which is the second time this corner answers "the residual obstruction is not convex".
