# Brendle, where $n\ge12$ lives, transcribed

**S. Brendle, *Ricci flow with surgery on manifolds with positive isotropic curvature*, [arXiv:1711.05167](https://arxiv.org/abs/1711.05167).** Page numbers are those of the extraction.

## The transformation, and the Weyl tensor (p. 7)

> Under the transformation $\ell_{a,b}$, the scalar curvature changes by a factor of $1+2(n-1)a$, the trace-free Ricci tensor changes by a factor of $1+(n-2)b$, **and the Weyl tensor is unchanged.**

*This is the sentence that settles the sweep's question: the pinching machinery cannot see the Weyl part.*

## The cone family (Section 3, p. 18)

> Throughout this section, we assume that $n\ge12$. Let $b_{\max}=\tfrac1{4n}$. To each $0<b\le b_{\max}$ we associate $a=\tfrac{(2+(n-2)b)^2}{2(2+(n-3)b)}\,b$, $\gamma=\tfrac{b}{2+(n-3)b}$, and $\omega^2=\tfrac{27(2+(n-2)b)}{8}\cdot\tfrac{(1-4(n-2)b^2)^4(1+(n-2)b)^2}{n^2b^2(2+(n-3)b)^2}$.

> **Definition 3.1.** For $0<b\le b_{\max}$, let $E(b)$ denote the set of all curvature tensors $S$ for which there exists a tensor $T$ satisfying: (i) $T$ has all the algebraic properties of a curvature tensor except the first Bianchi identity, and $T\ge0$; (ii) $S-T\in\mathrm{PIC}$; (iii) $\mathrm{Ric}(S)_{11}+\mathrm{Ric}(S)_{22}+\tfrac{2\gamma}{n}\operatorname{scal}(S)\ge0$; (iv) for every orthonormal frame, $\mathrm{Ric}(S)_{22}-\mathrm{Ric}(S)_{11}\le\omega\operatorname{scal}(S)^{1/2}\big(\sum_{p\ge3}(T_{1p1p}+T_{2p2p})\big)^{1/2}+2(n-2)b\sum_{p\ge3}(T_{1p1p}+T_{2p2p})$. Moreover $C(b)=\ell_{a,b}(E(b))$.

> **Theorem 3.2.** For each $0<b\le b_{\max}$, the cone $C(b)$ is transversally invariant under the Hamilton ODE $\tfrac{d}{dt}R=Q(R)$.

## The one place $n\ge12$ is used (Lemma 3.3, pp. 18–19)

> **Lemma 3.3.** Let $n\ge12$, let $0<b\le b_{\max}$, and let $a$ and $\omega$ be defined as above. Then $2+(n-8)b-2(n+2)(n-2)b^2-n(n-2)^2b^3>0$ and $\tfrac{n-2}{n-3}+\tfrac{2(n-2)}{n}(2b+(n-2)a)+8(n-3)b^2\le\tfrac{\omega}{2}$ together with $\tfrac{n-2}{n-3}+2(2b+(n-2)a)\le\tfrac\omega2$.

*Its proof is elementary: the first inequality from $2-2(n+2)(n-2)b^2\ge0$ and $(n-8)b-n(n-2)^2b^3\ge0$, the second from $\omega\ge\ldots$ and $a\le\tfrac98b$, closing with "it is elementary to verify that ... for $n\ge12$".* **Every quantity in it is a cone parameter or a Ricci coefficient. No Weyl term appears.**

## How the ODE is estimated (Section 3, p. 25)

*The evolution of $\mathrm{Ric}(S)_{22}-\mathrm{Ric}(S)_{11}$ is split as $J_1+\dots+J_6$, each a Ricci or PIC-frame term, and $J_4=-2S_{1212}(\mathrm{Ric}_{22}-\mathrm{Ric}_{11})$ is bounded through the PIC four-frame sum $0\le\sum_{p\ne q}(S_{1212}+S_{1p1p}+S_{2q2q}+S_{pqpq})=(n-2)(n-3)S_{1212}+(n-4)\sum_p(S_{1p1p}+S_{2p2p})+\sum_p\mathrm{Ric}_{pp}$.* **The estimate runs on sectional-curvature frames and Ricci entries; the Weyl operator on $\Lambda^2$ is never isolated.**
