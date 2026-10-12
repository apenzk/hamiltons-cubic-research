# Li, *Product manifolds and the curvature operator of the second kind* (arXiv:2209.02119)

Transcribed 2026-09-02 from [li-2209.02119.txt](https://arxiv.org/abs/2209.02119) (`pdftotext -layout`). See [README.md](README.md) for the verdict.

## The load-bearing statement, Theorem 1.8, and its algebraic form

> **Theorem 1.8.** Let $(M_i,g_i)$ be an $n_i$-dimensional Einstein manifold with $\mathrm{Ric}(g_i)=\rho_ig_i$ and $n_i\ge1$ for $i=1,2$. Denote by $\mathring R_i$ the curvature operator of the second kind of $M_i$ for $i=1,2$, and $\mathring R$ the curvature operator of the second kind of the product manifold $(M^{n_1+n_2},g)=(M_1^{n_1}\times M_2^{n_2},g_1\oplus g_2)$. Then the eigenvalues of $\mathring R$ are precisely those of $\mathring R_1$ and $\mathring R_2$, and $0$ with multiplicity $n_1n_2$, and $-\dfrac{n_1\rho_2+n_2\rho_1}{n_1+n_2}$ with multiplicity one.

The purely algebraic version, which is the one that applies to an algebraic curvature tensor with no manifold behind it:

> **Proposition 2.1.** Let $R_i\in S^2_B(\Lambda^2V_i)$ for $i=1,2$ with $\dim(V_i)=n_i\ge1$ and let $R=R_1\oplus R_2$. If $\mathrm{Ric}(R_i)=\rho_ig_i$ for $i=1,2$, then the eigenvalues of $\mathring R$ are precisely those of $\mathring R_1$ and $\mathring R_2$, together with $0$ with multiplicity $n_1n_2$ and $-\dfrac{n_2\rho_1+n_1\rho_2}{n_1+n_2}$ with multiplicity one.

**The Einstein hypothesis on each factor is what makes it true**, and Li says why in the proof discussion: only then can an orthonormal basis of $S^2_0$ be chosen adapted to the splitting. Li notes Theorem 1.8 "can be applied repeatedly" to $(M_1,g_1)\times\cdots\times(M_k,g_k)$ provided each factor is Einstein with known $\mathring R_i$.

In this section $\mathring R$ acts on $S^2(V)$ by $\mathring R(\varphi)_{ij}=\sum_{k,l=1}^nR_{ijkl}\varphi_{kl}$, and the spectrum as a bilinear form on $S^2_0$ equals that of the self-adjoint $\pi\circ\mathring R$.

> **Lemma 2.1.** Let $R_i\in S^2_B(\Lambda^2V_i)$, $R=R_1\oplus R_2$, and let $E=\mathrm{span}\{u\odot v:u\in V_1,\ v\in V_2\}\subseteq S^2_0(V_1\times V_2)$. Then $E$ lies in the kernel of $\mathring R$; in particular $0$ is an eigenvalue of $\mathring R$ with multiplicity at least $n_1n_2$.

*Li credits the same observation to [NPWW22, Lemma 2.1].*

## The spectrum of the conjectured maximiser, Example 2.3, verbatim

> **Example 2.3.** Let $M=\mathbb S^{n_1}(\kappa_1)\times\mathbb S^{n_2}(\kappa_2)$. Then the curvature operator of the second kind of $M$ has eigenvalues: $\kappa_1$ with multiplicity $\tfrac{(n_1-1)(n_1+2)}{2}$, $\kappa_2$ with multiplicity $\tfrac{(n_2-1)(n_2+2)}{2}$, $0$ with multiplicity $n_1n_2$, and $-\dfrac{n_1(n_2-1)\kappa_2+n_2(n_1-1)\kappa_1}{n_1+n_2}$ with multiplicity one.

Notation fixed in §2: $\mathbb S^n(\kappa)$ and $\mathbb H^n(-\kappa)$ ($n\ge2$, $\kappa>0$) are the simply-connected space forms of constant sectional curvature $\pm\kappa$; $\mathbb{CP}^m(\kappa)$ and $\mathbb{CH}^m(-\kappa)$ ($m\ge1$) are the Kähler space forms of constant **holomorphic** sectional curvature $\pm4\kappa$.

The rest of the table, transcribed:

| example | manifold | spectrum of $\mathring R$ |
|---|---|---|
| 2.1 | $\mathbb S^n(\kappa)$ | $\mathring R=\kappa\,\mathrm{id}_{S^2_0}$; on $\mathbb H^n(-\kappa)$, $\mathring R=-\kappa\,\mathrm{id}_{S^2_0}$ |
| 2.2 | $\mathbb{CP}^m(\kappa)$ | $-2\kappa$ with multiplicity $(m-1)(m+1)$, $4\kappa$ with multiplicity $m(m+1)$; signs reversed on $\mathbb{CH}^m(-\kappa)$. Attributed to [BK78] |
| 2.4 | $\mathbb H^{n_1}(-\kappa_1)\times\mathbb H^{n_2}(-\kappa_2)$ | $-\kappa_1$ mult. $\tfrac{(n_1-1)(n_1+2)}{2}$, $-\kappa_2$ mult. $\tfrac{(n_2-1)(n_2+2)}{2}$, $0$ mult. $n_1n_2$, $+\tfrac{n_1(n_2-1)\kappa_2+n_2(n_1-1)\kappa_1}{n_1+n_2}$ mult. one |
| 2.5 | $\mathbb S^{n_1}(\kappa_1)\times\mathbb R^{n_2}$ | $\kappa_1$ mult. $\tfrac{(n_1-1)(n_1+2)}{2}$, $0$ mult. $n_1n_2+\tfrac{(n_2-1)(n_2+2)}{2}$, $-\tfrac{n_2(n_1-1)\kappa_1}{n_1+n_2}$ mult. one |
| 2.6 | $\mathbb H^{n_1}(-\kappa_1)\times\mathbb R^{n_2}$ | $-\kappa_1$ mult. $\tfrac{(n_1-1)(n_1+2)}{2}$, $0$ mult. $n_1n_2+\tfrac{(n_2-1)(n_2+2)}{2}$, $+\tfrac{n_2(n_1-1)\kappa_1}{n_1+n_2}$ mult. one |
| 2.7 | $\mathbb S^{n_1}(\kappa_1)\times\mathbb H^{n_2}(-\kappa_2)$ | $\kappa_1$, $-\kappa_2$ with the same two multiplicities, $0$ mult. $n_1n_2$, $-\tfrac{n_1n_2(\kappa_1-\kappa_2)+n_1\kappa_2-n_2\kappa_1}{n_1+n_2}$ mult. one |
| 2.8 | $\mathbb{CP}^{m_1}(\kappa_1)\times\mathbb{CP}^{m_2}(\kappa_2)$ | $-2\kappa_i$ mult. $(m_i-1)(m_i+1)$, $4\kappa_i$ mult. $m_i(m_i+1)$, $0$ mult. $4m_1m_2$, $-\tfrac{2m_1(m_2+1)\kappa_2+2m_2(m_1+1)\kappa_1}{m_1+m_2}$ mult. one |

## The rigidity thresholds

> **Theorem 1.5.** Let $(M_i^{n_i},g_i)$ be a Riemannian manifold of dimension $n_i\ge2$ for $i=1,2$, and let $(M^{n_1+n_2},g)=(M_1^{n_1}\times M_2^{n_2},g_1\oplus g_2)$. Set
> $$A_{n_1,n_2}:=1+n_1n_2+\frac{n_1(n_2-1)+n_2(n_1-1)}{n_1+n_2}.\tag{1.2}$$
> Then (1) if $M$ has $\alpha$-nonnegative or $\alpha$-nonpositive curvature operator of the second kind for some $\alpha<A_{n_1,n_2}$, then $M$ is flat; (2) if $M$ has $A_{n_1,n_2}$-nonnegative curvature operator of the second kind, then both $M_1$ and $M_2$ have constant sectional curvature $c\ge0$; (3) if $M$ has $A_{n_1,n_2}$-nonpositive curvature operator of the second kind, then both have constant sectional curvature $c\le0$. If $M$ is further assumed to be complete and nonflat, then the universal cover of $M$ is isometric to $\mathbb S^{n_1}\times\mathbb S^{n_2}$ in part (2) and $\mathbb H^{n_1}\times\mathbb H^{n_2}$ in part (3), up to scaling.

> **Theorem 1.6.** An $n$-dimensional Riemannian manifold with $\alpha$-nonnegative or $\alpha$-nonpositive curvature operator of the second kind for some $\alpha<k(n-k)+\dfrac{2k(n-k)}{n}$ cannot locally split off a $k$-dimensional factor with $1\le k\le n/2$, unless it is flat.

*This sharpens Li's own earlier threshold $k(n-k)+1$ from [Li21, Proposition 5.1], which was optimal only for special $n$ and $k$.*

> **Theorem 1.7.** Let $(M_i^{m_i},g_i)$ be a Kähler manifold of complex dimension $m_i\ge1$ for $i=1,2$, and let $(M^{m_1+m_2},g)=(M_1^{m_1}\times M_2^{m_2},g_1\oplus g_2)$. Set
> $$B_{m_1,m_2}:=4m_1m_2+\tfrac32\big(m_1^2+m_2^2\big)+\frac{m_1m_2}{m_1+m_2}.\tag{1.3}$$
> Then (1) $\alpha<B_{m_1,m_2}$ with $\alpha$-nonnegative or $\alpha$-nonpositive $\mathring R$ forces $M$ flat; (2) $B_{m_1,m_2}$-nonnegative forces both factors to have constant holomorphic sectional curvature $c\ge0$; (3) $B_{m_1,m_2}$-nonpositive forces $c\le0$. Complete and nonflat, the universal cover is $\mathbb{CP}^{m_1}\times\mathbb{CP}^{m_2}$ in (2) and $\mathbb{CH}^{m_1}\times\mathbb{CH}^{m_2}$ in (3), up to scaling.

> **Theorem 1.4.** Let $(M^n,g)$ be a closed non-flat Riemannian manifold of dimension $n\ge4$. Suppose that $M$ has $4\tfrac12$-nonnegative curvature operator of the second kind, then one of the following statements holds: (1) $M$ is homeomorphic (diffeomorphic if either $n=4$ or $n\ge12$) to a spherical space form; (2) $n=4$ and $M$ is isometric to $\mathbb{CP}^2$ with Fubini–Study metric up to scaling; (3) $n=4$ and the universal cover of $M$ is isometric to $\mathbb S^3\times\mathbb R$ up to scaling.

## The known-spectra list, quoted, this is the record's competitor universe

> the spectrum of $\mathring R$ are known only for a few examples: space forms with constant sectional curvature, Kähler and quaternion-Kähler space forms ([BK78]), $\mathbb S^2\times\mathbb S^2$ ([CGT21]), $\mathbb S^{n-1}\times\mathbb R$ ([Li21]), $\mathbb S^p\times\mathbb S^q$ ([NPWW22]).

## The proof strategy Li names

> The key idea to prove Theorems 1.2, 1.5 and 1.7 is to use the corresponding borderline example, such as $\mathbb S^{n-1}\times\mathbb R$, $\mathbb S^{n_1}\times\mathbb S^{n_2}$ or $\mathbb{CP}^{m_1}\times\mathbb{CP}^{m_2}$, as a model space and apply $\mathring R$ to the eigenvectors of the curvature operator of the second kind on the model space. … With the right choice of model space, this strategy leads to optimal results as the inequalities are all achieved as equalities on the model space.

Theorem 1.3's proof uses Berger's classification of restricted holonomy groups.

## Incomplete

Lemmas 2.2, 2.3, Propositions 3.1, 4.1, 6.1 and Lemma 4.1 are not transcribed; they are the internal steps of the rigidity proofs and the record uses only the spectral statements above.
