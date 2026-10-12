# Petersen–Stanfield, the theorems, transcribed

**P. Petersen and J. Stanfield, *Poincaré polynomials and curvature operators of symmetric spaces*, [arXiv:2508.11236](https://arxiv.org/abs/2508.11236).** Page numbers are those of the extraction.

## The three theorems, verbatim (pp. 2–3)

> **Theorem A.** Any compact symmetric space has the property that the eigenvalues of the curvature operator lie in $[0,\tfrac12]$. Moreover, if the space is irreducible there can be one, two, or three distinct nonzero eigenvalues that are all rational numbers. Finally, only the complex Grassmannians can have three such eigenvalues.

> **Theorem B.** The following are equivalent for a compact irreducible symmetric space $M=G/H$: (1) the maximum eigenvalue for the curvature operator is $\tfrac12$; (2) $\mathfrak h$ has a center of dimension $1$; (3) $M$ is a Hermitian symmetric space; (4) $b_2=1$. The eigenvector for $\tfrac12$ corresponds precisely to the Kähler form.

> **Theorem C.** If $M=G/H$ where $H$ is simple, then there is only one nonzero eigenvalue $\lambda=\tfrac14\dim M/\dim H$. Moreover, either (1) $\dim M=\dim H$, in which case $G=H\times H$, i.e. $M$ is of type II and $b_3=1$, or (2) $\dim M\ne\dim H$, in which case $G$ is simple and $b_2=b_3=b_4=0$.

**Normalisation.** The Einstein constant is $\tfrac12$ throughout, so that the eigenvalue $\tfrac12$ of Theorem B is the Einstein constant (p. 12, "the eigenvalue for $\mathfrak h_0$ is the Einstein constant $\tfrac12$"). *That is the normalisation [L46](../../findings/problem.md) reads $\theta$ under.*

## What the proofs cite (Subsection 2.4, p. 12)

*The eigenvalue bound of Theorem A has a conceptual proof through a general formula for the curvature operator in terms of the Casimir of $\mathfrak h$ on $\Lambda^2\mathfrak p$ (Proposition 2.1), from which the eigenvalues are read as Casimir eigenvalues.* Theorem C follows from the Killing-form computation of Subsections 3.1 and 3.3. The Poincaré polynomials use Chevalley's and Takeuchi's formulas with Borel's degree lists.

## Subsection 3.1, type II (p. 11)

> Since the isotropy is simple we have that $\tfrac12\dim G=2\lambda_{\mathfrak g}\dim\mathfrak g$. Consequently $\lambda_{\mathfrak g}=\tfrac14$ in all cases.

## Subsection 3.3, simple isotropy (pp. 17–19), the table

> Aside from Lie groups there are several symmetric spaces that have simple isotropy group. In this case we quickly obtain a generalization of the formula for Lie groups: $\lambda_{\mathfrak h}=\tfrac14\dim M/\dim\mathfrak h$. Unlike for Lie groups this eigenvalue is never $\tfrac14$ as $\dim M\ne\dim\mathfrak h$ in all other cases. We include one exception, $SU(4)/SO(4)$, as it belongs to a family where all other spaces have simple isotropy group.

| space | $\dim M$ | $\dim H$ | $\lambda$ | Euler characteristic |
|---|---|---|---|---|
| $SU(2m+1)/SO(2m+1)$, $m\ge1$ | $(m-1)(2m+1)\cdot$ see text; $\dim=\tfrac{(2m)(2m+3)}2$ | $m(2m+1)$ | $\tfrac14\cdot\tfrac{2m+3}{2m+1}$ | $0$ |
| $SU(2m)/Sp(m)$, $m\ge2$ | $(m-1)(2m+1)$ | $m(2m+1)$ | $\tfrac12\cdot\tfrac{m-1}{2m}$ | $0$ |
| $E_6\,\mathrm I$: $E_6/Sp(4)$ | $42$ | $36$ | $\tfrac7{24}$ | $0$ |
| $E_6\,\mathrm{IV}$: $E_6/F_4$ | $26$ | $52$ | $\tfrac18$ | $0$ |
| $E_7\,\mathrm V$: $E_7/SU(8)$ | $70$ | $63$ | $\tfrac5{18}$ | $72$ |
| $E_8\,\mathrm{VIII}$: $E_8/Spin(16)$ | $128$ | $120$ | $\tfrac4{15}$ | $135$ |
| $F_4\,\mathrm{II}$: $F_4/Spin(9)=\mathbb{OP}^2$ | $16$ | $36$ | $\tfrac19$ | $3$ |

*The $SU(m)/SO(m)$ family with $m$ even appears as $SU(2m)/SO(2m)$, $m\ge2$, with $\dim=(m-1)(2m+1)$ under a different indexing; both parities are covered between the two rows and the exception $SU(4)/SO(4)$.* **Every $\lambda$ in the table is $\tfrac14\dim M/\dim H$, which is the check on the transcription.**

## Subsection 3.4, Hermitian (p. 20 onward)

*These all have a one-dimensional centre in $\mathfrak h$, the largest eigenvalue $\tfrac12$ on the Kähler form, and a second eigenvalue on the rest of $\mathfrak h$; the complex Grassmannians add a third.* Not transcribed here, the record's Hermitian and Grassmannian cases being closed already.

## What the record takes from it

**Theorem C alone.** *Every simple-isotropy space is [L4](../../findings/ungraded-slack.md)'s Casimir $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ at $r=\dim H$, critical by [L46](../../findings/problem.md), so L4's $\theta=\tfrac2n\sqrt{rN/(N-r)}$ applies and the Section 3.3 list evaluates it.* The largest value on the list is $\mathbb{OP}^2$ at $\theta=0.896$.
