# Homma, *Bochner–Weitzenböck formulas and curvature actions on Riemannian manifolds* (arXiv:math/0307022)

Stored 2026-08-23. [paper.pdf](https://arxiv.org/abs/math/0307022), [paper.txt](https://arxiv.org/abs/math/0307022) (`pdftotext -layout`, 34 pages). Author is **Yasushi Homma**; the search result that surfaced it attributed it to Branson, and the folder slug kept that wrong name.

## What it is

Gradients (first-order invariant operators) have principal symbols governed by the enveloping algebra $U(\mathfrak{so}(n))$ and its **higher Casimir elements** $\hat c_q$. Homma derives relations in $U(\mathfrak{so}(n))$ and shows they induce *all* Bochner–Weitzenböck formulas for gradients, in the schematic form

> $\sum_i b_{\lambda_i}(D^{\rho_i}_\lambda)^*D^{\rho_i}_\lambda=\text{curvature action}$  (1.1)

## Theorem 3.4, verbatim

With $\hat e^q_{ij}$ the translated elements and $\hat c_q$ the Casimirs,

> $\hat e^q_{ij}=(-1)^q\hat e^q_{ji}-\dfrac{1-(-1)^q}{2}\hat e^{q-1}_{ji}+\displaystyle\sum_{p=0}^{q-1}(-1)^p\hat c_{q-1-p}\hat e^p_{ji}$

hence

> $\hat e^{2q}_{ij}=\hat e^{2q}_{ji}+\sum_{p=0}^{2q-1}(-1)^p\hat c_{2q-1-p}\hat e^p_{ji}$,
> $\hat e^{2q+1}_{ij}=-\hat e^{2q+1}_{ji}-\hat e^{2q}_{ji}+\sum_{p=0}^{2q}(-1)^p\hat c_{2q-p}\hat e^p_{ji}$

Proposition 3.2 records the generators: $\{c_2,c_4,\dots,c_{2m-2},\mathrm{pf}\}$ for $n=2m$.

## Relevance here

The project's operator is $T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$, so this is the right ambient algebra. **The second Casimir is already spent**: [fence post 18](../../findings/INDEX.md) shows $\mathrm{Cas}$ on $\mathrm{Weyl}_n$ equals $4(n-1)$, and that value is a consequence of $A(W)=2W$ and the Killing form. What is untried is $\hat c_4$ and above, degree-4 invariants of $W$ that are *not* reachable from the quadratic identity, which is the only sense in which this reference is still live.
