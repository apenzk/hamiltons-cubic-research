# Notes, Deninger, Grundhöfer, Kramer, *Weyl tensors, strongly regular graphs, multiplicative characters, and a quadratic matrix equation*

pp. 1–3 transcribed 2026-08-31; §§2.6–8 transcribed 2026-09-02 by [LIT-srg-forward](../../reviews/LIT-srg-forward.md) from the `pdftotext` dump [dgk-2204.02706.txt](https://arxiv.org/abs/2204.02706) (line references L… are to that dump). Published: J. Algebra 656 (2024) 170–195, [doi 10.1016/j.jalgebra.2023.08.028](https://doi.org/10.1016/j.jalgebra.2023.08.028).

## pp. 1–3

**The equation** (abstract, verbatim in symbols): $S$ real symmetric $n\times n$, zero diagonal, $\theta\in\mathbb R$, with
$$\sum_kS_{i,k}=0\qquad\text{and}\qquad\sum_kS_{i,k}S_{k,j}+S_{i,j}^2=\theta S_{i,j}\ \ (i<j).$$
This is this record's diagonal locus of $Q(W)=\theta W$, verbatim.

> **Theorem 1.1** (p. 2, transcribed): for every $n\ge4$ there exists an Einstein algebraic curvature tensor $R$, not a multiple of the identity, with the $e_i\wedge e_j$ ($i<j$) as eigenvectors and $R^2+R^\#=\theta R$ with $\theta\ge0$.

**The correspondence** (p. 3, transcribed): solutions whose eigenvalue spectrum consists of **precisely two real numbers** are, up to scaling, **in one-to-one correspondence with strongly regular graphs** $\Gamma$; and if both $\Gamma$ and its complement are connected, $R$ is **not** the curvature tensor of a product of spheres, with $n$ = the number of vertices.

**Character solutions** (p. 3): further nontrivial solutions at $n=q$ a prime power, $q\equiv1\pmod m$, $m=3,4,8$, from multiplicative characters of $\mathbb F_q$.

**Jäger's existence results, cited by them** (p. 2): nontrivial solutions exist for $n=m\ell$ composite, and for $n=p$ prime $\equiv1\pmod4$ via Legendre symbols, from the same Jäger 2016 Münster thesis this record already holds as the source of the granted diagonal case, whose existence half [problem.md](../../findings/problem.md) does not carry.

**Framing** (p. 2): such solutions are "obstructions to an evolution towards a metric with constant positive sectional curvature"; for most, unknown whether they arise from Riemannian manifolds, i.e. purely algebraic critical points, exactly this programme's objects.

## §2.6, the dictionary between $S$ and $W$, and the normalisation of $\theta$ (L313–L381)

Diagonal $R$: $R(e_i\wedge e_j)=r_{i,j}e_i\wedge e_j$; Einstein iff $\sum_kr'_{i,k}=0$ with $r'_{i,j}=r_{i,j}-r$, $r=s(R)/(n(n-1))$. For diagonal $R,T$ (L365–L368, verbatim): $(R\#T)(e_i\wedge e_j)=\tfrac12\sum_k(r_{i,k}t_{j,k}+t_{i,k}r_{j,k})\,e_i\wedge e_j$, "the Jordan product of the symmetric matrices $(r_{i,j})$ and $(t_{i,j})$". With $S_{i,j}=w_{i,j}$ the Weyl eigenvalues, $R^2+R^\#=\theta R$ is equivalent to $(n-1)r^2=\theta r$, (a) $\sum_kS_{i,k}=0$, (b) $S_{i,j}^2+\sum_kS_{i,k}S_{k,j}=\theta S_{i,j}$ for $i<j$ (L370–L378). And (L379–L380, verbatim): "the $\ell^2$-norms of the matrix $S$ and the Weyl curvature tensor $R_2=W(R)$ are related by $\lVert S\rVert_2=\sqrt2\,\lVert W(R)\rVert_2$."

**Conversion to the record's $\theta$.** DGK's $\theta$ is the record's $\theta$ at the unnormalised $W$, and DGK's scale-invariant $\hat\theta=|\theta|/\lVert S\rVert_2$ (L419). The record's $\theta$ at unit norm is $\theta/\lVert W\rVert=\sqrt2\,|\theta|/\lVert S\rVert_2$, so
$$\theta_{\text{record}}=\sqrt2\,\hat\theta_{\text{DGK}}.$$
Check on Example 5.2 with $m=2$, $\ell=n/2$: $\hat\theta=\sqrt{(\ell-1)(n-1)/(n(n-\ell))}=\sqrt{(n-2)(n-1)}/n$, and $\sqrt2\hat\theta=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$, the record's balanced-product value. Every $\hat\theta$ below is to be multiplied by $\sqrt2$ before comparison with the record's tables.

Also (L301–L302): $R+\mathrm{id}\#R=(n-1)R_0+\tfrac{n-2}{n}R_1$ and $(R_2+R^\#)_3=0$, the first is the record's relation (B), $W^\#I=-W$, stated for all three components at once.

## §3, the matrix form, inflation, and the block law (L386–L453)

Equation (1) (L400): $S=S^{\mathsf T}$, $S\odot\mathbb 1=0$, $SJ=0$, $S\odot S+S^2=\theta S+D$ with $D$ diagonal, $D_{i,i}=\sum_kS_{i,k}^2$, $\mathop{\mathrm{tr}}D=\lVert S\rVert_2^2$. Scale law (2): $tS$ solves with $(t\theta,t^2D)$. Inflation (L424–L427): a solution in dimension $n$ padded by zeros is a solution in every $m>n$ with the same $\theta$, the record's zero-padding.

> **Lemma 3.1** (L428–L438). Suppose that we have two nonzero solutions $S_1,S_2$ to the equations (1), in dimensions $n_1$ and $n_2$ and for constants $\theta_1,\theta_2$, respectively. If $\theta_1,\theta_2\ne0$, then the block diagonal matrix $S=\tfrac1{\theta_1}S_1\oplus\tfrac1{\theta_2}S_2$ solves (1) in dimension $n=n_1+n_2$, with $\theta=1$ and $\hat\theta=\hat\theta_1\hat\theta_2/\sqrt{\hat\theta_1^2+\hat\theta_2^2}$. If $\theta_1=\theta_2=0$, then $S_1\oplus S_2$ solves (1) with $\theta=\hat\theta=0$.

This is the record's harmonic-square law $1/\theta^2=1/\theta_1^2+1/\theta_2^2$ on $\circ$-decomposables ([fence post 35](../../findings/fence-posts.md)), proved here on the diagonal locus.

> **Theorem 3.2** (L441–L445). The equations (1) have a solution $S\ne0$ in every dimension $n\ge4$, with $\hat\theta\ne0$. A solution $S$ where the off-diagonal matrix entries of $S$ assume precisely two distinct values exists if and only if $n=m\ell$ is a composite number, or if $n=p$ is a prime with $p\equiv1\pmod4$. In the latter case, $\hat\theta=0$.

Proof (L446–L453): composite $n$ from Example 5.2 or 6.4, then inflation; the sphere product $S^{n_1}\times S^{n_2}$ gives a solution with three off-diagonal values; the two-value claim is Theorem 5.1. **New to the record**: at a prime $n\equiv3\pmod4$ the diagonal locus has no two-eigenvalue critical point at all, and at a prime $n\equiv1\pmod4$ every two-eigenvalue diagonal critical point has $\theta=0$.

## §5, Theorem 5.1, the SRG correspondence (L575–L629)

> **Theorem 5.1.** Suppose that the $n\times n$ matrix $S$ solves (1) and that the off-diagonal entries of $S$ assume precisely two different values $x\ne y$. Put $z=x-y$. Then $S=zA+yK$ and $A\ne0,K$ is the adjacency matrix of a strongly regular graph $\Gamma$. Conversely, if $A\ne0,K$ is the adjacency matrix of an $\mathrm{srg}(n,r,\lambda,\mu)$, then $S=zA+yK$ solves (1), with $y/z=r/(1-n)$ and $\hat\theta=|\lambda-\mu+1|\sqrt{(n-1)/(nrr^c)}$, where $r^c=n-r-1$. An integer $n$ occurs in this situation if and only if $n$ is either a composite number or if $n=p$ is a prime with $p\equiv1\pmod4$. In the latter case $\theta=0$.

Here $K=J-\mathbb 1$. In the proof: $\theta=\lambda-\mu+1$ at $z=1$, $D=r(y+1)\mathbb 1$, $\mathop{\mathrm{tr}}D=nrr^c/(n-1)$; complement flips the sign of $\theta$ (L590–L591). Primes: an SRG on a prime number of vertices is a conference graph, so $p\equiv1\pmod 4$ and $\theta=0$ (L620–L624, citing Godsil–Royle 10.3.2, 10.3.4).

**This is the record's [Lemma 74](../../findings/diagonal-half.md) verbatim, with $\theta_{\text{record}}=\sqrt2\hat\theta$.** The record's derivation went through the SRG identity $k(k-\lambda-1)=w\mu$ and reached the same $\theta$; Lemma 74's numerator is DGK's $|\lambda-\mu+1|$ and its normaliser is DGK's $\sqrt{nrr^c/(n-1)}$. The record's $T12$ classification (saturation only at $K_{m,m}$ and $2K_m$) is downstream of this theorem and is not in DGK.

Examples (all with $\hat\theta$; multiply by $\sqrt2$ for the record):

- **5.2, $mK_\ell$** (L630–L634): $\mathrm{srg}(m\ell,\ell-1,\ell-2,0)$, $\theta=\ell-1$, $\hat\theta=\tfrac1\ell\sqrt{(\ell-1)(m\ell-1)/(m(m-1))}$. DGK: "corresponds to the Weyl curvature tensor of a product of $m$ round spheres of dimension $\ell$" (L626–L628). At $m=2$ this is the balanced product.
- **5.3, Kneser $K(m,2)$** (L640–L652): $n=\binom m2$, $\theta=5-m$, $\hat\theta=|5-m|\sqrt{(m+1)/(m(m-1)(m-2)(m-3))}$; $\hat\theta\sim1/m\sim1/\sqrt{2n}$.
- **5.4, $Fi_{24}$; 5.5–5.6** sporadic and rook's graphs (L653–L703); the rook's graph is the Cayley graph of $\mathbb Z/m\times\mathbb Z/m$ (L700–L702).
- **5.7, Paley** (L704–L730): $q\equiv1\pmod4$, conference graph, $\theta=0$.
- **5.9, families of subgroups** (L746–L760): $A$ abelian of order $m^2$, $\ell$ subgroups of order $m$ meeting trivially, $\mathrm{srg}(m^2,\ell(m-1),\ell^2-3\ell+m,\ell^2-\ell)$, $\theta=m-2\ell+1$, $\hat\theta=\tfrac{|m-2\ell+1|}{m}\sqrt{(m+1)/(\ell(m-1)(m-\ell+1))}$. At $\ell=1$: $m$ disjoint $K_m$, i.e. Example 5.2 with $m=\ell$.

Every primitive example has $\hat\theta\to0$ as $n\to\infty$ at rate $n^{-1/2}$ or faster, against $\theta_0(n)\to\sqrt2$; the record's [T12](../../plan.md) closure is the exact statement.

## §6, group rings: Theorem 6.1 and Example 6.4 (L771–L906)

> **Theorem 6.1** (L793–L802). Let $G$ be a finite group of order $n$ and let $\varphi\in R(G,\mathbb R)$. Define $S_{a,b}=\varphi(a^{-1}b)$. Then $S$ satisfies (1) for a real constant $\theta$ if and only if $\varphi$ satisfies (7): $\varphi=\varphi^\sigma$, $\epsilon(\varphi)=0$, $\langle\varphi,1\rangle=0$, $\varphi^2+\varphi*\varphi=\theta\varphi+\lVert\varphi\rVert_2^2\,\delta_e$. Then $n=|G|$ and $\hat\theta=|\theta|/(\sqrt n\lVert\varphi\rVert_2)$.

Here $\varphi^\sigma(g)=\varphi(g^{-1})$, $\epsilon(\varphi)=\varphi(e)$, $*$ is convolution. Theorem 6.2 is the same translation for SRG Cayley graphs. **For the record**: on the vertex-transitive (Cayley) part of the diagonal locus the criticality equation is a single equation in the group algebra, pointwise square plus convolution square. This is the setting in which the record's [diagonal-half.md](../../findings/diagonal-half.md) writes $M^{\circ2}=\theta M-M^2+\tfrac2nI$; DGK's $\lVert\varphi\rVert_2^2\delta_e$ is that $\tfrac2nI$ term before normalisation.

**Example 6.4** (L840–L906), $G=\mathbb Z/\ell\times\mathbb Z/m$, $\varphi=s\chi_A+t\chi_B+\chi_C$ on the three nonzero "rows/columns/rest" classes: three solutions for $n=m\ell$,

| $s$ | $t$ | $\theta$ | $\hat\theta$ |
| --- | --- | --- | --- |
| $\tfrac{1-m}2$ | $\tfrac{1-\ell}2$ | $\tfrac{4-(m-1)(\ell-1)}2$ | $\dfrac{\lvert4-(m-1)(\ell-1)\rvert}{\sqrt{m\ell(\ell-1)(m-1)(m+\ell+2)}}$ |
| $\tfrac{\ell(1-m)}{\ell-1}$ | $1$ | $1-m\ell$ | $\tfrac1\ell\sqrt{(\ell-1)(m\ell-1)/(m(m-1))}$ |
| $1$ | $\tfrac{m(1-\ell)}{m-1}$ | $1-m\ell$ | $\tfrac1m\sqrt{(m-1)(m\ell-1)/(\ell(\ell-1))}$ |

The first "is also contained in Jäger's Thesis [12, Thm. 2.2.5]"; for $m=\ell$ it is the negative of the rook's graph solution; the second and third are Example 5.2 (L903–L906). The first row's $\hat\theta$ is read off the dump, whose typesetting is ambiguous about a factor 2; it is confirmed by two checks: at $m=\ell=4$ it reproduces the rook's graph $\mathrm{srg}(16,6,2,2)$ value $\sqrt{15/864}$, and at $m=\ell=2$ it gives $\sqrt2\hat\theta=\sqrt3/2=\theta_0(4)$. **For the record this is a three-valued diagonal critical family, outside Lemma 74's two-valued hypothesis, with $\theta_{\text{record}}=\sqrt2\hat\theta\sim\sqrt{2/(m+\ell)}$ for large $m,\ell$**; at $(m,\ell)=(2,3)$ it is $0.309$ against $\theta_0(6)=1.054$, so it competes nowhere, and $\theta$ changes sign at $(m-1)(\ell-1)=4$.

## §7, multiplicative characters (L907–L1120)

Lemma 7.2: every real solution on $(\mathbb F_q,+)$ is a complex combination $\sum_{\alpha\ne\varepsilon}c_\alpha\alpha$ of nontrivial multiplicative characters with $\bar c_\alpha=c_{\bar\alpha}$; convolution of characters is a modified Jacobi sum, $\alpha*\beta=J'(\alpha,\beta)\,\alpha\beta$ on $\mathbb F_q^\times$ (L1000–L1005), $J'(\bar\alpha,\alpha)=-\alpha(-1)$ (Lemma 7.3).

- **7.4, quartic**, $q\equiv1\pmod4$: $\varphi=\alpha^2$, $\theta=\hat\theta=0$, the Paley graph.
- **7.5, octic**, $q\equiv1\pmod8$: $\varphi=c\alpha^2+\bar c\bar\alpha^2$ with $\mathop{\mathrm{Re}}(c^2(1+J'(\alpha^2,\alpha^2)))=0$; $\theta=\hat\theta=0$. Peisert graphs when $q=p^{2s}$, $p\equiv3\pmod4$; and (L1091–L1094, verbatim) "Our general construction does not necessarily correspond to strongly regular graphs. For example, if $q=73$, then $J(\alpha^2,\alpha^2)=3+8i$ and $\varphi$ assumes four different values on $\mathbb F_{73}^\times$." **A diagonal critical point with four off-diagonal values, at $\theta=0$.**
- **7.6, cubic**, $q\equiv1\pmod3$: $\varphi=c\alpha+\bar c\bar\alpha$ with $\theta=c^3(1+J'(\alpha,\alpha))\in\mathbb R$; $\hat\theta=|1+J'(\alpha,\alpha)|/\sqrt{2q(q-1)}$, bounded between $(\sqrt q\mp1)/\sqrt{2q(q-1)}$, so $\theta_{\text{record}}\sim\sqrt{2/q}$. Three off-diagonal values in general, $\theta\ne0$, tiny.

## §8, Conjecture 8.1 and the acknowledgement (L1121–L1146)

> **Conjecture 8.1.** Let $q\ge4$ be a prime power. Then the equations (7) in Theorem 6.1 have real solutions $\varphi\ne0$, where $G$ is the additive group of the finite field $\mathbb F_q$ and $n=q$.

Based on SageMath experiments; Peter Müller supplied solutions for $m=10$. Acknowledgement (L1144–L1145, verbatim): "Hans Cuypers and Ferdinand Ihringer suggested that certain association schemes might also lead to solutions.", the association-scheme line of the record's search target 2 was proposed to the authors and, as of the published version, left unworked; no later paper has taken it up (zero forward citations, 2026-09-02).

## What DGK does NOT do

- No inequality on $\theta$ or $\hat\theta$, no extremal statement, no comparison between solutions; $\theta_0(n)$ appears only implicitly as Example 5.2 at $m=2$.
- No statement about non-diagonal critical points; everything is inside the coordinate-eigenvector locus.
- No spectral theory of $S$ beyond the SRG eigenvalues; the Bose–Mesner reformulation is not written down.
- No connection to Payne's structure vector, Wang–Ziller's $L_{ijk}$, or Böhm–Wilking's per-row identity beyond L301–L302.
- Cites Bhattacharya and Richard–Seshadri nowhere; its "obstruction" sentence (p. 2) is Richard–Seshadri's Proposition 4.3 without attribution.
