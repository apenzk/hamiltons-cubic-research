# Notes: Li, Usevich, Comon, arXiv:1804.01358

Setting: $\mathcal S_n$ the real symmetric third-order tensors, $f(Q)=\lVert\operatorname{diag}(\mathcal A\bullet_1Q^{\mathsf T}\bullet_2Q^{\mathsf T}\bullet_3Q^{\mathsf T})\rVert^2$ the diagonal mass over $Q\in SO_n$, $F(P,Q,R)$ the same with three independent orthogonal factors.

> **Definition 2.1.** For $\mathcal A\in\mathcal S_n$ and $i<j$, $d_{i,j}(\mathcal A)=\mathcal A_{iii}\mathcal A_{iij}-\mathcal A_{ijj}\mathcal A_{jjj}$ and $\omega_{i,j}(\mathcal A)=\mathcal A_{iii}^2+\mathcal A_{jjj}^2-3\mathcal A_{iij}^2-3\mathcal A_{ijj}^2-2\mathcal A_{iii}\mathcal A_{ijj}-2\mathcal A_{iij}\mathcal A_{jjj}$, and for the Givens rotation by $\theta$ in the plane $(i,j)$, $\bar h_{i,j}'(0)=6d_{i,j}$, $\bar h_{i,j}''(0)=-6\omega_{i,j}$, and with $x=\tan\theta$, $\bar h_{i,j}(\theta)-\bar h_{i,j}(0)=\frac4{(1+x^2)^2}\big(2d_{i,j}(x-x^3)-\omega_{i,j}x^2\big)$ (their (7), p. 6).

> **Definition 3.8.** (i) $MD_n=\{\mathcal A: I_n\in\operatorname{argmax}_{Q\in SO_n}f(Q)\}$, the maximally diagonal tensors. (ii) $LMD_n$, those at which $I_n$ is a local maximum of $f$. (iii) $GMD_n=\{\mathcal A:(I_n,I_n,I_n)\in\operatorname{argmax}F\}$ (p. 7).

> **Theorem 3.13.** Let $\mathcal A$ be stationary ($d_{i,j}=0$ for all $i<j$). Then $\mathcal A$ is Jacobi-diagonal (maximal against every single-plane rotation) if and only if the stationary diagonal ratio $\gamma_{ij}$, defined by $(\mathcal A_{ijj},\mathcal A_{iij})=\gamma_{ij}(\mathcal A_{iii},\mathcal A_{jjj})$, lies in $[-1,\tfrac13]$ for every $i<j$ (p. 7). *Proof: $-\omega_{i,j}=(3\gamma_{ij}^2+2\gamma_{ij}-1)(\mathcal A_{iii}^2+\mathcal A_{jjj}^2)$.*

> **Proposition 5.1.** $O(GMD_n)=\mathcal S_n$ if and only if $GMD_n=MD_n$ (p. 12).

> **Proposition 5.2.** $GMD_n=MD_n$ is equivalent to: the best rank-$n$ orthogonal approximation of every symmetric tensor can be chosen symmetric, and to $d(\mathcal A,O(\mathcal D_n))=d(\mathcal A,GO(\mathcal D_n))$ for every $\mathcal A$ (p. 12). Theorem 5.3 proves these at $n=2$.

**What binds for the record.** Their (7) is the one-plane finite-angle change, a rational function of $\tan\theta$ fixed by $d_{i,j}$ and $\omega_{i,j}$, so single-plane maximality equals its second-order condition. This is the same fact the record found for $\lVert\pi_{\mathcal D}W\rVert^2$ on Weyl operators ([2026-09-28-I121-MG-audit.md](../../reviews/2026-09-28-I121-MG-audit.md), first attempt at 27.2). The paper proves nothing about the global maximum beyond stationarity and Jacobi-diagonality, and poses GMD = MD as open for $n\ge3$.
