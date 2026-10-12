# Gorodski, *An Introduction to Riemannian Symmetric Spaces*

- **Source**: lecture notes, Claudio Gorodski, IME-USP. [https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf](https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf)
- **Retrieved**: 2026-09-13. Stored as `gorodski-symmetric-spaces.pdf`, extracted with `pdftotext -layout` to `gorodski-symmetric-spaces.txt` (3535 lines).
- **Consulted for**: [I52](../../plan.md), the de Rham reduction step, which [ROUND_L48](../../verification/ROUND_L48.md)'s finding R10 records as having no argument on file and as the step by which [L48](../../findings/problem.md)'s symmetric-space theorem reaches products at all. The record mentions *de Rham* once in all of [findings/](../../findings/), in an unrelated parenthetical, and cites no source for it.

## Which numbered statements matter

| | |
|---|---|
| **Proposition 2.1.3 (Decomposition)** | the splitting itself, at the level of the orthogonal involutive Lie algebra: $\mathfrak g=\mathfrak g_0\oplus\dots\oplus\mathfrak g_r$ into $s$-invariant ideals with $\mathfrak g_0$ Euclidean and each $\mathfrak g_i$ irreducible |
| **Proposition 3.1.2** | $R_x(X,Y)Z=-[[X,Y],Z]$ on a **locally** symmetric space, so the curvature tensor is determined by the algebra |
| **Corollary 2.1.5** | $\mathfrak g$ is semisimple if and only if the algebra has no Euclidean factor |
| **Remark 2.1.6** | the decomposition of 2.1.3 is unique up to permutation of the simple factors |

## The verdict, and why this source settles the step better than the route the record sketched

**It settles it, and it settles it ALGEBRAICALLY, which is what makes the step cheap.** *Proposition 2.1.3 is a statement about the orthogonal involutive Lie algebra and carries no topological hypothesis, and Proposition 3.1.2 holds on a locally symmetric space.* **Together they give the splitting of the curvature tensor, with the mixed terms vanishing because ideals of a direct sum commute, and that is exactly what [L48](../../findings/problem.md) consumes.**

*The route the record had sketched, in [VERIFY_v192](../../verification/VERIFY_v192.md), goes through the manifold instead: "by de Rham a compact symmetric space splits into irreducible factors (and a flat factor); Einstein with $\lambda=\tfrac12$ kills the flat factor".* **That reading owes two steps this one does not.** *The geometric de Rham theorem needs simple connectivity, so it reaches a non-simply-connected compact symmetric space only through the universal cover, and then it owes compactness of that cover, which wants Myers. The record carries Myers nowhere.*

## What it does not cover

- **Myers' theorem** is absent (the notes mention only Myers--Steenrod, a different statement). *The algebraic route above is preferred precisely because it never needs it.*
- Nothing about $Q(W)=W^2+W^\#$, the cubic $P$, or this programme's objects. The source is consulted for one classical reduction.
