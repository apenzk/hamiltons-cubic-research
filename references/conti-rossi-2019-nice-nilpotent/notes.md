# Notes, Conti, Rossi, *Construction of nice nilpotent Lie groups*

Transcribed from [conti-rossi-1803.09248.txt](https://arxiv.org/abs/1803.09248) (`pdftotext -layout`); line references are to that dump.

## The shape of the problem (L72–L85, verbatim)

> The set of nice Lie algebras associated to a diagram $\Delta$ is represented by an open set in a real vector space $V_\Delta$, parametrizing the nonzero structure constants relative to the nice basis. The natural action of $D_n$ can be used to normalize some structure constants to $\pm1$, producing a fundamental domain for this action ... The resulting elements of $V_\Delta$ define a nice nilpotent Lie algebra provided **the Jacobi identity is satisfied; this is a system of quadratic equations in the structure constants**. For $n\le8$ these equations reduce to linear equations thanks to the normalizations performed earlier; in dimension $9$ there are only $20$ diagrams for which quadratic equations survive the normalization; it turns out that only $12$ of them give rise to continuous families of Lie algebras.

## Proposition 1.3 and the Jacobi expression (L241–L256, verbatim)

> **Proposition 1.3.** Given a labeled diagram $\Delta$ satisfying (N1)–(N3) and $c\in V_\Delta$, define $d:(\mathbb R^n)^*\to\Lambda^2(\mathbb R^n)^*$ by $de^k=\sum_{\{\{i,j\},k\}\in I_\Delta}c_{ijk}e^{ij}$, $i<j$. This defines a Lie algebra with diagram $\Delta$ if and only if all of the following hold:
> - for each $I\in I_\Delta$, $c_I\ne0$;
> - $\sum_{I,J\in I_\Delta}c_Ic_JE_{IJ}$ lies in the kernel of $a$.

with $a:\Lambda^2(\mathbb R^n)^*\otimes(\mathbb R^n)^*\otimes\mathbb R^n\to\Lambda^3(\mathbb R^n)^*\otimes\mathbb R^n$ the alternator.

## The support consequence (L305–L318, verbatim)

> Notice that the kernel of $a$ is spanned by elements of the form $e^{ij}\otimes e^i\otimes e_h$, $e^{ij}\otimes e^k\otimes e_h+e^{kj}\otimes e^i\otimes e_h$; **thus, terms of the form $e^{ij}\otimes e^k\otimes e_h$ with $k$ distinct from $i,j$ must appear in pairs or triples inside the sum $\sum_{I,J\in I}c_Ic_JE_{IJ}$.** The Jacobi identity implies a condition on the diagram:
> **(N4)** There do not exist four different nodes $i,j,k,v$ such that exactly one of $i\xrightarrow{j,k}v$, $j\xrightarrow{k,i}v$, $k\xrightarrow{i,j}v$ is a double arrow.
> In terms of the Gram matrix $U=M_\Delta{}^tM_\Delta$ considered in [28], double arrows correspond to entries equal to $-1$; condition (N4) is equivalent to nonexistence of quadruples of multiplicity one in the sense of [30].

**This is the whole mechanism in one sentence.** A monomial $c_Ic_J$ cannot stand alone: it must be cancelled by a partner. Where no partner exists the coefficient is forced to zero, a **support** statement, which the squares see. Where a partner exists, all Jacobi asks is that the partners cancel, a **sign** statement, which the squares do not see.

## Where Jacobi is vacuous (§2.4, L668–L672, verbatim)

> In this special situation the Jacobi identity follows automatically from the definition of nice diagram, which in this case rules out the existence of double arrows (see Remark 1.8), or bad pairs in the language of [20].

## A surviving quadratic equation (Example 1.4, L288–L292, verbatim)

> This means that the Jacobi identity contains an equation with three terms, i.e.
> $$c_{123}c_{347}+c_{246}c_{617}+c_{415}c_{527}=0.$$
> In this case, the equations admit a solution; up to equivalence, we find the one-parameter family of Lie algebras $754321{:}9\ (0,0,(1-\lambda)e^{12},e^{13},\lambda e^{14}+e^{23},e^{24}+e^{15},e^{34}+e^{25}+e^{16})$.

## Algorithm, Step C (L609–L620, verbatim)

> **Step C.** On each component $W_j$, impose the Jacobi identity $\sum_{I,J}c_Ic_J\,a(E_{IJ})=0$; this is a system of polynomial equations in the $c_I$, some of which have degree less than two thanks to the assumptions (3). Neglecting quadratic equations for the moment, determine the subspace of $W_j$ where the linear equations are satisfied ...

The degree drop is an artefact of the normalization $c_I=\pm1$ on part of the index set, i.e. of **fixing magnitudes to 1 and leaving only signs**. It is not a statement that Jacobi is linear in anything.

## What this settles for T6

- **Realizability from magnitudes has no criterion in the literature.** The state of the art enumerates by computer to dimension $9$ ([DEMONbLAST](https://github.com/diego-conti/DEMONbLAST)); dimension $>9$ is stated to be out of practical reach.
- **The support consequence is real and is the only one that survives squaring.** (N4) is a condition on $\mathop{\mathrm{supp}}T$ and nothing else.
- **Everything else is sign cancellation.** Remark 2.11 makes the point sharply: over $\mathbb C$ all constants normalize to $1$ and each nice diagram gives at most one family, while over $\mathbb R$ some diagrams die, the real/complex difference is entirely in the signs, with the magnitudes identical.
