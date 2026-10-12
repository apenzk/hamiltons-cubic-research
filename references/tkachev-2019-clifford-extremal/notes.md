# Tkachev, *On an extremal property of Jordan algebras of Clifford type* (arXiv:1801.05724)

**Vladimir G. Tkachev**, arXiv:1801.05724v1 [math.RA], 17 Jan 2018; Comm. Algebra **47** (2019) 1057–1066. Transcribed 2026-09-02 from [tk-1801.05724.txt](https://arxiv.org/abs/1801.05724) (`pdftotext -layout`). See [README.md](README.md) for the verdict: **the route is closed by unitality**, which $\mathcal W_n$ lacks.

**Duplicate folder.** [tkachev-2019-clifford-type-extremal](../tkachev-2019-clifford-type-extremal/) holds a byte-identical copy of the same PDF (MD5 `54e63531dbbac0ae5d79546d8eb52e90`) and its own notes. The two folders are the same source under two slugs.

## The setting, and why it is the record's setting

Standing hypotheses: $V$ is a finite-dimensional **commutative** nonassociative algebra over $\mathbb R$ carrying an **associative** nonsingular bilinear form,

> $$\langle xy,z\rangle=\langle x,yz\rangle,\qquad\forall x,y,z\in V,\tag{1}$$

and following M. Bordemann [1] such an algebra is called **metrised**. $V$ is assumed **Euclidean metrised**, i.e. the form is positive definite. In a metrised algebra $L_x$ is self-adjoint: $\langle L_xy,z\rangle=\langle y,L_xz\rangle$ (9).

## Proposition 2.1, the variational problem is Conjecture A's

> **Proposition 2.1.** Let $(V,\langle\cdot,\cdot\rangle)$ be a nonzero Euclidean metrised algebra (i.e. $VV\ne0$). Then the set $E$ of constrained stationary points of the variational problem
> $$\langle x,x^2\rangle\to\max\quad\text{subject to a constraint}\quad\langle x,x\rangle=1\tag{10}$$
> is nonempty and the maximum is attained. Denote by $E_0\subset E$ the (nonempty) set of local maxima in (10). Then for any $x\in E$, either $x^2=0$ or $c:=x/\langle x^2,x\rangle$ is an idempotent in $V$. If additionally $x\in E_0$ then $\langle x^2,x\rangle>0$.

**This is exactly the record's problem shape**, maximise the cubic on the unit sphere, and critical points are idempotents up to scale.

## The extremal idempotents

> **Definition 2.3.** An idempotent $c\in V$ is called **extremal**, or $c\in\mathrm{Idm}_1(V)$, if the function $\langle x^2,x\rangle$ attains its global maximum value at $c$ for all $x\in V$ satisfying $\lvert x\rvert=\lvert c\rvert$.

Consequences drawn immediately: $\langle x,x^2\rangle\le\tfrac1{\lvert c\rvert}\lvert x\rvert^3$ for all $x\in V$ with equality at $x=c$ (13); all extremal idempotents have the same length; and

> $$\lvert c\rvert\le\lvert c'\rvert,\qquad\forall c\in\mathrm{Idm}_1(V),\ \forall c'\in\mathrm{Idm}(V),\tag{14}$$

i.e. **the extremal idempotents are the shortest ones**.

> **Definition 2.5.** Let $V$ be a Euclidean metrised algebra with an associative inner product. The inner product is said to be **normalized** if $\langle x,x^2\rangle\le\lvert x\rvert^3$ (15) holds for all $x\in V$ and the equality holds for some $x\ne0$.

Equivalently, every extremal idempotent has length $1$, so $\mathrm{Idm}_1(V)=\{c\in V:c^2=c\text{ and }\lvert c\rvert^2=1\}$, and $\lvert c\rvert\ge1$ for every idempotent (16).

> **Proposition 2.6.** The equality in (15) is obtained for $x\ne0$ if and only if $x/\lvert x\rvert\in\mathrm{Idm}_1(V)$. **If $c\in\mathrm{Idm}_1(V)$ then $L_c\le\tfrac12$ on $c^\perp$.**

**That spectral bound is second-order optimality**, and it holds with no unit, it is the part of this paper that survives the record's failed hypothesis.

## Where the unit enters, and the extremal inequality it buys

If $V$ is **unital** with unit $e$, then $c\mapsto\bar c:=e-c$ is an involution on $\mathrm{Idm}(V)$: $\bar c^2=e-2ec+c=e-c=\bar c$ (3), $c\bar c=0$, and by associativity of the form $\langle c,\bar c\rangle=\langle c^2,\bar c\rangle=\langle c,c\bar c\rangle=0$ (4), so $c\perp\bar c$. With (2) this gives at once

> $$\lvert e\rvert^2=\lvert c\rvert^2+\lvert\bar c\rvert^2\ge2\lvert c\rvert^2,\qquad\forall c\in\mathrm{Idm}_1(V).\tag{5}$$

**Every step of (3), (4), (5) uses $e$.** This is where $\mathcal W_n$ falls out.

> **Definition 1.1.** A unital Euclidean metrised algebra such that the equality in (5) attains for some $c\in\mathrm{Idm}_1(V)$ is said to be **minimal**.

Normalized, minimality reads $\lvert e\rvert^2=2$ (18), whence $\langle e,c\rangle=1$ for every $c\in\mathrm{Idm}_1(V)$ (19).

> **Proposition 2.7.** If $V$ is a unital Euclidean metrised algebra and $\dim V\ge2$ then there exist at least two different idempotents in $V$ distinct from the unit.

## The structure of a minimal algebra

> **Proposition 2.8.** Let $V$ be a minimal algebra. Then all nonzero idempotents in $V$, except for the unit, are extremal: $\mathrm{Idm}(V)=\mathrm{Idm}_1(V)\cup\{e\}$. Furthermore, if $c\in\mathrm{Idm}_1(V)$ then
> $$L_c=\tfrac12\quad\text{on }c^\perp\cap\bar c^\perp.\tag{20}$$

Proof: for $0\ne c\ne e$, $2=\lvert e\rvert^2=\lvert\bar c\rvert^2+\lvert c\rvert^2\ge2$ forces $\lvert c\rvert^2=1$. Then $c,\bar c\in\mathrm{Idm}_1(V)$ give $L_c\le\tfrac12+c\otimes c$ and $L_{\bar c}\le\tfrac12+\bar c\otimes\bar c$; since $L_{\bar c}=1-L_c$ these squeeze to $\tfrac12-\bar c\otimes\bar c\le L_c\le\tfrac12+c\otimes c$, i.e. $L_c=\tfrac12$ on $c^\perp\cap\bar c^\perp$.

> **Proposition 2.9.** If $V$ is a normalized minimal algebra then for any $c_1,c_2\in\mathrm{Idm}_1(V)$ there holds
> $$2c_1c_2=c_1+c_2-\langle\bar c_1,c_2\rangle e.\tag{21}$$

Its proof uses $\langle e,c\rangle=\langle e,cc\rangle=\langle ec,c\rangle=\lvert c\rvert^2$ (22) and $\langle c_1,\bar c_2\rangle=\lvert c_1\rvert^2-\langle c_1,c_2\rangle$ (23), then decomposes $c_2=\langle c_1,c_2\rangle c_1+\langle\bar c_1,c_2\rangle\bar c_1+z$ with $z\in c_1^\perp\cap\bar c_1^\perp$ and applies (20).

> **Corollary 2.10.** Let $S\subset\mathrm{Idm}_1(V)$ be such that $e\in\mathrm{span}(S)$, then $\mathrm{span}(S)$ is a subalgebra of $V$.

## The main theorem

> **Theorem 1.2.** If $V$ is a minimal algebra then
> $$V=\mathrm{span}(\mathrm{Idm}_1(V)).\tag{8}$$
> Furthermore, $V$ is isomorphic to the Jordan algebra $e^\perp_f$ of the symmetric bilinear form $f(x,y)=\tfrac1{\lvert e\rvert^2}\langle x,y\rangle$, where $e^\perp=\{x\in V:\langle x,e\rangle=0\}$.

The target class, defined in §1: for a nonsingular symmetric bilinear form $f$ on $U$ over a field of characteristic $\ne2$, the space $k\oplus U$ with

> $$(a\oplus u)\bullet(b\oplus v)=(ab+f(u,v))\oplus(av+bu)\tag{6}$$

is a **Jordan algebra of bilinear form $f$**, denoted $U_f$, also called a Jordan algebra of Clifford type or a **spin-factor**. Its unit is $\epsilon=1\oplus0$, every $z=a\oplus u$ satisfies $z^2-z\,\mathrm{tr}\,z+d(z)\epsilon=0$ (7) with generic trace $\mathrm{tr}\,z=2a$ and generic norm $d(z)=a^2-f(u,u)$, and the trace form $t(z,w)=\mathrm{tr}(z\bullet w)$ is associative, so $U_f$ is metrised.

> **Proposition 3.1.** If $V$ is a minimal algebra then $V=\mathrm{span}(\mathrm{Idm}_1(V))$.

Its proof sets $W=\mathrm{span}(\mathrm{Idm}_1(V))$, a subalgebra by Corollary 2.10 containing $e$ since $c+\bar c=e$; assuming $W\ne V$, associativity of the form gives $WW^\perp\subset W^\perp$, and Proposition 2.8 gives $L_c=\tfrac12$ on $W^\perp$ (25), from which a contradiction follows.

> **Proposition 3.2.** If $V$ is a minimal algebra then $V$ is a Jordan algebra of Clifford type.

## Remark 2.4, the Jordan-algebra length facts

> It is well-known, see for example [3], that if $J$ is an Euclidean Jordan algebra equipped with the trace form $\langle x,y\rangle=\mathrm{tr}(xy)$ then for any idempotent $c\in\mathrm{Idm}(J)$: $\lvert c\rvert^2=n\in\mathbb Z_+$, i.e. the squared length takes only positive integer values, and an idempotent $c\in J$ is primitive if and only if it has minimal possible squared length. Furthermore, if $J$ is a spin factor then all (nonzero) idempotents have the same square length $\lvert c\rvert^2=1$.

## What it cites

Bordemann [1] for the term *metrised*; [3], [9] for Euclidean Jordan algebras and the trace form; [14] for the Griess algebra and the Monster; [4], [16], [7] for axial algebras; [13, Chapter 6], [12], [19], [20] for the algebras decoding cubic minimal cones and cubic solutions of elliptic PDEs, the family this project's Fox algebra belongs to.

## Incomplete

Corollary 2.2 and the remainder of the §3 computation completing Proposition 3.2 are not transcribed. Both concern the classification's endgame, which is closed to this project by unitality.
