# Bettiol–Friedman, *Counting Homogeneous Einstein Metrics*, transcription

**R. G. Bettiol, H. Friedman, [arXiv:2509.09830](https://arxiv.org/abs/2509.09830)** (11 Sep 2025). Stored 2026-09-01. [paper.pdf](https://arxiv.org/abs/2509.09830), [paper.txt](https://arxiv.org/abs/2509.09830) (`pdftotext -layout`).

Read for one thing: the standard name and standard identities of the tensor the record calls $T_{abc}=c_{abc}^2$. Section 2.2 is where the transcription lives.

## The structure constants, verbatim, §2.2 (paper.txt lines 256–274)

> We now introduce constants associated to a compact homogeneous space $G/H$, in order to write the homogeneous Einstein equations. Let $b_i\in\mathbb R$ be the constants so that the Cartan–Killing form $B(X,Y)=\operatorname{tr}(\mathrm{ad}_X\circ\mathrm{ad}_Y)$ satisfies
> $$B|_{\mathfrak m_i}=-b_i\,Q|_{\mathfrak m_i},$$
> and set $d_i:=\dim\mathfrak m_i$ [...]. Next, let $\{v_\alpha\}$ be a $Q$-orthonormal basis of $\mathfrak m$ adapted to (2.1) [...]. Define the structure constants
> $$L_{ijk}:=\sum_{\substack{v_\alpha\in\mathfrak m_i\\ v_\beta\in\mathfrak m_j\\ v_\gamma\in\mathfrak m_k}}Q([v_\alpha,v_\beta],v_\gamma)^2 .$$
> Note that $L_{ijk}$ does not depend on the choice of $Q$-orthonormal basis, but only on the decomposition (2.1). The constants $L_{ijk}$ are nonnegative and $L_{ijk}=0$ if and only if $[\mathfrak m_i,\mathfrak m_j]$ is $Q$-orthogonal to $\mathfrak m_k$. Moreover, $L_{ijk}$ is symmetric in its 3 indices.

**This is the record's $T_{abc}$.** Take $\mathfrak g=\mathfrak{so}(n)$, $H$ trivial, and the decomposition into the $N=\binom n2$ eigenlines of $W$: then $d_i=1$, $\{v_\alpha\}$ is the eigenbasis, and $L_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2=T_{abc}$, with the same total symmetry and the same basis-independence.

## Ricci and scalar curvature, verbatim, (2.4) and (3.1)

> $$r_i^\ell(x)=\frac{b_i}{2x_i}-\frac1{4d_i}\sum_{j,k=1}^{\ell}L_{ijk}\frac{2x_k^2-x_i^2}{x_ix_jx_k},\qquad 1\le i\le\ell.$$

> We observe that $P$ is the Newton polytope of the scalar curvature of the homogeneous metric (2.2), which is the Laurent polynomial in $x$ given by
> $$\mathrm{scal}(x):=\sum_{i=1}^{\ell}d_ir_i^\ell(x)=\sum_{i=1}^{\ell}\frac{d_ib_i}{2x_i}-\frac14\sum_{i,j,k=1}^{\ell}L_{ijk}\frac{x_k}{x_ix_j}.$$

**Both are members of the record's family $\sum_{abc}\lambda_a^p\lambda_b^q\lambda_c^r\,T_{abc}$**, with weights $\{1,-1,-1\}$ and $\{2,-1,-1,-1\}$-shaped rather than the record's nonnegative monomials. So the family the record classified is the family the homogeneous-Einstein literature computes in, under a different substitution.

## Where the record's relation (A) sits

Setting $H$ trivial and $\mathfrak g=\mathfrak{so}(n)$: the Killing form is $B(X,Y)=(n-2)\operatorname{tr}(XY)=-2(n-2)\,Q(X,Y)$ for $Q=-\tfrac12\operatorname{tr}$, so $b_i=2(n-2)$ for every $i$. With trivial isotropy the Casimir term drops and the standard row-sum identity reads $\sum_{j,k}L_{ijk}=d_ib_i=2(n-2)$, **the record's relation (A), $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$, exactly.**

## What it does not do

The homogeneous-Einstein programme takes $L$ as *given parameters encoding the group* and studies the Laurent system in $x$. It therefore never asks whether a particular $L$-moment is determined by anything, because nothing plays the role of the record's spectrum. **This source names the object and hands over the surrounding machinery; it does not contain the record's classification, and it does not contradict it.**

The transferable machinery, recorded so a successor can find it: Theorem A bounds the isolated solutions of the Einstein system by the central Delannoy number $D_{\ell-1}$ via the BKK/mixed-volume bound on the Newton polytope of $\mathrm{scal}$. If the record ever needs to count critical points of a $T$-moment functional in the eigenvalues, that is the template.
