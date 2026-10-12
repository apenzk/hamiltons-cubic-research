# Notes, Petersen–Stanfield, *Poincaré Polynomials and Curvature Operators of Symmetric Spaces*

Transcribed from [petersen-stanfield-2508.11236.txt](https://arxiv.org/abs/2508.11236) (`pdftotext -layout` of [petersen-stanfield-2508.11236.pdf](https://arxiv.org/abs/2508.11236)). Index card in [README.md](../INDEX.md). Posted August 2025.

## Theorem A

The curvature-operator eigenvalues of a compact irreducible symmetric space lie in $[0,\tfrac12]$, and there are **one, two, or three** distinct nonzero eigenvalues, all rational. Three occur for the complex Grassmannians.

**Read the quantifier carefully.** The statement is that only the complex Grassmannians **can** have three such eigenvalues, an inclusion, not an equivalence. Reading it as "exactly" is wrong, and $\mathrm{Gr}_{\mathbb C}(2,2)$ is the counterexample: it degenerates to two distinct values, because $a=b$ makes its two $\mathfrak{su}$ blocks equal.

## Proposition 2.2, the mechanism

Writing the isotropy algebra as centre plus simple factors,

$$\mathfrak h=\mathfrak h_0\oplus\bigoplus_i\mathfrak h_i,$$

**that decomposition is precisely the eigenspace decomposition of $R$**, with eigenvalue $\tfrac12$ on the centre.

**This is the statement that exposed a gap in the project's own enumeration.** The graded ansatz

$$W=\frac{q\,\Pi_{\mathfrak k}-p\,\Pi_{\mathfrak m}}{\sqrt{pq(p+q)}},\qquad p=\dim\mathfrak k,\ q=\dim\mathfrak m,$$

is scalar on the whole isotropy algebra, which Proposition 2.2 identifies as the special case $\mathfrak k$ simple. Whenever $\mathfrak k$ splits, the honest ansatz has one parameter per factor, and one script kept only the diagonal slice $a_1=\dots=a_r$. Re-running the reducible-isotropy classes on the full $(r+1)$-parameter family confirmed the conclusion while replacing the method that reached it.

## Theorem B

The maximum eigenvalue equals the Einstein constant exactly for the Hermitian symmetric spaces.

## §3.2, the $\mathbb{CP}^m$ data

Their tabulated $\mathbb{CP}^m$ curvature-operator eigenvalues match this project's Hermitian family row for row, which is how that family was identified as $\mathbb{CP}^m$ rather than $SO(2m)/U(m)$. The closed form is

$$\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)},$$

equal to exactly $3/2$ at $m=2$, **$W_{\mathbb{CP}^2}$ is the $m=2$ member of this family**, which is why the rival maximizer sits where it does. It decreases monotonically to $2/3$.

For simple isotropy they give $\lambda_{\mathfrak h}=\tfrac14\dim M/\dim\mathfrak h$ in closed form.

## §2.4, Jensen's metric, used here as a test case

They close §2.4 with the curvature operator of **Jensen's second homogeneous Einstein metric on $S^3\times S^3$**, non-symmetric, and visibly outside the symmetric class since Theorem A confines symmetric eigenvalues to $[0,\tfrac12]$ while Jensen's has a negative one. Spectrum: $\tfrac7{24}$ with multiplicity $3$, $\tfrac1{12}$ with $7$, $-\tfrac1{24}$ with $5$.

It was therefore the natural candidate for a high-$\theta$ ungraded critical point. Rebuilt here, its Weyl part has $\theta=\sqrt{6/5}$, criticality residual $3.0\times10^{-16}$, $\delta^2=5/48$, and slack $S=0$, i.e. **graded**. So a non-symmetric homogeneous Einstein metric can have a graded Weyl operator, and candidate ungraded witnesses cannot be found simply by picking non-symmetric homogeneous spaces.

## Verdict: the tables cannot close the enumeration

Graded critical points here are indexed by symmetric **pairs** $(\mathfrak h,\mathfrak k)$ with $\mathfrak h\subseteq\mathfrak{so}(n)$; Petersen–Stanfield classify symmetric **spaces**. A space's Weyl operator is graded only when its isotropy is a symmetric subalgebra of $\mathfrak{so}(n)$, so their tables do not enumerate what needs enumerating. The plan item proposing that route is withdrawn.

What they did supply, and it was worth the read: Proposition 2.2's structural correction, the $\mathbb{CP}^m$ identification, and the Jensen test case.
