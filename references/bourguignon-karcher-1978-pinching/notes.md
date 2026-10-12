# Notes, Bourguignon, Karcher, *Curvature operators: pinching estimates and geometric examples*

Source on file: [bourguignon-karcher-1978-pinching.pdf](https://eudml.org/doc/82010), Ann. Sci. École Norm. Sup. (4) **11** (1978) 71–92, DOI [10.24033/asens.1340](https://doi.org/10.24033/asens.1340), retrieved from [Numdam](http://www.numdam.org/item/ASENS_1978_4_11_1_71_0/). Text for grepping: [bourguignon-karcher-1978-pinching.txt](https://eudml.org/doc/82010).

**The PDF is a 1978 scan.** Its text layer is lossy OCR, Greek letters come out as digits ($\delta\to$ "8", $\Delta\to$ "A", $\alpha\to$ "a"), and the eigenvalue columns of the tables in §5.2 and §5.3 come out partly blank. Everything transcribed below was read off the rendered page images, not off the `.txt`. Grep the `.txt` to locate a passage; read the PDF page to quote it.

## Conventions (§2.1–2.2)

$(V,g)$ is Euclidean of dimension $m$, identified with $V^*$. Products are unnormalised:
$$a\wedge b = a\otimes b - b\otimes a,\qquad a\odot b = a\otimes b + b\otimes a.$$
Curvature tensors $\mathcal{R}\subset\otimes^4V$ satisfy
$$R(a,b,c,d) = -R(b,a,c,d) = -R(a,b,d,c) = R(c,d,a,b) \tag{2.3}$$
together with the first Bianchi identity $R(a,b,c,d) + R(b,c,a,d) + R(c,a,b,d) = 0$.

For two-tensors $s,t$, the Kulkarni–Nomizu product is
$$(s\wedge t)(a,b,c,d) = s(a,c)t(b,d) + s(b,d)t(a,c) - s(a,d)t(b,c) - s(b,c)t(a,d).$$
If $s,t$ are symmetric then $s\wedge t$ is a curvature tensor; in particular $g\wedge g$ is the curvature tensor of constant sectional curvature $+2$.

## The two operators (§2.2)

**First kind**, on $\Lambda^2V$: for $\omega\in\Lambda^2V$,
$$\hat R(\omega)(a,b) = \sum_{i,j=1}^m R(e_i,e_j,a,b)\,\omega(e_i,e_j),$$
so that $(s\wedge t)^{\widehat{\ }}(\omega) = 2\,(t\circ\omega\circ s^* + s\circ\omega\circ t^*)$, and in particular $\widehat{g\wedge g} = 4\,\mathrm{Id}_{\Lambda^2V}$. From (2.3), $\widehat{\ }$ embeds $\mathcal R$ into $S^2\Lambda^2V$.

**Second kind**, on $S^2V$: for $h\in S^2V$,
$$\mathring R(h)(a,b) = \sum_{i,j=1}^m R(e_i,a,e_j,b)\,h(e_i,e_j),$$
so that $(s\wedge t)^{\mathring{\ }}(h) = \mathrm{trace}(s\circ h)\,t + \mathrm{trace}(t\circ h)\,s - t\circ h\circ s - s\circ h\circ t$, and $\mathring R(g) = \gamma(R) = \rho$, the Ricci tensor. From (2.3), $\mathring{\ }$ sends $\mathcal R$ into $S^2S^2V$; the Bianchi identity makes it an embedding.

**This index order is the load-bearing detail for this project.** The free arguments $a,b$ sit in slots 2 and 4, the contracted ones in slots 1 and 3. The paper's own remark (§1.3) is that the new feature of $\mathring R$ is that $S^2V$ fails to be $O(V)$-irreducible, it splits as $\mathbb{R}g\oplus S^2_0V$.

The paper is explicit (§1.3) that $\hat R$ and $\mathring R$ are *the only* curvature actions that occur when one relates second-order differential operators, and (§1.2) that $\hat R$ carries more $O(V)$-invariant information than its spectrum, since the rank of the eigenvectors is also invariant.

## The four principal results (§1.5, $m=\dim V$)

> **Proposition 3.3.** *Let $\hat r_{\min}$ and $\hat r_{\max}$ be respectively the smallest and the largest eigenvalues of $\hat R$. Then the eigenvalues of $\mathring R - \tfrac12\rho\wedge g$ lie in the interval $[-(m-2)\hat r_{\max},\ -(m-2)\hat r_{\min}]$ (the bounds are achieved in $\mathbb{CP}^n$, see 5.3). In particular if $\hat R$ is a positive operator, then $\mathring R - \tfrac12\rho\wedge g$ is negative.*

This is exactly what Meyer's theorem needs (§1.1(i): a compact connected oriented manifold with positive curvature operator has the rational homology of a sphere, [4]).

> **Proposition 3.8.** *If the sectional curvature $\bar R$ of $R$ satisfies $\delta\le\bar R\le\Delta$ and if an eigenvector of $\hat R$ for the eigenvalue $\hat r$ has rank $2k$, then*
$$(\delta+\Delta) - \tfrac{4k-1}3(\Delta-\delta)\ \le\ \hat r\ \le\ (\delta+\Delta) + \tfrac{4k-1}3(\Delta-\delta).$$
*In general the eigenvalues of $\hat R$ lie in $\bigl[(\delta+\Delta) - \tfrac{4\lfloor m/2\rfloor-1}3(\Delta-\delta),\ (\delta+\Delta) + \tfrac{4\lfloor m/2\rfloor-1}3(\Delta-\delta)\bigr]$. Moreover the last upper bound is achieved on $\mathbb{CP}^n$, see 5.2.*

> **Proposition 4.3.** *If $\delta\le\bar R\le\Delta$, then all eigenvalues of $\mathring R$ but one lie in the interval*
$$\Bigl[-\tfrac12\bigl((\delta+\Delta) + (m-1)(\Delta-\delta)\bigr),\ -\tfrac12\bigl((\delta+\Delta) - (m-1)(\Delta-\delta)\bigr)\Bigr],$$
*the other lying in $[(m-1)\delta,\ (m-1)\Delta]$. The first upper bound is sharp for $\mathbb{CP}^2$ and the last lower bound almost sharp for $\mathbb{CP}^n$, see 5.3.*

The exceptional eigenvalue is the one on $\mathbb{R}g$, since $\mathring R(g)=\rho$.

> **Proposition 7.5.** *The curvature tensor $R_\alpha = R_{S^6} - \alpha R_{\mathbb{CP}^3} + 3\alpha R_{G^{2,5}}$ for $\alpha\ge0$ (where $G^{2,5}$ is the Grassmann manifold of two-planes in $\mathbb{R}^5$) has sectional curvature range $[1-\alpha,\ 1+2\alpha]$. The Euler integrand $E(R_\alpha)$ is given by*
$$E(R_\alpha) = 18\,(5 + 3\alpha + 12\alpha^2 - 28\alpha^3)$$
*and is negative for $\alpha\ge\alpha_0 = 0.8227$. The pinching at $\alpha_0$ is $1/15$ (hence new counterexamples to the algebraic Hopf conjecture).*

§7 develops the Euler integrand in this formalism and thereby gives insight into Geroch's counterexample to the algebraic Hopf conjecture.

## The spectra of the projective spaces (§5)

**§5.1.** For $\mathbb{CP}^n$ with the Fubini–Study metric normalised so that the sectional curvature ranges over $[1,4]$ (opposite signs throughout for the dual):
$$2R_{\mathbb{CP}^n} = g\wedge g + J\wedge J + 4\,J\otimes J,$$
$$\hat R_{\mathbb{CP}^n}(\omega) = 2\bigl(\omega - J\circ\omega\circ J - \langle J,\omega\rangle J\bigr),\qquad \mathring R_{\mathbb{CP}^n}(h) = -h + \mathrm{trace}(h)\,g - 3\,J\circ h\circ J,$$
$$R_{\mathbb{CP}^n}(a,b,c,d) = (a,c)(b,d) - (a,d)(b,c) + (Ja,c)(Jb,d) - (Ja,d)(Jb,c) + 2(Ja,b)(Jc,d).$$
$R_{\mathbb{CP}^n}$ is Einstein, so its Ricci-traceless component vanishes, and its diagonal component is $U_{\mathbb{CP}^n} = \frac{n+1}{2n-1}\,g\wedge g$.

**§5.2, spectrum of $\hat R_{\mathbb{CP}^n}$** (using $J\circ(u\wedge v)\circ J = -Ju\wedge Jv$):

| Eigenspace | Dimension | Eigenvalue |
| --- | --- | --- |
| $\mathbb{R}\cdot J$ | $1$ | $4n+4 = 2(\dim_{\mathbb R}\mathbb{CP}^n + 2)$ (cf. Prop. 3.8) |
| $\mathrm{span}\{u\wedge v - Ju\wedge Jv\}$, $u,v$ $\mathbb{C}$-linearly independent | $n(n-1)$ | $0$ |
| $\mathrm{span}\{u\wedge v + Ju\wedge Jv\}$, $u,v$ $\mathbb{C}$-linearly independent | $n(n-1)$ | $4$ |
| $\mathrm{span}\{u\wedge Ju - v\wedge Jv\}$ | $n-1$ | $4$ |

The paper's comment: $\hat R_{\mathbb{CP}^n}$ has many eigenvectors of rank $4$, which makes it very special, and the multiplicities are large.

**§5.3, spectrum of $\mathring R_{\mathbb{CP}^n}$** (using $J\circ(u\odot v)\circ J = -Ju\odot Jv$):

| Eigenspace | Dimension | Eigenvalue |
| --- | --- | --- |
| $\mathbb{R}\cdot g$ | $1$ | $2(n+1)$ (cf. Prop. 4.3) |
| $\mathrm{span}\{u\odot v - Ju\odot Jv\}$ | $n(n+1)$ | $-4$ |
| $\mathrm{span}\{u\odot v + Ju\odot Jv\}$, $v$ orthogonal to $u$ | $n(n-1)$ | $2$ |
| $\mathrm{span}\{u\odot u + Ju\odot Ju - v\odot v - Jv\odot Jv\}$, $(u,u)=(v,v)$ | $n-1$ | $2$ |

The dimensions total $1 + n(n+1) + n(n-1) + (n-1) = 2n^2+n = \dim S^2\mathbb{R}^{2n}$. **On the traceless part $S^2_0$ this is two eigenvalues: $-4$ with multiplicity $n(n+1)$, and $2$ with multiplicity $n^2-1$.**

**§5.4.** The quaternionic projective space: $2R_{\mathbb{HP}^n} = g\wedge g + I\wedge I + 4I\otimes I + J\wedge J + 4J\otimes J + K\wedge K + 4K\otimes K$. The difference from the complex case is in the eigenspace dimensions, $\hat R_{\mathbb{HP}^n}$ has the three-dimensional eigenspace $\mathrm{span}\{I,J,K\}$ with the large eigenvalue $8n\ (= 2\dim_{\mathbb R}\mathbb{HP}^n)$, not as large in dimension as the complex case.

**§6** treats the distance spheres in the projective spaces and their duals (the classical counterexamples for lower bounds on the injectivity radius) as global examples where the pinching estimates of §3 and §4 are sharp.

## What it cites, for the record

Meyer [4] for the rational-homology-sphere theorem under $\hat R>0$; [12] for the Kulkarni–Nomizu algebra structure on $\bigoplus_k S^2\Lambda^kV$ and for the positivity of the Gauss–Bonnet integrand under $\hat R>0$; [5] and [10] for the failure of positive sectional curvature to suffice; [13] for consequences of a rank-two eigenbasis; [2] for harmonicity of the Weyl component on an Einstein manifold; [16, p. 64] for H. Weyl's theorem that $O(V)$-invariant actions are expressible by contractions; [3] for the earlier use of the action on symmetric two-tensors. Geroch is credited (§1.6) for the counterexample to the algebraic Hopf conjecture that §7 revisits.

## Bearing on this project

The §5.3 table is the external check on this repository's $\mathring W$ implementation and on the relative sign of the two index conventions. [run_bk_crosscheck.py](../../scripts/runs/run_bk_crosscheck.py) reproduces all four rows of the table exactly at $n=2,3,4$ in BK's own $ikjl$ order, the order §2.2 defines, contracting slots 1 and 3, and returns their negation in Li's $iklj$ order. [Li 2021](../li-2021-nonnegative-second-kind/README.md) §1 and [Li 2022](../li-2022-product-manifolds-second-kind/README.md) quote the same data as $-2$ with multiplicity $m^2-1$ and $4$ with multiplicity $m(m+1)$: the multiplicities agree with §5.3 above and both eigenvalues carry the opposite sign, which is precisely the change of order. [conventions.md](../../findings/conventions.md) records the record's choice of Li's $iklj$ and the conversion.

*An earlier version of this paragraph said the $iklj$ order reproduces BK's pair and the $ikjl$ order fails; that had the two orders swapped, and the [README](README.md) records how it was settled.*
