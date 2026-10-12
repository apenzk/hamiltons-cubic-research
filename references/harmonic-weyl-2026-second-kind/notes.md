# Fu & Lu, *Manifolds with harmonic Weyl curvature and curvature operator of the second kind* (arXiv:2602.07313)

**Haiping Fu and Yao Lu**, arXiv:2602.07313v1 [math.DG], 7 Feb 2026. Transcribed 2026-09-02 from [paper.txt](https://arxiv.org/pdf/2602.07313) (`pdftotext -layout`). See [README.md](README.md) for the verdict: the machinery is Bochner-technique and consumes $\nabla$ and compactness, neither of which exists in the record's algebraic problem.

## The two cubic Weyl contractions the paper names

These are the only pointwise-algebraic objects here, and they are the reason the folder is worth keeping. Written in the paper's own index conventions:

$$\alpha(W)=W_{ijkl}W_{ijst}R_{klst},\qquad \beta(W)=R_{sikt}W_{sjkl}W_{ijtl}.$$

The paper derives, using the first Bianchi identity, the relation

> $\alpha(W)=W_{ijkl}W_{ijst}R_{klst}=(W_{ilkj}+W_{ikjl})(W_{itsj}+W_{isjt})R_{klst}=4W_{iklj}W_{istj}R_{klst}$

and

> $W_{iklj}W_{istj}R_{ktsl}=W_{iklj}W_{istj}(R_{klst}+R_{kstl})=W_{iklj}W_{istj}R_{klst}-\beta(W)$.

## Lemma 3.1, the harmonic-Weyl Bochner identity

> **Lemma 3.1.** Let $M$ be an $n(\ge4)$-dimensional complete Riemannian manifold with harmonic Weyl curvature. Then
> $$\langle\Delta W,W\rangle=2R_{lt}W_{ijkl}W_{ijkt}-\alpha(W)-4\beta(W).\tag{3.1}$$

Proof, as given: harmonicity plus the second Bianchi identity gives $W_{ijkl,h}+W_{ijlh,k}+W_{ijhk,l}=0$; the Ricci identity then yields
$\langle\Delta W,W\rangle=W_{ijkl,ss}W_{ijkl}=2W_{ijkl}(W_{ijks,sl}+R_{lsti}W_{tjks}+R_{lstj}W_{itks}+R_{lstk}W_{ijts}+R_{lsts}W_{ijkt})=4R_{lsti}W_{ijkl}W_{tjks}+2R_{lstk}W_{ijkl}W_{ijts}+2R_{lt}W_{ijkl}W_{ijkt}$, which is (3.1).

*Remark 3.2 records that a similar formula appears in [13] in a different form.*

## The bridge to $\mathring R$, equation (3.2)

Setting $S_{ij}=\tfrac12\sum_{k,l}(W_{iklj}+W_{ilkj})e_k\odot e_l$, which is trace-free because the Weyl tensor is trace-free, the paper computes

> $$\sum_{i,j}\langle\mathring R(S_{ij}),S_{ij}\rangle=2W_{iklj}W_{istj}R_{kstl}+2W_{iklj}W_{istj}R_{ktsl}=\tfrac12\alpha(W)-4\beta(W).\tag{3.2}$$

**This is the statement that turns a cubic Weyl contraction into a quadratic form in $\mathring R$**, and it is the part of the paper closest to what the record wants.

> **Proposition 3.3 ([8]).** Let $T$ and $\mathring R$ denote a smooth algebraic curvature tensor and a curvature operator of the second kind on a Riemannian manifold $(M,g)$ of dimension $n\ge3$, respectively. Then
> $$\langle\mathring R(T^{S^2_0}),T^{S^2_0}\rangle=\frac{2n+32}{n}R_{st}T_{sjkl}T_{tjkl}-5\alpha(T)+4\beta(T)-\frac{16}{n^2}s\lvert T\rvert^2.$$

*Attributed to reference [8], this project has not read [8] and must not cite it as read.*

> **Proposition 3.4.** Let $M$ be an $n(\ge4)$-dimensional complete Riemannian manifold with harmonic Weyl curvature. Then
> $$3\langle\Delta W,W\rangle=\big\langle\mathring R(W^{S^2_0}),W^{S^2_0}\big\rangle+\frac{4(n-8)}{n}R_{lt}W_{ijkl}W_{ijkt}+4\sum_{i,j}\langle\mathring R(S_{ij}),S_{ij}\rangle+\frac{16}{n^2}s\lvert W\rvert^2.$$

Obtained by combining Proposition 3.3 with (3.1) and (3.2).

## Proposition 4.1, a purely algebraic statement, with a complete proof

> **Proposition 4.1.** Let $R$ be an algebraic curvature tensor on a Euclidean vector space $V$ of dimension $n\ge3$. If $R$ has $\tfrac{(n-1)(n-2)}{2}$-nonnegative curvature operator of the second kind, then the Ricci curvature of $R$ satisfies $\mathrm{Ric}\le\tfrac s2$.

Proof, verbatim in substance: let $\{e_1,\dots,e_n\}$ be an orthonormal basis and set $\psi_{kl}=\tfrac1{\sqrt2}e_k\odot e_l$ for $2\le k<l\le n$; these are an orthonormal subset of $S^2_0(V)$ of cardinality $\tfrac{(n-1)(n-2)}{2}$, so the hypothesis gives
$$0\le\sum_{2\le k<l\le n}\langle\mathring R(\psi_{kl}),\psi_{kl}\rangle=\sum_{2\le k<l\le n}R_{klkl}=\frac s2-R_{11},$$
which is the claim. *Remark 4.2 attributes the argument to the proof of [20, Theorem 1.6].*

**This is the one statement in the paper that applies to an algebraic curvature tensor with no manifold behind it.** On $\mathrm{Weyl}_n$ it is vacuous ($s=0$ and $\mathrm{Ric}=0$) so it constrains nothing here, recorded so a later cycle does not try it.

## The main theorems, with full hypotheses

> **Theorem A.** Let $(M,g)$ be an $n(\ge8)$-dimensional compact Riemannian manifold with harmonic Weyl curvature tensor. If the curvature operator of the second kind $\mathring R$ is $\tfrac{3(n-1)(n+2)}{4(3n-1)}$-nonnegative, then $M$ is either globally conformally equivalent to a space of positive constant curvature or is isometric to a flat manifold.

> **Corollary 1.1.** Let $(M,g)$ be an $n(\ge8)$ (resp. $11$)-dimensional compact Riemannian manifold with harmonic Weyl curvature tensor. If $\mathring R$ is $2$ (resp. $3$)-nonnegative, then $M$ is either globally conformally equivalent to a space of positive constant curvature or is isometric to a flat manifold.

> **Theorem B.** Let $(M,g)$ be an $n(=5,7)$-dimensional compact Riemannian manifold with harmonic Weyl curvature tensor, $\mathring R$ the curvature operator of the second kind. If (i) $n=5$ and $\mathring R$ is $\tfrac{252}{169}$-nonnegative; (ii) $n=7$ and $\mathring R$ is $\tfrac{54}{35}$-nonnegative, then $M$ is either globally conformally equivalent to a space of positive constant curvature or is isometric to a flat manifold.

> **Remark 1.2.** Theorem A and B generalize the result of Dai, Fu and Yang [9] … **Our method does not apply to the case $n=6$.** Whether Dai–Fu–Yang's result can be improved to achieve optimality remains an interesting and open problem.

> **Theorem C.** Let $(M,g)$ be a 4-dimensional compact manifold with harmonic Weyl curvature whose curvature operator of the second kind $\mathring R$ satisfies
> $$\lambda_1+\lambda_2+\lambda_3\ge-3\bar\lambda,\tag{1.1}$$
> where $\bar\lambda$ represents the average value of all the eigenvalues of $\mathring R$. Then one of the following must be true: (1) $M$ is conformally flat. (2) up to rescaling, $M$ is $\mathbb{CP}^2$ with the Fubini–Study metric. (3) up to rescaling, $M$ is isometric to a quotient of $\Sigma_1^2\times\Sigma_2^2$ with the product metric, where $k_i$ ($i=1,2$) is the constant Gaussian curvature of $\Sigma^2_i$ and $2s=k_1+k_2>0$.

**Theorem C's trichotomy is exactly the record's competitor list at $n=4$**, conformally flat, $\mathbb{CP}^2$, and a product of surfaces.

## Prior work the introduction places it against

Tachibana [30]: compact $n\ge3$ with harmonic curvature and positive (resp. nonnegative) curvature operator is a quotient of the standard sphere (resp. locally symmetric). Tran [31]: $n\ge4$, harmonic Weyl plus positive curvature operator gives locally conformally flat. Petersen–Wink [29]: harmonic Weyl plus $\lceil\tfrac{n-1}2\rceil$-nonnegative curvature operator gives globally conformally equivalent to a quotient of the standard sphere, or locally symmetric. Colombo–Mariani–Rigoli [7] and Bettiol–Goodman [2] refine the constant to $\tfrac{n-1}2$-positive for $n\ge5$ and $\tfrac n2$-positive for $n=3,4$. Nishikawa's 1986 conjecture [25] is the ambient problem.

## Incomplete

Definitions 2.1, 2.2, Lemmas 2.3, 2.4 (the weighted-sum apparatus, which the paper takes from reference [26], the same $[\mathring R,\Omega,S]$ bracket transcribed at [nienhaus-petersen-wink-2022-betti-second-kind/notes.md](../nienhaus-petersen-wink-2022-betti-second-kind/notes.md)), Proposition 3.5, Corollary 5.1 and Theorem 5.3 are not transcribed. Reference [8], the source of Proposition 3.3, has not been obtained.
