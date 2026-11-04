# Howe–Tan–Willenbring, *Stable branching rules for classical symmetric pairs*

- [arXiv:math/0311159](https://arxiv.org/abs/math/0311159); published Trans. Amer. Math. Soc. 357 (2005), 1601–1626.
- Local copies: [htw-math0311159.pdf](https://arxiv.org/abs/math/0311159), text extraction [htw-math0311159.txt](https://arxiv.org/abs/math/0311159).

## Why it is here

It supplies, from the literature, the $U(m)$-isotypic decomposition of $\mathrm{Weyl}_{2m}$ that Reviewer 40's cycle needed, the $\mathbb{CP}^m$ analogue of Nienhaus's Proposition 4.6 for $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$.

## The load-bearing statement, quoted verbatim from §2.3.1 of the source

> **2.3.1. $GL_n \subset O_{2n}$.** Let $\mu^+$, $\mu^-$ and $\lambda$ be non-negative integer partitions with at most $\lfloor n/2\rfloor$ parts, then
> $$\left[E^\lambda_{(2n)},\ F^{(\mu^+,\mu^-)}_{(n)}\right] = \sum c^\gamma_{\mu^+\mu^-}\, c^\lambda_{\gamma,(2\delta)'}$$
> where the sum is over all non-negative integer partitions $\delta$ and $\gamma$.

$E^\lambda_{(2n)}$ is the $O(2n)$-irreducible labelled by $\lambda$, $F^{(\mu^+,\mu^-)}_{(n)}$ the rational $GL_n$-irreducible of highest weight $(\mu^+_1,\dots,0,\dots,-\mu^-_2,-\mu^-_1)$, and $c$ the Littlewood–Richardson coefficients. The embedding is the "polarization" one, $GL_m\subset O_{2m}$ acting on $\mathbb C^m\oplus(\mathbb C^m)^*$, the complexification of $U(m)\subset SO(2m)$.

## Specialisation used here

$\mathrm{Weyl}_{2m}\otimes\mathbb C$ is the $O(2m)$-irreducible $E^{(2,2)}$, so $\lambda=(2,2)$ and $n=m$; the rule applies once $\lfloor m/2\rfloor\ge2$, i.e. $m\ge4$. The three $(\gamma,\delta)$ contributing are $((2,2),\varnothing)$, $((1,1),(1))$ and $(\varnothing,(1,1))$, each with coefficient $1$, and the resulting ten $(\mu^+,\mu^-)$ are pairwise distinct with multiplicity one, so **the decomposition is multiplicity-free for every $m\ge4$**. Computed in [review_r40_branching.py](../../scripts/review_r40_branching.py) with a from-scratch Littlewood–Richardson routine, and it agrees summand for summand with the numerically measured decomposition at $m=3,4,5,6$.

The ten highest weights, and the $L_e$ eigenvalue each carries at $W_{\mathbb{CP}^m}$:

| $GL(m)$ highest weight | real dimension | $L_e$ |
| --- | --- | --- |
| $(0^m)$ | $1$ | $1$ |
| $(1,0^{m-2},-1)$, adjoint $\mathfrak{su}(m)$ | $m^2-1$ | $\frac{m+2}{2(m+1)}$ |
| $(1,1,0^{m-2})\oplus$ dual | $m(m-1)$ | $\frac12$ (orbit tangent) |
| $(1,1,0^{m-4},-1,-1)$ | $\frac{m^2(m+1)(m-3)}{4}$ | $\frac{2}{m+1}$ |
| $(2,2,0^{m-2})\oplus$ dual | $\frac{m^2(m^2-1)}{6}$ | $-\frac{3}{m+1}$ |
| $(2,1,0^{m-3},-1)\oplus$ dual | $\frac{2m^2(m^2-4)}{3}$ | $0$ |
| $(2,0^{m-2},-2)$ | $\frac{m^2(m-1)(m+3)}{4}$ | $0$ |

The seven real dimensions sum to $\dim\mathrm{Weyl}_{2m}=\frac{m(m+1)(2m+1)(2m-3)}{3}$ identically in $m$ (checked symbolically), and the eigenvalues satisfy $\mathop{\mathrm{tr}}L_e=0$ identically in $m$. At $m=3$ the fourth summand has dimension $0$, which is exactly where its eigenvalue $2/(m+1)$ would have collided with $\tfrac12$.

## Related literature located but not stored

- **Tricerri–Vanhecke**, *Curvature tensors on almost Hermitian manifolds*, Trans. Amer. Math. Soc. **267** (1981), 365–397, the classical $U(m)$-decomposition of the whole curvature-tensor space $\mathcal R(V)$ over a Hermitian vector space. Its component count matches this one exactly once the Ricci and scalar parts are added back: $S^2_0(\mathbb R^{2m})$ contributes two more $U(m)$-summands and the scalar one, giving $7+2+1=10$ summands at $m\ge4$ and $6+2+1=9$ at $m=3$, the counts quoted for that decomposition in the almost-Hermitian literature. The AMS PDF is behind a JavaScript gate and was not retrieved.
