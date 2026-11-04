# Li, *Manifolds with nonnegative curvature operator of the second kind* (arXiv:2112.08465)

Transcribed 2026-09-02 from [li-2112.08465.txt](https://arxiv.org/abs/2112.08465) (`pdftotext -layout`). See [README.md](README.md) for the verdict.

## The definition this project uses, §2, equation (2.2)

> The second one, denoted by $\mathring R:S^2(V)\to S^2(V)$, is defined by
> $$\mathring R(e_i\odot e_j)=\sum_{k,l}R_{iklj}\,e_k\odot e_l.\tag{2.2}$$

**The index order is $iklj$.** This is the convention the record's implementation follows, cross-checked independently against Bourguignon–Karcher in [bourguignon-karcher-1978-pinching](../bourguignon-karcher-1978-pinching/README.md).

## Why the restriction to $S^2_0$ is forced, and the trace identities

> However, on contrary to the case of $\hat R$, all eigenvalues of $\mathring R$ being nonnegative implies all the sectional curvatures of $R$ are zero, that is, $R\equiv0$. The new feature here is that $S^2(V)$ is not irreducible under the action of the orthogonal group $O(V)$ of $V$. The space $S^2(V)$ splits into $O(V)$-irreducible subspaces as
> $$S^2(V)=S^2_0(V)\oplus\mathbb Rg,$$
> where $S^2_0(V)$ denotes the space of traceless symmetric two-tensors on $V$. The map $\mathring R$ defined in (2.2) then induces a symmetric bilinear form
> $$\mathring R:S^2_0(V)\times S^2_0(V)\to\mathbb R\tag{2.3}$$
> by restriction to $S^2_0(V)$. Note that if all the eigenvalues of $\mathring R$ restricted to $S^2_0(V)$ are bounded from below by $\kappa\in\mathbb R$, then the sectional curvatures of $R$ are bounded from below by $\kappa$. **It should be noted that $\mathring R$ does not preserve the subspace $S^2_0(V)$ in general, but it does, for instance, when $R$ is Einstein.**

Footnote 5 gives the reason the full operator cannot be used: $\mathop{\mathrm{tr}}\big(\mathring R:S^2(V)\to S^2(V)\big)=\tfrac S2$ and $\mathring R(g,g)=-S$.

**The parenthetical matters for this project.** $\mathrm{Weyl}_n$ is Ricci-flat, hence Einstein, so $\mathring W$ does preserve $S^2_0(V)$ and the bilinear form and the self-adjoint operator $\pi\circ\mathring R$ agree, Remark 2.1 states that equivalence:

> $\mathring R(\varphi,\psi)=\langle\mathring R(\varphi),\psi\rangle=\langle\pi\circ\mathring R(\varphi),\psi\rangle=(\pi\circ\mathring R)(\varphi,\psi)$ for any $\varphi,\psi\in S^2_0(V)$.

Dimension: $N=\dim S^2_0(V)=\tfrac{(n-1)(n+2)}{2}$.

## Definitions 2.2 and 2.3, the $k$-nonnegativity cones

> **Definition 2.2.** For a positive integer $1\le k\le N$, we say $R\in S^2_B(\Lambda^2(V))$ has **$k$-nonnegative** (respectively, **$k$-positive**) curvature operator of the second kind if the sum of the smallest $k$ eigenvalues of $\mathring R$ is nonnegative (respectively, positive).

> **Definition 2.3.** A Riemannian manifold $(M^n,g)$ is said to have $k$-nonnegative (respectively, $k$-positive) curvature operator of the second kind if $R_p\in S^2_B(\Lambda^2T_pM)$ has $k$-nonnegative (respectively, $k$-positive) curvature operator of the second kind for each $p\in M$.

## The main theorems, with full hypotheses

> **Theorem 1.5.** Let $(M^3,g)$ be a closed Riemannian manifold of dimension three. (1) If $M$ has three-positive curvature operator of the second kind, then $M$ is diffeomorphic to a spherical space form. (2) If $M$ has three-nonnegative curvature operator of the second kind, then $M$ is either flat or diffeomorphic to a spherical space form.

> **Theorem 1.6.** A closed Riemannian manifold with three-positive curvature operator of the second kind is diffeomorphic to a spherical space form.

> **Theorem 1.7.** Let $(M^n,g)$ be a closed Riemannian manifold of dimension $n\ge4$. If $M$ has three-nonnegative curvature operator of the second kind, then one of the following statements holds: (1) $(M,g)$ is flat; (2) $M$ is diffeomorphic to a spherical space form; (3) $n\ge5$ and the universal cover of $M$ is isometric to a compact irreducible symmetric space.

*Li's footnote 2 records that possibility (3) was subsequently ruled out by [nienhaus-petersen-wink-2022-betti-second-kind](../nienhaus-petersen-wink-2022-betti-second-kind/README.md), who proved a closed $n$-manifold with $\tfrac{n+2}{2}$-nonnegative curvature operator of the second kind is either a rational homology sphere or flat.*

> **Theorem 1.8.** Let $(M^n,g)$ be an $n$-dimensional non-flat complete Riemannian manifold with $n$-nonnegative curvature operator of the second kind. Then $M$ is locally irreducible.

Li draws the consequence explicitly: $M_1\times M_2$ has $n$-nonnegative $\mathring R$ **if and only if both factors are flat**. The hypothesis cannot be weakened to $(n+1)$-nonnegative, since $S^{n-1}\times S^1$ is a reducible counterexample.

> **Theorem 1.9.** A Kähler manifold with four-nonnegative curvature operator of the second kind is flat.

Sharp: $\mathbb{CP}^2$ has five-positive curvature operator of the second kind.

## The known spectra, §2 Examples, which are the record's competitor list

| example | spectrum of $\mathring R$ on $S^2_0$ |
|---|---|
| **2.4** $(S^n,g_0)$, constant curvature 1 | $\mathring R=\mathrm{Id}$; all eigenvalues $1$. Derived from $R_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}$, giving $\mathring R(\varphi,\varphi)=\lvert\varphi\rvert^2-\mathop{\mathrm{tr}}(\varphi)^2=\lvert\varphi\rvert^2$ |
| **2.5** $(\mathbb{CP}^m,g_{FS})$ | two eigenvalues: $-2$ with multiplicity $(m-1)(m+1)$, and $4$ with multiplicity $m(m+1)$. Attributed to [BK78] |
| **2.6** $S^{n-1}\times\mathbb R$, sphere factor of curvature 1 | $\lambda_1=-\tfrac{n-2}{n}$ (mult. 1, eigenvector $\sum_{i=1}^{n-1}e_i\odot e_i-(n-1)e_n\odot e_n$); $\lambda_2=0$ (mult. $n-1$, spanned by $u\odot v$, $u$ tangent to the sphere, $v$ to $\mathbb R$); $\lambda_3=1$ (mult. $\tfrac{(n-2)(n+1)}{2}$, the traceless symmetric two-tensors on the $S^{n-1}$ factor) |
| **2.7** $S^2\times S^2$, both factors curvature 1 | $\lambda_1=-1$ (mult. 1), $\lambda_2=0$ (mult. 4), $\lambda_3=1$ (mult. 4), attributed to [CGT21]. Eigenspaces given explicitly: $E_1=\mathrm{span}\{e_1\odot e_1+e_2\odot e_2-e_3\odot e_3-e_4\odot e_4\}$, $E_2=\mathrm{span}\{e_1\odot e_3,e_1\odot e_4,e_2\odot e_3,e_2\odot e_4\}$, $E_3=\mathrm{span}\{e_1\odot e_2,e_3\odot e_4,e_1\odot e_1-e_2\odot e_2,e_3\odot e_3-e_4\odot e_4\}$ |

## Lemma 3.1, the frame dictionary in dimension three

With $\varphi_1=\tfrac1{\sqrt2}e_1\odot e_2$, $\varphi_2=\tfrac1{\sqrt2}e_1\odot e_3$, $\varphi_3=\tfrac1{\sqrt2}e_2\odot e_3$, $\varphi_4=\tfrac1{2\sqrt2}(e_1\odot e_1-e_2\odot e_2)$, $\varphi_5=\tfrac1{2\sqrt6}(e_1\odot e_1+e_2\odot e_2-2e_3\odot e_3)$, Lemma 3.1 lists $\mathring R(\varphi_1,\varphi_1)=R_{1212}$, $\mathring R(\varphi_2,\varphi_2)=R_{1313}$, and so on, **diagonal entries of $\mathring R$ in this basis are sectional curvatures**, the $n=3$ case of Proposition 3.10 of [nienhaus-petersen-wink-2022-betti-second-kind](../nienhaus-petersen-wink-2022-betti-second-kind/README.md).

## What it cites

Nishikawa's conjecture [Nis86] is the ambient problem; Cao–Gursky–Tran [CGT21] supply the two-positive result Li strengthens; Brendle [Bre08] converts strictly PIC1 to a space form; Hamilton [Ham86] handles dimension three; Bourguignon–Karcher [BK78] supply the $\mathbb{CP}^m$ spectrum.

## Incomplete

The proofs in §§3–6 (Propositions 3.1, 4.1, 4.2, Lemmas 4.1, 4.2, Proposition 5.1, Theorem 6.1) are not transcribed. They are Bochner- and flow-side arguments consuming compactness, and the record's problem is pointwise-algebraic, so none of them was read for content.
