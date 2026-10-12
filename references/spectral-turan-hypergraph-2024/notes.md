# Liu, Ni, Wang & Kang, *Hypergraph extensions of spectral Turán theorem* (arXiv:2408.03122)

**Lele Liu, Zhenyu Ni, Jing Wang, Liying Kang**, arXiv:2408.03122v1 [math.CO], 6 Aug 2024, 34 pp. Transcribed 2026-09-02 from [gao-2408.03122.txt](https://arxiv.org/abs/2408.03122) (`pdftotext -layout`). See [README.md](README.md) for the verdict.

**The folder's file name and its README attribution are wrong.** The local file is named `gao-2408.03122` and the README says "Gao et al."; the paper's own title page names the four authors above. Gao appears only in the paper's bibliography, as Gao–Chang–Hou [19].

## The definition the record came for, the $p$-spectral radius

> Given an $r$-graph $H$ of order $n$, and a vector $x=(x_1,\dots,x_n)^T\in\mathbb R^n$, denote $P_H(x)=r!\sum_{e\in E(H)}\prod_{v\in e}x_v$. The $p$-spectral radius of $H$ is defined as
> $$\lambda^{(p)}(H):=\max_{\lVert x\rVert_p=1}P_H(x)=\max_{\lVert x\rVert_p=1}r!\sum_{e\in E(H)}\prod_{v\in e}x_v,\tag{1.1}$$
> where $\lVert x\rVert_p:=(\lvert x_1\rvert^p+\cdots+\lvert x_n\rvert^p)^{1/p}$. If $x\in\mathbb R^n$ is a vector with $\lVert x\rVert_p=1$ such that $\lambda^{(p)}(H)=P_H(x)$, then $x$ is called an **eigenvector** corresponding to $\lambda^{(p)}(H)$.

**This is precisely the record's own object shape**, a cubic form maximised on a normed sphere, with the norm's exponent a free parameter. The eigenvalue equation, by Lagrange's method, for $x\in S^{n-1}_{p,+}$ (the nonnegative unit sphere):

> $$\lambda^{(p)}(H)x_i^{p-1}=(r-1)!\sum_{\{i,i_2,\dots,i_r\}\in E(H)}x_{i_2}\cdots x_{i_r}\quad\text{for }x_i>0.\tag{1.2}$$

**The record's critical-point equation is the $p=2$, $r=3$ case of (1.2).**

> **Remark 1.1.** It is worth mentioning that the $p$-spectral radius $\lambda^{(p)}(H)$ shows remarkable connections with some hypergraph invariants. For instance, the quantity $\lambda^{(1)}(H)$ is the **Lagrangian** of $H$, the quantity $\lambda^{(2)}(H)$ is the notion of hypergraph spectral radius introduced by **Friedman and Wigderson** [14], $\lambda^{(r)}(H)/(r-1)!$ is the usual spectral radius introduced by **Cooper and Dutle** [8], $\lambda^{(\infty)}(H)/r!$ is the number of edges of $H$.

**That interpolation is the paper's whole point**: one parameter carries the Lagrangian at $p=1$, the spectral radius at $p=2$, and the edge count at $p=\infty$, so a single theorem yields the Turán theorem and its spectral analogue at once.

## The problem posed

> **Problem 1.1.** Let $p>r-1\ge2$, and $\mathcal F$ be a family of $r$-graphs. What is the maximum $p$-spectral radius of an $r$-graph $H$ on $n$ vertices without no member of $\mathcal F$ as a subgraph?

Definitions used throughout: an $r$-graph $H$ is **$k$-partite** if $V(H)$ splits into $k$ sets with each edge meeting each set at most once; an edge-maximal such is **complete $k$-partite**; $T_r(n,k)$ is the complete $k$-partite $r$-graph on $n$ vertices with no two parts differing by more than one in size, with edge count

> $$t_r(n,k)=\sum_{S\in\binom{[k]}{r}}\prod_{i\in S}\Big\lfloor\frac{n+i-1}{k}\Big\rfloor=\big(1-O(n^{-1})\big)\cdot\frac{(k)_r}{k^r}\binom nr,\tag{1.3}$$

where $(k)_r$ denotes the falling factorial $k(k-1)\cdots(k-r+1)$.

The two forbidden families, verbatim:

> For $t\ge r+1$, let $\mathcal K^{(r)}_t$ be the family of all $r$-graphs $F$ with at most $\binom t2$ edges such that for some $t$-set $C$ (called the **core**) every pair $u,v\in C$ is covered by an edge of $F$. … Let the $r$-graph $H^{(r)}_t\in\mathcal K^{(r)}_t$ be obtained from the complete 2-graph $K_t$ by enlarging each edge with a new set of $(r-2)$ vertices.

> For $k\ge r\ge2$, let $\mathcal F^{(r)}_k$ be the set of all minimal $r$-graphs $F$ such that there is a $k$-set $C$ (called the core) such that at least one edge $e\in E(F)$ lies entirely in $C$ and every pair of vertices of $C$ is covered by an edge of $F$. Let $F^{(r)}_k$ be the $r$-graph with edges: $[r]$ and $E_{ij}\cup\{i,j\}$ over all pairs $\{i,j\}\in\binom{[k]}2\setminus\binom{[r]}2$, where $E_{ij}$ are pairwise disjoint $(r-2)$-sets disjoint from $[k]$.

## The main results, with full hypotheses

> **Theorem 1.1.** For any $p\ge r\ge2$, there is $n_0$ such that for any $H^{(r)}_{k+1}$-free $r$-graph $H$ on $n>n_0$ vertices, $\lambda^{(p)}(H)\le\lambda^{(p)}(T_r(n,k))$, with equality if and only if $H\cong T_r(n,k)$.

> **Theorem 1.2.** For any $p\ge r\ge2$, there is $n_0$ such that for any $F^{(r)}_{k+1}$-free $r$-graph $H$ on $n>n_0$ vertices, $\lambda^{(p)}(H)\le\lambda^{(p)}(T_r(n,k))$, with equality if and only if $H\cong T_r(n,k)$.

> **Remark 1.2.** If $r=2$, Theorem 1.1 corresponds to the spectral Turán theorem with respect to $p$-spectral radius, as established by **Kang and Nikiforov** [26] in 2014.

The corollaries obtained by specialising or by letting $p\to\infty$:

| | statement |
|---|---|
| **Corollary 1.1** | $p\ge r\ge2$: a $\mathcal K^{(r)}_{k+1}$-free $r$-graph $H$ on $n$ vertices has $\lambda^{(p)}(H)\le\lambda^{(p)}(T_r(n,k))$ for large $n$, equality iff $H\cong T_r(n,k)$ |
| **Corollary 1.2** | the same for Berge-$K_{k+1}$-free $r$-graphs. ($H$ is a **Berge-$G$** if there is a bijection $\varphi:E(G)\to E(H)$ with $e\subseteq\varphi(e)$ for all $e$) |
| **Corollary 1.3 ([46])** | Pikhurko's edge result, recovered as $p\to\infty$: $H^{(r)}_{k+1}$-free implies $e(H)\le t_r(n,k)$, equality iff $H\cong T_r(n,k)$ |
| **Corollary 1.4** | Berge-$K_{k+1}$-free implies $e(H)\le t_r(n,k)$ for large $n$, equality iff $H\cong T_r(n,k)$ |
| **Corollary 1.5** | $p\ge r$: the unique $r$-graph of maximum $p$-spectral radius among $n$-vertex $\mathrm{Fan}_r$-free $r$-graphs is $T_r(n,r)$ for large $n$. Here $\mathrm{Fan}_r=F^{(r)}_{r+1}$ consists of $r+1$ edges $e_1,\dots,e_r,e$ with $e_i\cap e_j=\{u\}$ for $i\ne j$, $u\notin e$, and $\lvert e_i\cap e\rvert=1$; $\mathrm{Fan}_2=K_3$ |
| **Corollary 1.6 ([37])** | Mubayi–Pikhurko's edge result, recovered as $p\to\infty$ |

## The tools, quoted

> **Proposition 2.1 (Weyl's inequality, [45, Proposition 6.2]).** Let $H_1$ and $H_2$ be two edge-disjoint $r$-graphs with same vertex set. Then $\lambda^{(p)}(H_1+H_2)\le\lambda^{(p)}(H_1)+\lambda^{(p)}(H_2)$.

> **Lemma 2.1 ([29, Lemma 1.8]).** Let $p>1$ and $H$ be an $r$-graph with $m$ edges. Then $\lambda^{(p)}(H)\le(r!m)^{1-1/p}$.

> **Lemma 2.2 ([27, Theorem 2]).** Let $k\ge r\ge2$, and let $H$ be a $k$-partite $r$-graph of order $n$. Then for each $p>1$, $\lambda^{(p)}(H)<\lambda^{(p)}(T_r(n,k))$, unless $H=T_r(n,k)$.

> **Lemma 2.3.** Let $k\ge r\ge2$. Then $\lambda^{(p)}(T_r(n,k))\ge\big(1-O(n^{-1})\big)\cdot\frac{(k)_r}{k^r}n^{r(1-1/p)}$.

Its proof is one line and worth keeping as a template: take $x=n^{-1/p}(1,1,\dots,1)^T\in S^{n-1}_{p,+}$; then (1.1) and (1.3) give $\lambda^{(p)}(T_r(n,k))\ge r!\,e(T_r(n,k))/n^{r/p}$, which is the claim.

> **Lemma 2.4 ([27, Proposition 11]).** If $H$ is a complete $k$-partite $r$-graph and $p>1$, then every nonnegative vector corresponding to $\lambda^{(p)}(H)$ is positive.

> **Lemma 2.5 ([27, Proposition 12]).** Let $p\ge1$, and let $H$ be an $r$-graph such that every nonnegative vector corresponding to $\lambda^{(p)}(H)$ is positive. If $G$ is a subgraph of $H$, then $\lambda^{(p)}(G)<\lambda^{(p)}(H)$, unless $G=H$.

The proofs of both main theorems run through **spectral stability**: Theorem 3.1 (spectral stability of $H^{(r)}_{k+1}$) and Theorem 3.2 (spectral stability of $F^{(r)}_{k+1}$), for $p>1$ and $k\ge r\ge3$, saying that a near-extremal free $r$-graph is structurally close to $T_r(n,k)$. The stability method is credited to Simonovits [50].

## What it cites

Mantel [35] (1907) and Turán [51] (1941) as the origin; Erdős–Stone–Simonovits [11,12]; Katona–Nemetz–Simonovits [31] for existence of the Turán density; Mubayi [36] and Pikhurko [46] for the exact hypergraph Turán numbers this paper gives spectral analogues of; Mubayi–Pikhurko [37]; Nikiforov [42], [45] and Guiduli [21], Nikiforov [40] for the spectral Turán theorem; Keevash–Lenz–Mubayi [29] and Nikiforov [45] for the $p$-spectral radius; Kang–Nikiforov [26]; Friedman–Wigderson [14] and Cooper–Dutle [8] for the $p=2$ and $p=r$ specialisations; Sidorenko [49] and de Caen [5] for surveys of $\mathrm{ex}(n,K^{(r)}_t)$.

Recorded from the introduction, because it bounds what this literature can supply: **"A central problem, originally posed by Turán [52], is to determine $\pi(K^{(r)}_t)$ … To date, no case with $t>r\ge3$ of this question has been solved, even asymptotically."**

## Incomplete

Theorems 3.1 and 3.2, Lemmas 3.2, 3.4, 3.5, 3.6, Propositions 3.1, 4.1, Corollaries 3.1, 4.1, Lemma 4.1 and all of §§4–5 are not transcribed, they are the stability proofs. Lemma 2.6 ([6, Lemma 12]) is named but its statement runs past the extraction's page break and is not recorded here.
