# Tkachev, *Metrized algebras and their applications*, slides, Covilhã, 9 July 2024

**Vladimir G. Tkachev** (Linköping University, Sweden), Universidade da Beira Interior, Covilhã, 9 July 2024, 43 slides. Transcribed 2026-09-02 from slides.txt (`pdftotext -layout`).

**These are slides.** Statements are labelled and several carry proofs, but hypotheses are sometimes carried implicitly by the running context of the talk. **Every statement below should be re-sourced to the cited paper before it enters the record**; the attributions the slides themselves give are recorded with each theorem.

## The correspondence, CMA(u)

For a cubic form $u$ with polarization $U$, $u(x)=\tfrac16U(x,x,x)$, the multiplication is defined by

> $$D^2u(x)(y,z)=U(x,y,z)=\langle x;y\bullet z\rangle,\tag{1}$$

equivalently $y\bullet z:=\mathrm{Hess}\,u(y)z$. **The algebra so defined on $A$ is denoted $\mathrm{CMA}(u)$**, and because $U$ is a symmetric trilinear form:

> (i) $x\bullet y=y\bullet x$ (the algebra $A(u)$ is commutative); (ii) $\langle x\bullet y;z\rangle=\langle y;x\bullet z\rangle$ ($A(u)$ is a Euclidean metrized algebra); (iii) $\langle x\bullet x;x\rangle=6u(x)$; (iv) $x\bullet x=2\nabla u(x)$.

The dictionary, as the slides summarise it: $u(x)=\tfrac16\langle x;x\bullet x\rangle$, $\nabla u(x)=\tfrac12x^{\bullet2}$, $\mathrm{Hess}\,u(x)y=x\bullet y$, $\mathrm{Hess}\,u(x)=L_\bullet(x)$ the multiplication operator, and **$L_\bullet(x)$ is self-adjoint**, hence diagonalizable over $\mathbb R$.

**This is the record's own construction**, stated as a categorical correspondence: "The correspondence between cubic forms and metrized algebra is categorical. The metrized algebras in this context are commutative but nonassociative."

## Idempotents, and the record's variational problem

> **Definition.** An idempotent $c$ in a $\mathrm{CMA}(u)$ is called **extremal** if $u$ attains a local maximum at $x:=c/\lvert c\rvert$, and it is called **minimal** if the maximum is global (obviously exists). In the latter case, $c$ has the shortest possible length among other idempotents.

with $u(c/\lvert c\rvert)=\tfrac16\langle x^2;x\rangle=\tfrac1{6\lvert c\rvert}$, so **maximising $u$ on the unit sphere is minimising idempotent length**, exactly the record's $\theta=1/\lVert c\rVert$.

> **Theorem A.** Any minimal idempotent $c$ in a Euclidean metrized algebra is **semisimple, primitive**, and except for the single eigenvalue $\lambda=1$, all other eigenvalues are $\le\tfrac12$.

Proof, as given on the slide: with $f(x)=\langle x^2;x\rangle/\lvert x\rvert^3:A^\times\to\mathbb R$, homogeneous of degree zero and regular off the origin,
$$\tfrac13\mathrm{Hess}(f(x))=\frac{2\lvert x\rvert^4L_x-\langle x^2;x\rangle\lvert x\rvert^2-3\lvert x\rvert^2(x\otimes x^2+x^2\otimes x)+5\langle x^2;x\rangle x\otimes x}{\lvert x\rvert^5},$$
where $(a\otimes b)(x)=a\langle b;x\rangle$. At a minimal idempotent $c$, a local maximum of $f$, $0\ge\tfrac13\mathrm{Hess}(f(c))=\big((2L_c-1)\lvert c\rvert^2-c\otimes c\big)/\lvert c\rvert^3$, and since $c\otimes c=0$ on $c^\perp$ one concludes $L_c\le\tfrac12$ on $c^\perp$. *The denominators should read $\lvert x\rvert^7$ and, at $c$, $\lvert c\rvert^5$ ([r1557](../../reviews/REVIEW_r1557.md)); the factor is positive, so the sign argument and the conclusion stand.*

> **Theorem (V. Tk., Comm. Alg., 2019).** If the equality $2\lvert c\rvert^2=\lvert e\rvert^2$ holds for some minimal idempotent $c$ in $A$ then $A$ is a Jordan algebra of Clifford type (a spin-factor).

*This is the paper transcribed at first hand in [tkachev-2019-clifford-extremal](../tkachev-2019-clifford-extremal/notes.md); the slide states it under the standing hypothesis of a **unital** metrized commutative nonassociative algebra with positive definite form, which is where $\mathcal W_n$ fails.*

> **Theorem (V. T., *The universality of one half…*, J. Algebra, 2021).** Let $A$ be a finite dimensional commutative nonassociative algebra over a field of characteristic $\ne2,3$ and let $A$ satisfy a nontrivial identity $P=\sum_\alpha\varphi_\alpha(x)x^\alpha=0$ in one nonassociative indeterminate $x$, where $x^\alpha\in N(x)=\{x,x^2,x^3,x^2x^2,xx^3,x^2x^3,x(x^2x^2),\dots\}$ and $\varphi_\alpha$ are polynomial functions. Then: (A) $\tfrac12$ is the Peirce number for any idempotent $c\ne0$; (B) if additionally $c$ is semi-simple and $\lambda$ is a single root of the Peirce polynomial then $A_c(\lambda)A_c(\tfrac12)\subset\bigoplus_{\nu\in\sigma(c),\nu\ne\lambda}A_c(\nu)$. (3)

> **Theorem B.** If $c$ is a minimal idempotent then $A_c(\tfrac12)A_c(\tfrac12)\subset A_c(\tfrac12)^\perp$ ('Jordan type fusion law').

Proof, as given: for $x\in A_c(\tfrac12)$, $c\bullet x=\tfrac12x$ gives $(c+x)^2=c+x+x^2$; $\langle c;x\rangle=\langle c\bullet c;x\rangle=\langle c;x\bullet c\rangle=\tfrac12\langle c;x\rangle$ so $\langle c;x\rangle=0$; and $\langle c;x^2\rangle=\langle c\bullet x;x\rangle=\tfrac12\lvert x\rvert^2$. Hence $\langle(c+tx);(c+tx)^2\rangle=\lvert c\rvert^2+\tfrac32\lvert x\rvert^2t^2+\langle x;x^2\rangle t^3$, and minimality gives
$$\frac1{\lvert c\rvert}=f(c)\ge f(c+tx)=\frac{\lvert c\rvert^2+\tfrac32\lvert x\rvert^2t^2+\langle x;x^2\rangle t^3}{(\lvert c\rvert^2+\lvert x\rvert^2t^2)^{3/2}}=\frac1{\lvert c\rvert}+\frac{\langle x;x^2\rangle}{\lvert c\rvert^3}t^3+O(t^4),$$
forcing $\langle x;x^2\rangle=0$ on $A_c(\tfrac12)$; polarization then gives $\langle xy;z\rangle=0$ for all $x,y,z\in A_c(\tfrac12)$.

**The Jordan-algebra example**, worked on its own slide: for $A$ the $n\times n$ real symmetric matrices with $x\bullet y=\tfrac12(xy+yx)$ and $\langle x;y\rangle=\mathrm{tr}(x\cdot y)$, one has $u(x)=\tfrac16\mathrm{tr}\,x^3$, every idempotent satisfies $\langle c;c\rangle=\mathrm{tr}\,c=\mathrm{rank}\,c\in\{1,\dots,n\}$, and **the minimal idempotents are exactly the primitive ones**, of norm 1.

## Hsiang algebras

> Let $u(x)$ be a **Hsiang cubic**, i.e. $\lvert\nabla u\rvert^2\Delta u-\nabla u(x)^\top\mathrm{Hess}(u(x))\nabla u(x)=\theta\lvert x\rvert^2u(x)$. This is equivalent to that a metrized algebra $A(u)$ satisfies the identity
> $$\langle x^2;x^2\rangle\,\mathrm{tr}\,L(x)-\langle x^2;x^3\rangle=\tfrac23\theta\langle x;x\rangle\langle x^2;x\rangle$$
> with $u(x)=\tfrac16\langle x;x^2\rangle$.
>
> **Definition.** Any commutative metrized algebra satisfying the latter identity is called a **Hsiang algebra**.
>
> One can show (nontrivial!) that in fact any non-trivial Hsiang algebra is **trace-free**, i.e. satisfies $\mathrm{tr}\,L(x)=0$.

> **Theorem C.** Given a nontrivial normalized $u$ [i.e. $\Delta_1u=-2\lvert x\rvert^2u(x)$, $x\in V=\mathbb R^n$], there exists a commutative metrized algebra such that
> 1. $u(x)=\tfrac16\langle x;x^2\rangle$ (the **recovering property**)
> 2. $x^3x+\tfrac14x^2x^2-\lvert x\rvert^2x^2-\tfrac23\langle x^2;x\rangle x=0$ (the **defining identity**)
> 3. $\mathrm{tr}\,L_x=0$ (the **harmonicity property**)
>
> In the converse direction, given a commutative metrized algebra with properties (2) and (3) above, the cubic form $u$ defined by (1) is a (normalized) Hsiang eigencubic.

> **Theorem D.** (i) For any nonzero idempotent $c$, the associated Peirce decomposition is
> $$A=A_c(1)\oplus A_c(-1)\oplus A_c(-\tfrac12)\oplus A_c(\tfrac12),\qquad\dim A_c(1)=1,$$
> and the following fusion laws hold:
>
> | $\bullet$ | $1$ | $-1$ | $-\tfrac12$ | $\tfrac12$ |
> |---|---|---|---|---|
> | $1$ | $1$ | $-1$ | $-\tfrac12$ | $\tfrac12$ |
> | $-1$ | $-1$ | $1$ | $\tfrac12$ | $-\tfrac12\oplus\tfrac12$ |
> | $-\tfrac12$ | $-\tfrac12$ | $\tfrac12$ | $1\oplus-\tfrac12$ | $-1\oplus-\tfrac12$ |
> | $\tfrac12$ | $\tfrac12$ | $-\tfrac12\oplus\tfrac12$ | $-1\oplus-\tfrac12$ | $1\oplus-1\oplus-\tfrac12$ |
>
> (ii) The Peirce dimensions $n_1=\dim A_c(-1)$, $n_2=\dim A_c(-\tfrac12)$ and $n_3=\dim A_c(\tfrac12)$ **do not depend on a particular choice of $c$**, and $n_3=2n_1+n_2-2$; (iii) all idempotents have the same length and satisfy the same fusion law.

The slide adds three structural remarks: the fusion law is **not graded in general**, though $\mathbb Z/2$-graded a posteriori in many particular cases; $V_c(1)\oplus V_c(-1)$ is a subalgebra **carrying a hidden Clifford algebra structure**; $V_c(1)\oplus V_c(-\tfrac12)$ is a subalgebra **carrying a hidden rank 3 Jordan algebra structure**.

## Polar algebras and the Clifford dichotomy

> **Definition.** A commutative metrised $\mathbb Z_2$-graded algebra $V=V_0\oplus V_1$ is called **polar** if $V_0\bullet V_0=0$ and $L(x)^2=\lvert x\rvert^2$ on $V_1$, for all $x\in V_0$.
>
> **Definition.** $A:X\to\mathrm{End}_S(Y)$ is a **symmetric Clifford system** ($A\in\mathrm{Cliff}(X,Y)$) if $A(x)^2=\lvert x\rvert^21_Y$ for all $x\in X$.
>
> **Proposition.** If $A\in\mathrm{Cliff}(X,Y)$ then the metrized algebra $(X\times Y)(u)$, where $u(x,y)=\tfrac12\langle y;A(x)y\rangle$, is a polar algebra with $V_0=X\times\{0\}$, $V_1=\{0\}\times Y$. Conversely, if $V=V_0\oplus V_1$ is a polar algebra then $L_x\in\mathrm{Cliff}(V_0,V_1)$. **Any polar algebra is a Hsiang algebra.**

> It is well-known that $\mathrm{Cliff}(X,Y)\ne\emptyset\iff\dim X\le1+\rho(\tfrac12\dim Y)$, where $\rho(m)=8a+2^b$ if $m=2^{4a+b}\cdot\text{odd}$, $0\le b\le3$, is the **Hurwitz–Radon function**.

> **Definition.** A Hsiang algebra $A$ isomorphic to a polar algebra is **of Clifford type**; otherwise it is **exceptional**.

> **Example.** Any commutative **pseudocomposition algebra** $A$, i.e. an algebra with $x^3=\lvert x\rvert^2x$ and $\mathrm{tr}\,L_x=0$, is an exceptional Hsiang algebra. The trace-free subspace of the Jordan algebra $(M_3,\circ)$ of all $3\times3$ real symmetric matrices with $x\circ y=\tfrac12(xy+yx)$ is a pseudocomposition algebra.

## The hidden structures, and the finiteness theorem

> **Theorem E.** Let $A$ be a Hsiang algebra and $c\in\mathrm{Idm}(V)$. Introduce on the invariant subspace $\Lambda_c:=\mathbb Rc\oplus A_c(-\tfrac12)$ the new multiplication
> $$x\bullet y=\tfrac12\big(xy+\langle x;c\rangle y+\langle y;c\rangle x-2\langle xy;c\rangle c\big),\qquad x,y\in\mathbb Rc\oplus A_c(-\tfrac12).\tag{6}$$
> Then $\Lambda_c$ is a **rank 3 Euclidean Jordan algebra with unit $2c$**, and any $x\in\Lambda_c$ satisfies the cubic identity
> $$x^{\bullet3}-2\langle x;c\rangle x^{\bullet2}+\big(2\langle x;c\rangle^2-\tfrac12\lvert x\rvert^2\big)x-\tfrac13\langle x;x^2\rangle c=0.\tag{7}$$
> Furthermore, **$A$ is exceptional if and only if $\Lambda_c$ is a simple Jordan algebra.**

> **Theorem F.** Let $V$ be a Hsiang algebra. The Peirce dimensions $n_1=\dim A_c(-1)$, $n_2=\dim A_c(-\tfrac12)$, $n_3=\dim A_c(\tfrac12)$ do not depend on a particular choice of $c$ and $n_3=2n_1+n_2-2$. Furthermore,
> $$n_1-1\le\rho(n_1+n_2-1),$$
> where $\rho$ is the Hurwitz–Radon function. **In particular, for each $n_2$ there exist only finitely many possible values of $n_1$.**

> **Theorem H.** If $V$ is an exceptional Hsiang algebra then $\dim\Lambda_c\in\{0,5,8,14,26\}$ for any $c\in\mathrm{Idm}(V)$, and the possible Peirce dimensions $n_1=\dim V_c(-1)$, $n_2=\dim V_c(-\tfrac12)$ are:

| $n$ | 2 | 5 | 8 | 14 | 26 | 9 | 12 | 15 | 21 | 15 | 18 | 21 | 24 | 30 | 42 | 27 | 30 | 33 | 36 | 51 | 54 | 57 | 60 | 72 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| $n_1$ | 1 | 2 | 3 | 5 | 9 | 0 | 1 | 2 | 4 | 0 | 1 | 2 | 3 | 5 | 9 | 0 | 1 | 2 | 3 | 0 | 1 | 2 | 3 | 7 |
| $n_2$ | 0 | 0 | 0 | 0 | 0 | 5 | 5 | 5 | 5 | 8 | 8 | 8 | 8 | 8 | 8 | 14 | 14 | 14 | 14 | 26 | 26 | 26 | 26 | 26 |

**The Hurwitz–Radon cap in Theorem F is a finiteness mechanism the record has met before**, and Theorem H is its explicit output; both are stated for **Hsiang** algebras, so applying them requires first checking the Hsiang identity for the record's algebra.

## Incomplete

The slides give no proofs for Theorems C, D, E, F, H, and no hypotheses beyond what is quoted. The 9-variable example $u(x)=\det\begin{psmallmatrix}x_1&x_2&x_3\\x_4&x_5&x_6\\x_7&x_8&x_9\end{psmallmatrix}$ on $\mathbb R^9$ is displayed without further comment, alongside Tkachev's own question: "There are several other examples, all having strange connections with Jordan algebras. Why??" The primary sources for Theorems A–H are not identified on the slides beyond the two attributions quoted above (Comm. Alg. 2019 and J. Algebra 2021), and **the record should locate the papers behind Theorems C–H before citing them.**
