# Krasnov–Tkachev, *Idempotent Geometry in Generic Algebras* (2018)

- **Link**: [Adv. Appl. Clifford Algebras 28:84](https://doi.org/10.1007/s00006-018-0902-7), open access; retrieved 2026-09-02 from [the Linköping copy](https://liu.diva-portal.org/smash/get/diva2:1245602/FULLTEXT01.pdf).
- **Authors**: Yakov Krasnov, Vladimir G. Tkachev, the same pair as [krasnov-tkachev-2018-idempotent-variety](../krasnov-tkachev-2018-idempotent-variety/README.md), which is the source [Lemma L24](../../findings/second-order.md) rests on.
- **Consulted for**: whether the literature bounds or determines the multiplicity of the $\tfrac12$-eigenvalue of $L_c$ at an idempotent, which is what [Lemma L126](../../findings/second-order.md) and [Lemma L127](../../findings/second-order.md) compute block by block.

## Verdict

**It does not cover the question.** The paper is about *idempotent configurations* in **generic** algebras, how many idempotents there are, how they sit relative to one another (syzygies, constellations, collinearity), counted by an Euler–Jacobi formula, and its detailed spectral results are for **two-dimensional commutative** algebras (Theorem 4.2 and its neighbours). It carries no second-variation statement, no extremality hypothesis, and no multiplicity bound applicable to $\mathrm{Weyl}_n$.

**What it does confirm** is the vocabulary: the $\tfrac12$-eigenspace this programme has been computing is the **Peirce $\tfrac12$-component** of $L_c$, and $\sigma(c)$ is the **Peirce spectrum**, terms [second-order.md](../../findings/second-order.md) already uses, so the framework was named in the record before this search.

**The Euler–Jacobi count in it does not extend to $\mathrm{Weyl}_n$, and the record already establishes that.** [second-order.md](../../findings/second-order.md) and [fence-posts.md](../../findings/fence-posts.md) close it on **both** of the identity's hypotheses: the root set is **infinite**, since the $O(n)$-orbit of an idempotent is a positive-dimensional family of idempotents, and $\mathrm{Weyl}_n^{\mathbb C}$ carries **nonzero $2$-nilpotents**, complex orbits of idempotents being positive-dimensional hence unbounded. *No equivariant form of the identity exists in the literature, and global-residue extensions handle isolated degenerate zeros rather than positive-dimensional ones.* **So the counting machinery is not a second route to [post F46](../../findings/INDEX-traps.md)'s one-critical-point claim**, which rests on $\nabla\det$ on the sphere and needs nothing from this paper.

## Where the extremality result actually lives

[krasnov-tkachev-2018-idempotent-variety](../krasnov-tkachev-2018-idempotent-variety/notes.md), Proposition 6.6, **and that transcription carries a repaired misprint**, found at Gate 2 by [r367](../../reviews/REVIEW_r367.md) and [r368](../../reviews/REVIEW_r368.md): the paper prints $2L_c-1\le c\otimes c$ where its own equation (56) gives the projector $(c\otimes c)/\lVert c\rVert^2$.
