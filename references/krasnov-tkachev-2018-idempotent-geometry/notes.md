# Extraction, Krasnov–Tkachev, *Idempotent Geometry in Generic Algebras*

## The Peirce decomposition, as the paper states it (§2)

> Peirce decomposition: $A=\bigoplus_\lambda A_c(\lambda)$, where $cx=xc=\lambda x$ for any $x\in A_c(\lambda)$ and $\sigma(c)$ is the **Peirce spectrum** of $c$, i.e. the spectrum of the operator $L_c$.

**This is the vocabulary for what [Lemma L120](../../findings/second-order.md) decomposes and [Lemma L127](../../findings/second-order.md) computes.** The programme's $L_e$ is $L_c$ at the idempotent $e=W/\theta$, and its $\tfrac12$-eigenspace is $A_e(\tfrac12)$.

## What the paper proves, and why none of it reaches this programme

- **Proposition 3.1, 3.2, 3.5**, collinearity and planarity of idempotent configurations in a *generic* algebra.
- **Theorem 4.2**, a complete description of the Peirce spectrum for **two-dimensional commutative** algebras over a field, via the relations its equations (11) and (13) impose on $(\lambda_1,\lambda_2,\lambda_3)$.
- **A remark near p. 290**, for a class it treats, the Peirce spectrum of any non-unital idempotent is $\{1,0,\tfrac12,\dots,\tfrac12\}$.
- **Idempotent counting** by the **Euler–Jacobi formula**, with syzygies among the idempotents.

**Every spectral statement is dimension-two or genericity-conditioned**, and $\mathrm{Weyl}_n$ is neither two-dimensional nor generic in the paper's sense. **No extremality hypothesis appears**, so nothing here is a second-variation result: the extremal statement this programme uses is Proposition 6.6 of the *companion* paper, filed separately.

## The counting machinery does not reach $\mathrm{Weyl}_n$

The paper's **Euler–Jacobi formula** counts the idempotents of a generic algebra, and both of its hypotheses fail here, **finitely many simple roots** and **no nonzero $2$-nilpotents**. [second-order.md](../../findings/second-order.md) records the failure of each: the $O(n)$-orbit of an idempotent is a positive-dimensional family of idempotents, so the root set is infinite; and $\mathrm{Weyl}_n^{\mathbb C}$ carries nonzero $2$-nilpotents, since complex orbits of idempotents are positive-dimensional hence unbounded. It is tabulated at [fence-posts.md](../../findings/fence-posts.md) as *(G) via Euler–Jacobi*.

**So this paper offers no route the record does not already hold closed**, and in particular it is not a second derivation of [post F46](../../findings/INDEX-traps.md)'s claim that the half-flat single-four-set family carries one critical point. *That rests on the gradient of $\det$ on the sphere of traceless symmetric $3\times3$ matrices, which forces two equal eigenvalues.*
