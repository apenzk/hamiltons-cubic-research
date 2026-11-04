# Cheng & Wang, *Einstein manifolds of negative lower bounds on curvature operator of the second kind* (arXiv:2411.13912)

**Haiqing Cheng and Kui Wang**, arXiv:2411.13912v2 [math.DG], 12 Dec 2025. Transcribed 2026-09-02 from [paper.txt](https://arxiv.org/abs/2411.13912) (`pdftotext -layout`). See [README.md](README.md) for the verdict.

Conventions, from §2.2 and §3: $\mathring R=\pi\circ\bar R:S^2_0(T_pM)\to S^2_0(T_pM)$ with $\pi$ the projection from symmetric two-tensors to traceless ones (2.1); $N=(n-1)(n+2)/2$; $\lambda_1\le\lambda_2\le\cdots\le\lambda_N$ the eigenvalues of $\mathring R$; $\bar\lambda=\sum_j\lambda_j/N$ their average. The paper cites [Nienhaus–Petersen–Wink](../nienhaus-petersen-wink-2022-betti-second-kind/notes.md) for the $\pi\circ\bar R$ reading and works in the same index order as [Li 2021](../li-2021-nonnegative-second-kind/notes.md).

## The main theorem, with its hypothesis

> **Theorem 1.2.** Let $(M^n,g)$ be a closed Einstein manifold of dimension $n\ge4$. If
> $$\lambda_1\ge-\theta(n)\bar\lambda,\tag{1.1}$$
> then $M$ is either flat or a round sphere. Here $\theta(n)$ is a positive constant given by
> $$\theta(n)=\begin{cases}17/7,&n=4,\\ 47/18,&n=5,\\ \dfrac{2(n^4-4n^3-5n^2+30n-16)}{n^4+8n^3-5n^2-48n+32},&n\ge6.\end{cases}\tag{1.2}$$

> **Remark 1.1.** Theorem 1.2 essentially represents a gap theorem for Einstein manifolds, in the sense that if the curvature operator of the second kind satisfies (1.1), then the curvature operator of the second kind is nonnegative.

The introduction places (1.1) as **Li's condition with $\alpha=1$**, from [Li 2024 Definition 1.2](../li-2024-sphere-theorems-second-kind/notes.md): "we focus on Li's condition with $\alpha=1$, namely (1.1), which is weaker than nonnegative curvature operator of the second kind." Remark 1.1 continues: "The crucial step in proving Theorem 1.2 is solving an extremum problem introduced in Proposition 3.4. Upon examination of the proof, it becomes evident that for any $\theta$, strictly greater than $\theta(n)$, Proposition 3.4 does not hold. Consequently, by employing our method, $\theta(n)$ as provided in equation (1.2) is deemed optimal. But it remains an interesting question that whether $\theta(n)$ is sharp or not for Theorem 1.2."

## Proposition 2.1, the identity that decides the record's question

> **Proposition 2.1.** Suppose $(M^n,g)$ is an Einstein manifold of dimension $n$. Then the scalar curvature satisfies
> $$\mathrm{Scal}=n(n-1)\bar\lambda.\tag{2.2}$$

Proof, as given: with $\{e_i\}$ orthonormal, $\{\tfrac1{\sqrt2}e_i\odot e_j\}_{i<j}\cup\{\tfrac12e_i\odot e_i\}$ is an orthonormal basis of $S^2(T_pM)$ and $\langle\bar R(\tfrac1{\sqrt2}e_i\odot e_j),\tfrac1{\sqrt2}e_i\odot e_j\rangle=R_{ijij}$, so $\mathop{\mathrm{tr}}(\bar R)=\sum_{i<j}R_{ijij}=\mathrm{Scal}/2$. Subtracting the $g/\sqrt n$ direction, $\mathop{\mathrm{tr}}(\mathring R)=\mathop{\mathrm{tr}}(\bar R)-\langle\bar R(g/\sqrt n),g/\sqrt n\rangle=\tfrac{\mathrm{Scal}}2+\tfrac{\mathrm{Scal}}n=\tfrac{n+2}{2n}\mathrm{Scal}$, and $\mathop{\mathrm{tr}}(\mathring R)=N\bar\lambda$ gives (2.2).

**This is the load-bearing line for the record.** $\mathrm{Weyl}_n$ is Ricci-flat, hence scalar-flat, hence $\bar\lambda=0$ identically, so every second-kind condition normalised against $\bar\lambda$, this paper's (1.1) and Li's whole $C(\alpha,\theta)$ family alike, collapses on the record's class to the single condition $\lambda_1\ge0$. The authors state the consequence themselves inside the proof of Proposition 3.4:

> By the curvature condition (1.2), we have $\bar\lambda\ge0$. **If $\bar\lambda=0$, then $\lambda_1=\lambda_2=\cdots=\lambda_N=0$**, and (3.6) holds trivially by (3.5). Thus, we focus on the case $\bar\lambda>0$.

The agreement with [Dai–Fu Lemma 3.3](../dai-fu-2023-einstein-second-kind/notes.md), $\mathop{\mathrm{tr}}\mathring R=\tfrac{n+2}{2n}s$, is exact.

## Lemma 3.1, the closed forms on Einstein

> **Lemma 3.1.** Let $(M^n,g)$ be an $n$-dimensional Einstein manifold. Then
> $$|R|^2=|W|^2+2n(n-1)\bar\lambda^2,\tag{3.1}$$
> and
> $$\sum_{j=1}^N\lambda_j^2=\tfrac34|R|^2-(n-1)^2\bar\lambda^2.\tag{3.2}$$

On $\mathrm{Weyl}_n$ both reduce to $\sum_j\lambda_j^2=\tfrac34|W|^2$, which is the record's norm identity $\lVert\mathring W\rVert_F^2=3\lVert W\rVert^2_{\Lambda^2}$ in the other normalisation ([conventions.md](../../findings/conventions.md)). Paired with $\sum_j\lambda_j=0$ it yields $\lambda_1\ge-\sqrt{\tfrac{N-1}N\cdot\tfrac34|W|^2}$ by elementary linear algebra, the only lower bound on $\lambda_1$ that any of this paper's content produces on a Ricci-flat algebraic curvature tensor, and weaker than the record's own proved cap in [post F26](../../findings/bispectral.md).

## Lemma 3.2 and Proposition 3.4, the transfer, and where the hypothesis is spent

> **Lemma 3.2.** Let $(M^n,g)$ be an Einstein manifold of dimension $n$. Suppose the smallest eigenvalue of $\mathring R$ satisfies $\lambda_1\ge-\theta\bar\lambda$, then
> $$\sum_{j=1}^N\lambda_j|S^jW|^2\ \ge\ -\frac{8(n^2+n-8)}{3n}\theta\bar\lambda\sum_{j=1}^N\lambda_j^2+\frac{4(n^2+n-8)(n-1)(n+2)}{3n}\theta\bar\lambda^3.\tag{3.3}$$

The proof is three lines and the hypothesis is spent in one of them. The paper first records $\sum_{j=1}^N|S^jW|^2=\tfrac{2(n^2+n-8)}n|W|^2$, then writes

> and by assumption $\lambda_1\ge-\theta\bar\lambda$, we estimate that
> $$\sum_{j=1}^N\lambda_j|S^jW|^2\ge-\theta\bar\lambda\sum_{j=1}^N|S^jW|^2=-\theta\bar\lambda\,\frac{2(n^2+n-8)}n|W|^2,\tag{3.4}$$

and finishes by substituting $|W|^2=\tfrac43\sum_j\lambda_j^2-\tfrac23(n-1)(n+2)\bar\lambda^2$, which (3.1) and (3.2) give. It is a bottom-eigenvalue-to-cubic transfer of the same shape as [Cheng–Wang 2508.11226 Lemma 3.2](../cone-conditions-2025-second-kind/notes.md), with one eigenvalue split off instead of two. **At $\bar\lambda=0$ the right-hand side of (3.4) is $0$**, so the estimate carries no information on a Ricci-flat tensor.

> **Proposition 3.4.** Let $(M^n,g)$ be an $n$-dimensional Einstein manifold. Suppose the curvature operator of the second kind satisfies (1.1). Then
> $$\langle\Delta R,R\rangle\ge0,\tag{3.6}$$
> with the equality holding if and only if $\lambda=(1,1,\dots,1)\bar\lambda$ or $\lambda=(-\theta,\tfrac{N+\theta}{N-1},\dots,\tfrac{N+\theta}{N-1})\bar\lambda$.

## The proof of Theorem 1.2, quoted for its machinery

> Using (3.6), we have $\Delta|R|^2=2|\nabla R|^2+2\langle\Delta R,R\rangle\ge2|\nabla R|^2$, and integrating the above inequality over $M$ yields $0=\int_M\Delta|R|^2\,d\mu_g\ge\int_M2|\nabla R|^2\,d\mu_g\ge0$, which implies $|\nabla R|=0$. Therefore $M$ is a symmetric space.

Rigidity then runs through Nienhaus–Petersen–Wink Theorem B, Li's Theorem 1.8(2), Poincaré duality and Wolf's classification of compact symmetric spaces that are real cohomology spheres. **The machinery is $\nabla$, compactness and integration**, none of which exists in the record's pointwise-algebraic problem.

## Incomplete

The extremum problem solved inside Proposition 3.4 for $n\ge6$ (the functions $C(n,t)$ and $F(x)$), the $n=4$ and $n=5$ cases at lines 602–606, and Definition 2.2's $S^jW$ derivation action are named but not transcribed. They are the optimisation over a spectrum constrained by $\sum\lambda_j=N\bar\lambda$ and $\lambda_j\ge-\theta\bar\lambda$, which is vacuous at $\bar\lambda=0$.
