# Chayes, transcription

Conventions: $\lVert X\rVert_p=\mathop{\mathrm{Tr}}[(X^*X)^{p/2}]^{1/p}$, $\sigma(X)$ the singular values, $\sigma^\downarrow,\sigma^\uparrow$ their decreasing and increasing rearrangements, $a\prec b$ majorisation and $a\prec_w b$ weak majorisation.

> **Theorem 2.1** (Hardy–Littlewood–Pólya, Tomić, Weyl). Suppose $a\prec_w b$. Then for any $f:\mathbb R\to\mathbb R$ increasing and convex on the domain containing all entries of $a$ and $b$, $\sum_if(a_i)\le\sum_if(b_i)$. If $a\prec b$ the increasing requirement can be dropped. (p. 2)

> **Theorem 2.4** (Fan). Let $A,B\in M_{n\times n}(\mathbb C)$ be self-adjoint. Then $\lambda(A+B)\prec\lambda(A)+\lambda(B)$. (p. 2)

> **Theorem 2.5** (Gel'fand–Naimark). Let $A,B\in M_{n\times n}(\mathbb C)$. Then $\sigma(AB)\prec_{(\log)}\sigma(A)\sigma(B)$. (p. 2)

> **Theorem 3.1.** Let $A,B$ be self-adjoint and commuting. Then $\lVert\sigma(A)+\sigma(B)\rVert_p^p+\lVert\sigma(A)-\sigma(B)\rVert_p^p\le\lVert A+B\rVert_p^p+\lVert A-B\rVert_p^p\le\lVert\sigma^\uparrow(A)+\sigma^\downarrow(B)\rVert_p^p+\lVert\sigma^\uparrow(A)-\sigma^\downarrow(B)\rVert_p^p$ for $1\le p\le2$, reversed for $p\ge2$, with equality for $p\ne1,2$ exactly at the extremal arrangement. (p. 3)

**The counterexamples** (p. 1, Section 3): taking $B$ unitary makes the aligned and up-down arrangements coincide, so the two conjectured inequalities would force equality for every unitary $B$, which fails numerically. *The paper's reading: non-commutativity ruins the commutative rearrangement identity.*

**What the record takes.** Fan's Theorem 2.4 is the majorisation fact a Schur–Horn style alignment argument would use, and the counterexamples are a warning that rearrangement statements proved for commuting matrices do not transfer to non-commuting ones by default. Nothing here bounds $\sum_a\mathop{\mathrm{tr}}Y_a^3$ or any trace of three distinct matrices.
