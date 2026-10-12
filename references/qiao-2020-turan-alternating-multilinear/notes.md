# Qiao, *Turán and Ramsey problems for alternating multilinear maps* (arXiv:2007.12820)

**Youming Qiao**, arXiv:2007.12820v4 [math.CO], 15 Aug 2023; Discrete Analysis 2023:12, 22 pp. Transcribed 2026-09-02 from [paper.txt](https://arxiv.org/abs/2007.12820) (`pdftotext -layout`). See [README.md](README.md) for the verdict: **the right field, and it does not contain the record's statement.**

## The dictionary this project came for, Proposition 5.1

> Recall that for an $\ell$-uniform hypergraph $H=([n],E)$, $S\subseteq[n]$ is an **independent set** in $H$ if $S$ does not contain any hyperedge from $E$. The independence number of $H$, $\alpha(H)$, is the maximum size over all independent sets in $H$. … The **totally-isotropic number** of $\varphi$, $\alpha(\varphi)$, is the maximum dimension over all totally-isotropic spaces of $\varphi$.

> **Proposition 5.1.** Let $H$ be an $\ell$-uniform hypergraph, and let $\varphi_H$ be the alternating $\ell$-linear map constructed from $H$ as in Section 5.2. Then we have $\alpha(H)=\alpha(\varphi_H)$.

Proof, as given: if $S$ is independent, $V=\mathrm{span}\{e_i\mid i\in S\}$ is totally isotropic. Conversely, if $V$ is totally isotropic of dimension $d$ with column-span matrix $B\in M(n\times d,\mathbb F)$ and $w_i^t$ the $i$-th row of $B$, pick $i_1<\cdots<i_d$ with $w_{i_j}$ linearly independent; were $\{i_1,\dots,i_\ell\}\in E$, total isotropy would give $w_{i_1}\wedge\cdots\wedge w_{i_\ell}=0$, contradicting independence.

**This is the statement that licenses reading a totally-isotropic subspace as a linear-algebraic independent set**, which is the analogy the record's bracket tensor $T_{abc}$ runs on. The $\ell=2$ case is [BCG+21].

## The three numbers, the vocabulary the record's Lemma 36 was missing

For $H=([n],E)$ $\ell$-uniform with $\mathrm{size}(H)=\lvert E\rvert$, and $n,m,\ell,a\in\mathbb N$:

> The **Turán number** is $T(n,a,\ell)=\min\{\mathrm{size}(H)\mid H$ is $\ell$-uniform, $n$-vertex hypergraph, and $\alpha(H)\le a\}$.
>
> The **Feldman–Propp number** is $\mathrm{FP}(a,m,\ell)=\min\{n\in\mathbb N\mid\forall\ \ell$-uniform, $n$-vertex, $m$-edge hypergraph $H$, $\alpha(H)>a\}$.
>
> $\alpha(n,m,\ell)=\min\{\alpha(H)\mid H$ is $\ell$-uniform, $n$-vertex, $m$-edge hypergraph$\}$.

Their relations, quoted: $T(n,a,\ell)\le m$ implies $\alpha(n,m,\ell)\le a$ and $\mathrm{FP}(a,m,\ell)>n$; $T(n,a,\ell)>m$ implies $\alpha(n,m,\ell)>a$ and $\mathrm{FP}(a,m,\ell)\le n$. In the multilinear setting the same three become $\alpha_{\mathbb F}(n,m,\ell)$, $T_{\mathbb F}(n,a,\ell)$, $\mathrm{FP}_{\mathbb F}(a,m,\ell)$, and Proposition 5.1 gives at once $\alpha_{\mathbb F}(n,m,\ell)\le\alpha(n,m,\ell)$.

**Every one of these is a $\min$ over the whole family.** The record's Lemma 36 is a $\max$ for one distinguished form, which is why none of them is it.

## Turán's theorem and its multilinear analogue

> Formulated in terms of independent sets, Turán's theorem gives that
> $$\alpha(n,m,2)\ge\Big\lceil\frac{n^2}{2m+n}\Big\rceil,\tag{5}$$
> where the equality can be achieved.

> The main result of [BGH87] states that for any $m>1$, we have
> $$\alpha_{\mathbb F}(n,m,2)\le\Big\lfloor\frac{m+2n}{m+2}\Big\rfloor,\tag{6}$$
> where the equality is attainable over any algebraically closed field. The inequality was also obtained earlier by Ol'shanskii [Ol'78] over finite fields.

Two footnotes worth keeping: the [BGH87] main result was stated for characteristic $\ne2$ but "the proof works for any characteristic"; and "For fields that are not algebraically closed, the equality may not be achieved. See [BGH87, Sec. 3] and [GQ06]."

## The main theorem, a Ramsey statement, not a Turán one

> **Theorem 1.1.** Let $\mathbb F$ be a field, $s,t\in\mathbb N$, $s,t\ge2$, and $n\ge s\cdot t^4$. Let $U$ be an $n$-dimensional vector space over $\mathbb F$. Then for any $\mathcal A\le\Lambda(U)$, either there exists $V\le U$, $\dim(V)=s$, such that $\mathcal A|_V$ is the zero space, or there exists $W\le U$, $\dim(W)=t$, such that $\mathcal A|_W=\Lambda(W)$.

> **Theorem 1.1, restated.** … For any alternating matrix space $\mathcal A\le\Lambda(n,\mathbb F)$, either there exists an $s$-dimensional totally-isotropic space of $\mathcal A$, or there exists a $t$-dimensional complete space of $\mathcal A$.

> **Theorem 4.1 (Theorem 1.1 for alternating bilinear maps).** Let $s,t\in\mathbb N$, $s,t\ge2$. Let $\varphi:\mathbb F^n\times\mathbb F^n\to\mathbb F^m$ be an alternating bilinear map over $\mathbb F$, where $n\ge s\cdot t^4$. Then $\varphi$ has either a dimension-$s$ totally-isotropic space, or a dimension-$t$ complete space.

The bound $n\ge s\cdot t^4$ is not far from optimal:

> **Proposition 5.2.** There exists an alternating bilinear map $\varphi:\mathbb F^n\times\mathbb F^n\to\mathbb F^m$, $n=\Theta(s\cdot t^2)$, such that $\varphi$ has neither a dimension-$s$ totally-isotropic space, nor a dimension-$t$ complete space.

## The Ramsey numbers

> **Definition 5.4.** For a field $\mathbb F$ and $s,t,\ell\in\mathbb N$, $s,t\ge\ell\ge2$, the **Ramsey number for complete spaces**, $R^c_{\mathbb F}(s,t,\ell)$, is the minimum number $n\in\mathbb N$ such that any alternating $\ell$-linear map $\varphi:(\mathbb F^n)^{\times\ell}\to\mathbb F^m$ has either a totally-isotropic space of dimension $s$, or a complete space of dimension $t$.

The **Ramsey number for anisotropic spaces** $R^a_{\mathbb F}(s,t,\ell)$ is defined the same way with anisotropic in place of complete spaces, and $R^a_{\mathbb F}(s,t,\ell)\le R^c_{\mathbb F}(s,t,\ell)$.

Qiao notes the obstruction to importing hypergraph Ramsey methods: "the 'correlation' in the linear algebraic world prohibits the divide and [conquer]".

## Provenance the paper records about its own method

> The initial strategy for our proof (in particular Steps 1 and 2, see Section 3) follows closely some ideas in **Weaver's** proof in [Wea17] and **Sims'** work on enumerating $p$-groups [Sim65, Sec. 2]. However, new ideas are indeed required, as in the alternating matrix space setting, **there are no diagonal matrices** which are crucial for Weaver's proof in the operator system setting. Furthermore, our result works over any field.

Weaver's quantum Ramsey theorem [Wea17]: for $n\ge8s^{11}$, any operator system has either an $s$-clique or an $s$-anticlique.

## Group-theoretic reading, via Baer's correspondence

$B_{p,2}$ is the class of finite $p$-groups of class 2 and exponent $p$ ($[G,G]\subseteq Z(G)$ and $g^p=\mathrm{id}$ for all $g$), and $G\in B_{p,2,n}$ iff $G/[G,G]\cong\mathbb Z_p^n$. Baer's correspondence [Bae38] connects $B_{p,2}$ with alternating bilinear maps over $\mathbb F_p$, and Corollary 4.2 restates Theorem 4.1 there. Corollary 4.4 gives the geometric reading: for $n\ge s\cdot t^4$, any $m$-fold hyperplane section of $\mathrm{Gr}(n,2)$ either contains $\mathrm{Gr}(W,2)$ for some $\dim W=s$, or misses a $t$-dimensional flat.

## What it cites

Lovász (Proc. Sixth British Combinatorial Conf., 1977), Buhler–Gupta–Harris [BGH87] (J. Algebra 1987), Feldman–Propp [FP92] (Adv. Math. 1992) as the origins; Ol'shanskii [Ol'78] for the finite-field ancestor; Turán [Tur41], [Tur61] and Sidorenko [Sid95] for the hypergraph side; Bollobás [Bol65] extended by Frankl [Fra82], Kalai [Kal84], Alon [Alo85]; Scott–Wilmer [SW21] for exterior-algebra extremal combinatorics; Gow–Quinlan [GQ06].

## Incomplete

Lemmas 3.1, 3.2, 3.3, 3.5 (the four steps of the Theorem 1.1 proof), Corollaries 4.2 and 4.4, and §§5.6–5.9 beyond Definition 5.4 are not transcribed. The proof is a construction of a complete space by successive change of basis; the record needs the vocabulary and the placement, not the construction.
