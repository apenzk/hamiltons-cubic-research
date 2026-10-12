# Chen, Xu & Ye, *Turán problems for multilinear maps* (arXiv:2603.00715)

**Qiyuan Chen, Zixiang Xu, Ke Ye**, arXiv:2603.00715v2 [math.CO], 23 Jul 2026. Transcribed 2026-09-02 from [paper.txt](https://arxiv.org/abs/2603.00715) (`pdftotext -layout`). See [README.md](README.md) for the verdict: **the right field, and it does not contain the record's statement**, these compute a minimum over all forms, Lemma 36 is a maximum for one distinguished form.

## The quantity, and why it is not the record's

Definitions, verbatim from §1: $\mathrm{Alt}_d(\mathbb F^n,\mathbb F^m)$ is the space of order-$d$ alternating multilinear maps $(\mathbb F^n)^d\to\mathbb F^m$; $\mathrm{Gr}(k,\mathbb F^n)$ is the Grassmannian; given $T\in\mathrm{Alt}_d(\mathbb F^n,\mathbb F^m)$, a subspace $V\in\mathrm{Gr}(k,\mathbb F^n)$ is **isotropic** if $T|_V=0$, that is $T(v_1,\dots,v_d)=0$ for all $v_1,\dots,v_d\in V$.

> **Problem 1.1 (Turán problem for $\mathrm{Alt}_d(\mathbb F^n,\mathbb F^m)$).** Given a field $\mathbb F$ and positive integers $n,d,m$, find the largest number $k:=\alpha_\Lambda(\mathbb F,n,d,m)$ such that **every** $T\in\mathrm{Alt}_d(\mathbb F^n,\mathbb F^m)$ has a $k$-dimensional isotropic subspace.

The two indices, and the minimisation that separates them from Lemma 36:

$$\alpha(T):=\max\{s\in\mathbb N_0:T|_{V_1\times\cdots\times V_d}=0\ \text{for some}\ (V_1,\dots,V_d)\in\mathrm{Gr}(s,\mathbb F^n)^d\},$$
$$\alpha_\Lambda(S):=\max\{s\in\mathbb N_0:S|_V=0\ \text{for some}\ V\in\mathrm{Gr}(s,\mathbb F^n)\},$$

and then **$\alpha(\mathbb F,n,d,m)=\min_T\alpha(T)$ and $\alpha_\Lambda(\mathbb F,n,d,m)=\min_S\alpha_\Lambda(S)$**, $T$ and $S$ ranging over $\mathrm{Hom}_d$ and $\mathrm{Alt}_d$ respectively. Also recorded from [12, Remark 3.7]: **$\alpha_\Lambda$ is additive under direct sums, while $\alpha$ is only superadditive.**

**That $\min$ is the whole distance to the record's Lemma 36**, which asks for $\alpha_\Lambda(S)$ at the single Cartan 3-form.

## The bilinear ancestor, quoted

> By the main theorem of [7],
> $$\alpha_\Lambda(\mathbb F,n,2,m)=\Big\lfloor\frac{2n+m}{m+2}\Big\rfloor\tag{1}$$
> holds for $m\ge2$ and algebraically closed fields $\mathbb F$ with $\mathrm{char}(\mathbb F)\ne2$.

For $d=2$, Problem 1.1 was first studied by Ol'šanskiĭ [39] over finite fields, later by Buhler, Gupta and Harris [7] for arbitrary fields.

## The main results, with full hypotheses

> **Theorem 1.2.** Let $\mathbb F$ be an algebraically closed field and $n,d,m$ be positive integers.
> (a) If $m\ge2$, then $\alpha_\Lambda(\mathbb F,n,d,m)=\max\{s\in\mathbb N_0:s(n-s)\ge m\binom sd\}$.
> (b) If $m=1$, then
> $$\alpha_\Lambda(\mathbb F,n,d,1)=\begin{cases}\lceil\tfrac n2\rceil&\text{if }d=2,\\ 4&\text{if }(d,n)=(3,7),\\ n-2&\text{if }d=n-2\text{ is even},\\ \max\{s\in\mathbb N_0:s(n-s)\ge\binom sd\}&\text{otherwise.}\end{cases}$$

The authors record the provenance and the limits of their own argument:

> Our proof of Theorem 1.2(b) relies on a result of **Tevelev [46]** concerning the isotropy index of a generic element in $\mathrm{Alt}_d(\mathbb F^n,\mathbb F)$ when $\mathrm{char}(\mathbb F)=0$. … It is worth emphasizing that Tevelev's proof uses the **Borel–Weil–Bott theorem** to establish a necessary condition for a generic section of a line bundle to vanish. However, this argument does not extend directly to the positive-characteristic case. Furthermore, our proof of Theorem 1.2(b) does not extend to $\mathrm{Alt}_d(\mathbb F^n,\mathbb F^m)$ with $m\ge2$, since in that setting one must study the common zero locus of several global sections of a line bundle rather than the zero locus of a single section.

*The **generic**-element hypothesis in Tevelev is the second reason this cannot settle Lemma 36: the Cartan 3-form is distinguished, not generic.*

> **Problem 1.3 (Turán problem for $\mathrm{Hom}_d(\mathbb F^n,\mathbb F^m)$).** Given a field $\mathbb F$ and $n,d,m\in\mathbb N$, find the largest number $k:=\alpha(\mathbb F,n,d,m)$ such that for each $T\in\mathrm{Hom}_d(\mathbb F^n,\mathbb F^m)$, there exists $(V_1,\dots,V_d)\in\mathrm{Gr}(k,\mathbb F^n)^d$ such that $T|_{V_1\times\cdots\times V_d}=0$.

> **Theorem 1.4.** Let $\mathbb F$ be an algebraically closed field. Given $n,d,m\in\mathbb N$:
> (a) If $m\ge2$, then $\alpha(\mathbb F,n,d,m)=\max\{s\in\mathbb N_0:ds(n-s)\ge ms^d\}$.
> (b) If $m=1$, then $\alpha(\mathbb F,n,d,1)=n-1$ if $d=1$; $\lfloor\tfrac n2\rfloor$ if $d=2$; and $\max\{s\in\mathbb N_0:ds(n-s)\ge s^d\}$ otherwise.

> **Corollary 1.6.** Let $\mathbb F$ be an algebraically closed field. For any positive integers $n,k$ and $d\ge2$ such that $2\le d\le n$ and $d-1\le k\le n$, we have
> $$T(\mathbb F,n,d,k)=\max\Big\{0,\Big\lceil\frac{(k+1)(n-k-1)}{\binom{k+1}{d}}\Big\rceil\Big\}+1$$
> with three exceptional cases: $d=2$ and $\lceil n/2\rceil\le k$; $(d,n)=(3,7)$ and $4\le k$; $d=n-2$, $n$ even and $n-2\le k$, in which $T(\mathbb F,n,d,k)=1$. In particular, for any algebraically closed field $\mathbb F$ and positive integers $n,d$, it holds that $\mathrm{GQ}(\mathbb F,n,d)=\max\{0,d(n-d)\}+1$.

The Gow–Quinlan number is defined as $\mathrm{GQ}(\mathbb F,n,d)=T(\mathbb F,n,d,d-1):=\min\{r\in\mathbb N:\alpha_\Lambda(\mathbb F,n,d,r)=d-1\}$, using $n\ge\alpha_\Lambda(\mathbb F,n,d,r)\ge\min\{d-1,n\}$; Gow and Quinlan [23] observed $\mathrm{GQ}(\mathbb F,n,2)=2n-3$ over algebraically closed fields of characteristic $\ne2$.

## The lineage, from the paper's own abstract

> This extends the bilinear formula of **Buhler, Gupta, and Harris** [J. Algebra, 1987] to arbitrary order and resolves a question of **Qiao** [Discrete Anal., 2023]. … These results yield exact values, over algebraically closed fields, of the **Feldman–Propp number** [Adv. Math., 1992], the **Turán number** [Discrete Anal., 2023], and the **Gow–Quinlan number** [Linear Multilinear Algebra, 2006] associated with alternating multilinear maps.

The last section derives the Conlon–Pohoata–Zakharov [14] lower bound $\mathrm{ex}_d(N,K^{(d)}_{2,\dots,2})=\Omega(N^{d-\frac mn})$ (3) for the Erdős box problem [20] purely algebraically, and shows the multilinear method cannot improve its exponent.

## Incomplete

Corollaries 1.5 and 1.7, Theorems 3.6 and 3.9 (the separate proofs of Theorem 1.2(a) and (b)), and all of §§2–5 are not transcribed. The intersection-theoretic machinery in $A^*(\mathrm{Gr}(k,\mathbb F^n))$ computes a minimum over the whole space of forms, which is the quantity the record does not want.
