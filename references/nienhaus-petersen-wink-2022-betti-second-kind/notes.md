# Nienhaus, Petersen & Wink, *Betti numbers and the curvature operator of the second kind* (arXiv:2206.14218)

Transcribed 2026-09-02 from [npw-2206.14218.txt](https://arxiv.org/abs/2206.14218) (`pdftotext -layout`). See [README.md](README.md) for the verdict.

## What this project takes from it, Proposition 3.10, the frame dictionary

> **Proposition 3.10.** The trace-free, symmetric $(0,2)$-tensors
> $$\phi_{ij}=\tfrac1{\sqrt2}\big(e^i\otimes e^j+e^j\otimes e^i\big),\quad 1\le i<j\le n,$$
> $$\psi_k=\frac1{\sqrt{(n-k+1)(n-k)}}\Big(-(n-k)\,e^k\otimes e^k+\sum_{l=k+1}^ne^l\otimes e^l\Big),\quad k=1,\dots,n-1,$$

**The coefficient is $-(n-k)$, and the paper prints $-k$.** As printed the tensor is trace-free only at $k=n/2$, its trace being $n-2k$; with $-(n-k)$ the trace vanishes for every $k$. **The printed normaliser settles it**: $(n-k)^2+(n-k)=(n-k)(n-k+1)$ is exactly the radicand shown, which the $-k$ form does not produce. Orthogonality across $k$ agrees. *Nothing in this record uses the explicit form (only the block structure) so the correction changes no downstream claim.*
> form an orthonormal basis for $S^2_0(V)$. Moreover, $g(\mathcal R(\phi_{ij}),\phi_{ij})=R_{ijij}$ and in particular
> $$\sum_{\substack{j=1\\ j\ne i}}^n g(\mathcal R(\phi_{ij}),\phi_{ij})=R_{ii},$$
> $$\sum_{k=1}^p g(\mathcal R(\psi_k),\psi_k)=\frac{2}{n-p}\Big(\sum_{k=1}^pR_{kk}-\sum_{1\le k<l\le p}R_{klkl}\Big)-\frac{p}{(n-p)n}\,\mathrm{scal}.$$
>
> *Proof.* This is a straightforward computation.

**This is the statement the record relies on**: in the $\{\phi_{ij}\}$ part of the basis, the **diagonal entries of $\mathring R$ are sectional curvatures**, so the record's $K_{ab}$ matrix is the restriction of $\mathring W$ to a diagonal subspace.

## Definition 3.1, the weighted-sum bracket used throughout

> **Definition 3.1.** Let $\omega_i\ge0$ with $\Omega=\max_i\omega_i$ and set $S=\sum_i\omega_i$. We call $S$ the **total weight** and $\Omega$ the **highest weight**. We will use the notation $[\mathcal R,\Omega,S]$ to denote any finite weighted sum $\sum_i\omega_i\lambda_i$ in terms of the eigenvalues $\lambda_i$ of the operator $\mathcal R$ with highest weight $\Omega$ and total weight $S$. In particular, if $F(R)$ is a (geometric) quantity depending on $R$ and $\mathcal R=\mathcal R(R)$ is an operator, then we write $F(R)\ge[\mathcal R,\Omega,S]$ provided $F(R)$ is bounded from below by a weighted sum in terms of the eigenvalues of $\mathcal R$ with highest weight $\Omega$ and total weight $S$.
>
> We write $[\mathcal R,\Omega,S]\ge[\mathcal R,\tilde\Omega,\tilde S]$ provided for every sum $\sum_i\omega_i\lambda_i$ with $\sum_i\omega_i=S$ and $\max_i\omega_i=\Omega$ there is a sum $\sum_i\tilde\omega_i\lambda_i$ with $\sum_i\tilde\omega_i=\tilde S$ and $\max_i\tilde\omega_i=\tilde\Omega$ such that $\sum_i\omega_i\lambda_i\ge\sum_i\tilde\omega_i\lambda_i$.

## Ricci bounds from partial sums of $\mathring R$-eigenvalues

> **Lemma 3.11.** For an algebraic curvature tensor $R$ let $\mathcal R$ denote the corresponding curvature operator of the second kind. The Ricci tensor satisfies $\mathrm{Ric}\ge[\mathcal R,1,(n-1)]$ and for $p\ge2$ we have $\sum_{i=1}^pR_{ii}\ge[\mathcal R,2,p(n-1)]$ with respect to any orthonormal basis $e_1,\dots,e_n$ for $V$.

Proof, in full: Proposition 3.10 gives $\sum_{i=1}^pR_{ii}=2\sum_{1\le i<j\le p}g(\mathcal R(\phi_{ij}),\phi_{ij})+\sum_{1\le i\le p}\sum_{p+1\le j\le n}g(\mathcal R(\phi_{ij}),\phi_{ij})$, and since the $\{\phi_{ij}\}$ are orthonormal, $\sum_{i=1}^pR_{ii}\ge[\mathcal R,2,\,2\cdot\tfrac{p(p-1)}{2}+p(n-p)]=[\mathcal R,2,p(n-1)]$.

> **Lemma 3.14.** For an algebraic curvature tensor $R$, let $\mathcal R$ denote the curvature operator of the second kind. With respect to any orthonormal basis, the Ricci tensor satisfies
> $$R_{11}\ge\frac{n-1}{n+1}[\mathcal R,1,n]+\frac1{n(n+1)}\mathrm{scal}$$
> and for $p\ge2$ we have
> $$\sum_{i=1}^pR_{ii}\ge\frac{n-p+1}{n-p+2}[\mathcal R,2,p(n-1)]+\frac{p}{n(n-p+2)}\mathrm{scal}.$$

*Lemma 3.14 refines Lemma 3.11 by using both the $\{\phi_{ij}\}$ and the $\{\psi_k\}$ halves of Proposition 3.10's basis.*

> **Proposition 3.13.** If $p\le\tfrac n2$ and $\omega$ is a $p$-form, then
> $$\tfrac32\,g(\mathrm{Ric}_L(\omega),\omega)\ge\Big[\mathcal R,\ \tfrac1{n(n+2)}\big(n^2p-np^2-2np+2n^2+4n-8p\big),\ \tfrac32p(n-p)\Big]\cdot\lvert\omega\rvert^2.$$

Its proof cites Propositions 1.2 and 2.1 and Lemmas 3.3, 3.7 and 3.11, working in an orthonormal basis that diagonalizes the Ricci tensor.

## The main theorems, with full hypotheses

> **Theorem A.** Let $(M,g)$ be a compact, $n$-dimensional Riemannian manifold. If the curvature operator of the second kind is $\tfrac{n+2}{2}$-nonnegative, then $(M,g)$ is either flat or a rational homology sphere.

> **Corollary.** Let $n\ge4$ and let $(M,g)$ be a compact, $n$-dimensional Riemannian manifold. If the curvature operator of the second kind is $3$-nonnegative, then $(M,g)$ is either flat or diffeomorphic to a spherical space form.

*This is the statement that closes off possibility (3) of Li's Theorem 1.7, see [li-2021-nonnegative-second-kind](../li-2021-nonnegative-second-kind/notes.md). The argument uses Wolf's [Wol69] classification of compact symmetric spaces that are real cohomology spheres, of which $\mathrm{SU}(3)/\mathrm{SO}(3)$ is the only simply connected non-sphere example, and the authors' own Example 4.5 showing its $\mathring R$ is 9-positive but not 8-nonnegative.*

> **Theorem B.** Let $(M,g)$ be a compact, $n$-dimensional Einstein manifold. Let $N=\tfrac{3n}{2}\tfrac{n+2}{n+4}$. (a) If the curvature operator of the second kind is $N$-positive, then $M$ is a rational homology sphere. (b) If it is $N'$-nonnegative for some $N'<N$, then $(M,g)$ is either flat or a rational homology sphere. (c) If it is $N$-nonnegative, then all harmonic forms are parallel.

> **Remark.** By the theory of Diophantine equations, $\tfrac{3n}{2}\tfrac{n+2}{n+4}$ is only an integer if $n=0,2,8$. Therefore, unless $n=2,8$, if the curvature operator of the second kind is $\lfloor N\rfloor$-nonnegative, part (b) applies.

> **Theorem C.** Let $(M,g)$ be a compact, $n$-dimensional Riemannian manifold and let $p\le\tfrac n2$. Set
> $$C_p=C_p(n)=\frac32\cdot\frac{n(n+2)p(n-p)}{n^2p-np^2-2np+2n^2+2n-4p}.$$
> (a) If the curvature operator of the second kind is $C_p$-positive, then the $p$-th Betti number $b_p(M,\mathbb R)$ vanishes. (b) If it is $C'$-nonnegative for some $C'<C_p$, then $b_p(M,\mathbb R)$ vanishes or $(M,g)$ is flat. (c) If it is $C_p$-nonnegative, then all harmonic $p$-forms are parallel.

The authors record that $C_p$ **increases** with $p\le\tfrac n2$, so the curvature conditions weaken as $p$ grows, the weakest at $p=\tfrac n2$, where $C_{n/2}=\tfrac{3n}{2}\tfrac{n+2}{n+4}$, matching Theorem B's $N$.

## What it cites

Cao–Gursky–Tran [CGT21] for the 4-nonnegative Einstein result Theorem B amplifies; Brendle [Bre10] for Einstein manifolds with nonnegative isotropic curvature; Kashiwada [Kas93] for the much earlier positive-$\mathring R$ case; X. Li [Li22] for the $n$-nonnegativity implication $\mathrm{Ric}\ge\tfrac{\mathrm{scal}}{n(n+1)}\ge0$; Wolf [Wol69] for the cohomology-sphere classification; Bochner [Boc46] for the Kähler analogue of the weakening-with-$p$ effect.

## Incomplete

Definitions 1.3, 1.6, Propositions 1.8, 2.1–2.4, Lemmas 3.3, 3.4, 3.7, Proposition 3.5, Theorem 3.6 (the weight principle), Corollary 3.9, Propositions 3.15, 3.17, Theorem D and Corollary 4.3 are named in the file but not transcribed. They are the Bochner-technique apparatus, which consumes $\nabla$ and compactness; the record's problem is pointwise-algebraic and uses only the frame dictionary and the Ricci bounds above.
