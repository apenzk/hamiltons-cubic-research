# Tkachev 2019 (survey), extraction

## Proposition 2.5 (p. ~10), verbatim

> **Proposition 2.5.** Let $V(u)$ be the algebra of a cubic form $u\not\equiv0$ on an inner product vector space $V$. Denote by $E$ the (nonempty) set of stationary points of the variational problem $\langle x,x^2\rangle\to\max$ subject to a constraint $\langle x,x\rangle=1$. Then for any $x\in E$, either $x^2=0$ or $c:=x/\langle x^2,x\rangle$ is an idempotent in $V$. In particular, the set of idempotents of $V(u)$ is nonempty. Furthermore, if $E_0\subset E$ denote the subset of local maxima in (19) then the corresponding idempotent $c=x/\langle x^2,x\rangle$ satisfies the extremal property
> $$\mathrm{spectrum}(L_c|_{c^\perp})\subset(-\infty,\tfrac12],$$
> where $c^\perp=\{x\in V:\langle x,c\rangle=0\}$. In particular, the eigenvalue $1$ of $L_c$ is simple (i.e. $c$ is a primitive idempotent).

Proofs are in their [54],[56]. This is this project's Lemma 24 plus the primitivity of the maximizer's idempotent (which this project observed as "$\lambda=1$ simple at maxima" via Reviewer 28's local-maximum fact).

## The dictionary (§2.3)

Any cubic form $u$ on an inner-product space defines a commutative metrised algebra $V(u)$ by $\langle xy,z\rangle=u(x,y,z)$; then $D^2u(x)=L_x$ and the ordinary calculus of $u$ on the sphere translates to Peirce data. Fox's algebra with $u=P$ is literally this construction restricted to $\mathrm{Weyl}_n$; the trace identities and the extremal bound are the standard toolkit of this literature.

## Pointers worth following

- [56] Tkachev, *On an extremal property of Jordan algebras of Clifford type*, Comm. Algebra, the hidden Clifford structure on $A_c(\tfrac12)$ at extremal idempotents, with dimension constraints of Hurwitz–Radon type.
- [57] Tkachev, *The universality of one half in commutative nonassociative algebras with identities*, J. Algebra 2021, why $\tfrac12$ is forced.
- §2.4: in the Jordan case the Peirce spectrum is exactly $\{1,\tfrac12,0\}$, i.e. the extremal bound is saturated by Jordan structure, the model case for "maximizer looks Jordan-like".

## Added 2026-09-12: the eiconal material, and why its theorem does not apply here

**Definition 3.1 and Proposition 3.2 (L732 to L756).** *A commutative algebra with a positive definite associating form satisfying $\langle x^2,x^2\rangle=\langle x,x\rangle^2$ is called eiconal, and it is eiconal if and only if $x^3=\langle x,x\rangle x$ for all $x$.* The proof linearises the identity at $x$ in the direction $y$, uses associativity of the form so $\langle xy,x^2\rangle=\langle y,x^3\rangle$, and reads off $x^3=\langle x,x\rangle x$ by nondegeneracy.

**Equations (40) and (41) (L760 to L770).** *Harmonicity is $\operatorname{tr}L_x=0$ for all $x$, and a further linearisation of $x^3=\langle x,x\rangle x$ in the direction $y$, eliminating $y$, gives* $$L_{x^2}+2L_x^2=\langle x,x\rangle+2x\otimes x.$$ Remark 3.3: $L_{x^2}$ then commutes with $L_x^2$ and eiconal algebras are the trace-free part of rank-three Jordan algebras.

**Proposition 3.5 (L844).** *At an idempotent $c$ of an eiconal algebra of dimension at least two the spectrum of $L_c$ on $c^\perp$ lies in $\{-1,\tfrac12\}$, every idempotent is primitive, and $V=\mathbb Rc\oplus V_{-1}(c)\oplus V_{1/2}(c)$.*

**The Weyl algebra is NOT eiconal, so Proposition 3.5 is unavailable at a critical point of $P$.** *Eiconal means $|W\circ W|^2=c|W|^4$ for every $W$, the harmonic-square law, which post F35 records as valid only on the $\circ$-decomposable stratum.* **What transfers is the method**: linearise an identity of the algebra, here criticality $W\circ W=\theta W$ together with Fox's $\operatorname{tr}L_x=0$ and $\operatorname{tr}(L_xL_y)=\kappa\langle x,y\rangle$, at a critical point in a direction $y$ and eliminate $y$ to reach an operator identity in $L_e$, which the record's per-index relations, all diagonal entries of operator identities, do not see. *Proposition 2.5 above, the bound $\tfrac12$ on the spectrum at a stationary idempotent, is the piece that DOES apply and is already the record's Lemma 24.*
