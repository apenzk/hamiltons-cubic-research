# Queffélec and Zarouf, On Bernstein's inequality for polynomials

| | |
| --- | --- |
| **Source** | [arXiv:1903.10801](https://arxiv.org/abs/1903.10801), Hervé Queffélec and Rachid Zarouf, 30 pages |
| **Retrieved** | 2026-09-13 |

## Consulted for

**The classical Bernstein inequality for trigonometric polynomials**, $\lVert T'\rVert_\infty\le N\lVert T\rVert_\infty$ at degree $N$, which bounds the third derivative of $P$ along a great circle in [Lemma L216](../../findings/second-order.md)'s isolation radius. *A survey was chosen over Bernstein's original because it states the inequality in the form used and is freely retrievable; the record needs only the classical statement.*

## Verdict

**The statement is here, in the abstract and again as the form "generally quoted", and it is what L216 uses.** *The third-derivative bound $\lVert\phi'''\rVert_\infty\le27\lVert\phi\rVert_\infty$ that L216 consumes is its three-fold iteration, legitimate because the derivative of a trigonometric polynomial of degree at most $N$ is again one of degree at most $N$, which the record argues in one line rather than cites.* **Nothing further in the survey is used**: its $L^p$ extensions, the Riesz interpolation formula and the algebraic-polynomial variants on the disc are outside what the lemma needs. *Mathlib carries Bernstein POLYNOMIALS for Weierstrass approximation in `Mathlib/Analysis/SpecialFunctions/Bernstein.lean` and not this inequality, so it enters the Lean file as a hypothesis.*
