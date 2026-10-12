# Notes, Mehta, Normand, Gupta, *A property of the structure constants of finite-dimensional compact simple Lie algebras*

Transcribed from [mehta-normand-gupta-cmp-1983.txt](https://projecteuclid.org/journals/communications-in-mathematical-physics/volume-90/issue-1/A-property-of-the-structure-constants-of-finite-dimensional-compact/cmp/1103940227.pdf) (`pdftotext -layout`).

## Abstract, verbatim

> We consider products of structure constants of a finite-dimensional compact simple Lie algebra, in which all indices except a few are contracted in pairs. We prove that such a product is zero if only one index is free, is proportional to the Cartan–Killing tensor if two indices are free and is proportional to a structure constant itself if three indices are free. For $SU(n)$, $n\ge3$ we also consider products of usual $d$ (related to the anti-commutator) and structure constants $f$. The results for one and two free indices are still valid. For three free indices the product is proportional to either an $f$ or a $d$ according to whether the number of $f$'s in the product is odd or even.

## The object and the counting rule (Introduction)

> In any higher order contribution to the ghost-gluon vertex, the colour dependent part will factor out and will be a combination of the structure constants with three free colour indices. ... The dots represent dummy indices which are contracted pairwise only. ... Elementary counting tells us that the number of $c$'s in Eq. (1.1) must be odd. In words: **a combination of an odd number of $c$'s with three free indices is a number times a single $c$**, provided the dummy indices in the combination are contracted pairwise.

Two proofs are given: a representation-theoretic one (§§2–4) and a direct one (§5); §6 records $SU(3)$ numerics.

## Why it matters here, and where it stops

**Where it applies.** The record's row-mass relation is the two-free-index case: $\sum_{b,c}c_{abc}c_{a'bc}=-K_{aa'}\propto\delta_{aa'}$, giving $\sum_{b,c}T_{abc}=2(n-2)$ for $\mathfrak{so}(n)$ in the record's normalization. The theorem says this is not one identity among many, **it is the only two-index invariant there is**, at any length of contraction. So no further relation on $T$'s marginals can come from contracting $c$ against itself.

**Where it stops.** The theorem's hypothesis is that all dummy indices are contracted *pairwise*, i.e. that the expression is an $O(N)$-invariant of the tensor $c$. The Hadamard square $T_{abc}=c_{abc}^2$ is invariant only under the **signed permutations** of the frame, not under $O(N)$, so it is not in the class. This is the exact sense in which T6 asks a question the classical invariant theory does not answer: $T$ is a frame-dependent object and the theorem is a statement about frame-independent ones.
