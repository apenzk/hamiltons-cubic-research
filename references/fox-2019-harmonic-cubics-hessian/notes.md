# Fox: harmonic cubics with $|\mathrm{Hess}|^2\propto|x|^2$, transcribed

**D. J. F. Fox, *Harmonic cubic homogeneous polynomials such that the norm-squared of the Hessian is a multiple of the Euclidean quadratic form*, [arXiv:1905.00071](https://arxiv.org/abs/1905.00071).** Line numbers are those of the extraction.

## The equations (1.1) and the spherical-harmonic reading (L46 to L52)

> This paper considers the problem of classifying, up to appropriate notions of equivalence and decomposability, homogeneous cubic polynomials $P\in\mathrm{Pol}^3(A)$ solving the equations $$\Delta_hP=0,\qquad|\mathrm{Hess}\,P|_h^2=\kappa|x|_h^2,$$ for some constant $\kappa\ne0$. When the metric $h$ is Euclidean the constant $\kappa$ must be positive. **The first equation simply means that the restriction of $P$ to the unit sphere $S^{n-1}$ is a spherical harmonic with eigenvalue $3(n+1)$.**

*Solutions are constructed in all dimensions $n\ge2$ and classified up to orthogonal equivalence for $n\le4$; the cubic isoparametric polynomials of Cartan are solutions (Lemma 8.1).*

## Theorem 1.10 (L237 to L251), the model solution

> On a Euclidean vector space $(A,h)$ of dimension $n\ge2$ there is a unique $CO(h)$-orbit of conformally associative solutions to (1.1), represented by $$P_n(x)=\frac{\sqrt{n(n+1)}}{6}\sum_{j=2}^n\frac1{\sqrt{j(j+1)}}\Big(x_j^3-3x_j\sum_{i=1}^{j-1}x_i^2\Big),$$ which solves (1.1) with constant $\kappa=n(n-1)$. Any $P$ in that orbit is orthogonally indecomposable and its automorphism group is the symmetric group $S_{n+1}$, acting as reflections through the hyperplanes orthogonal to lines on which $P_n$ vanishes and permuting the critical points of the restriction of $P_n$ to the unit sphere.

## What it settles for the record

**$P$ on the unit sphere of $\mathcal W_n$ is a spherical harmonic with Laplace eigenvalue $3(D+1)$, $D=\dim\mathcal W_n$**, because [Fox 2019](../fox-2019-nonassociative-curvature-algebra/notes.md) puts the Weyl cubic in the class (1.1). *That is a global analytic fact about $P$ and it holds on the whole space, not on a stratum.* **And the constant $\kappa$ in (1.1) is the same Killing constant Fox 2019 leaves uncomputed for $\dim V>4$**, since $|\mathrm{Hess}P|^2=36|L_x|^2_{HS}$ up to the normalisation of $P$.

**What it does not contain**: the Weyl cubic itself at $n\ge5$ is not among the classified or constructed solutions, and no statement bounds the maximum of a solution of (1.1) on the sphere in terms of $\kappa$ and the dimension, which is the statement the record would want.
