# Notes, Huang, Wang, *Decomposition of the Curvature Operator and Applications to the Hopf Conjecture*

Source on file: [huang-wang-2025-hopf-decomposition.pdf](https://arxiv.org/abs/2507.15237), arXiv:2507.15237v2 [math.DG], 25 Jul 2025. Text for grepping: [huang-wang-2025-hopf-decomposition.txt](https://arxiv.org/abs/2507.15237).

## The object under study

**Conjecture 1 (Hopf).** *Let $(M,g)$ be a compact Riemannian manifold of even dimension $2n$ ($n\ge2$) with sectional curvature $\sec_g$. Then $(-1)^n\chi(M)\ge0$ if $\sec_g\le0$, and $\chi(M)\ge0$ if $\sec_g\ge0$.*

The paper works with two auxiliary curvature operators, $\mathcal S$ and $\mathcal W$, defined from the Kulkarni–Nomizu decomposition by
$$g\bigl(\mathcal S(X\wedge Y), Z\wedge W\bigr) = (S_g\odot g)(X,Y,Z,W),\qquad g\bigl(\mathcal W(X\wedge Y), Z\wedge W\bigr) = W_g(X,Y,Z,W),$$
where $S_g$ is the Schouten tensor and $W_g$ the Weyl tensor.

## The decomposition

> **Theorem 1.1.** *Let $(M,g)$ be a compact manifold of dimension $n\ge4$, and let $\{e_i\}_{1,\dots,n}$ be an orthonormal eigenbasis for the Ricci curvature tensor. Then the curvature operator $\mathcal R$ satisfies*
$$\langle \mathcal R(e_i\wedge e_j), e_i\wedge e_j\rangle = \lambda_{ij} + W_{ijij} = \mathrm{Rm}(e_i,e_j,e_i,e_j),$$
$$\langle \mathcal R(e_i\wedge e_j), e_k\wedge e_l\rangle = W_{ijkl},\qquad \forall\,(i,j)\ne(k,l),$$
*where $\lambda_{ij} = \frac1{n-2}\bigl(\lambda_i + \lambda_j - \frac{R_g}{n-1}\bigr)$ and $i<j$, $k<l$. Consequently $\mathcal R = \mathcal S + \mathcal W$, with $\mathcal S = \operatorname{diag}(\lambda_{12},\dots,\lambda_{(n-1)n})$ and $\mathcal W = (W_{ijkl})$.*

So in the Ricci eigenbasis, $\mathcal S$ carries the whole diagonal and $\mathcal W$ carries the whole off-diagonal, the Hermitian split the title names. **Lemma 2.4** is the computational half: $\mathcal S(e_i\wedge e_j) = \frac1{n-2}\bigl(\lambda_i + \lambda_j - \frac{R_g}{n-1}\bigr)(e_i\wedge e_j)$, so $\{e_i\wedge e_j\}$ is an eigenbasis of $\mathcal S$ with eigenvalues $\lambda_{ij}$. **Corollary 2.5** specialises to locally conformally flat metrics, where $\mathcal W=0$ and the $\lambda_{ij}$ are the eigenvalues of $\mathcal R$ itself. **Remark 2.6** notes only the extremes are ordered: $\lambda_{12}<\lambda_{13}$ minimal, $\lambda_{(n-2)n}<\lambda_{(n-1)n}$ maximal.

## Consequences for the Hopf conjecture

> **Proposition 2.3.** *Let $(M,g)$ be compact of dimension $2n$. (i) If $\mathcal R\succeq0$ then $\chi(M)>0$; if $\mathcal R\succ0$ then $M$ is a rational (co)homology sphere. (ii) If $\mathcal R\preceq0$ then $(-1)^n\chi(M)\ge0$; if $\mathcal R\prec0$ then $(-1)^n\chi(M)>0$.*

> **Proposition 2.7** (cited to [44]). *If $e_i\wedge e_j$ diagonalise $\mathcal R$ with $\mathcal R(e_i\wedge e_j)=\lambda_{ij}\,e_i\wedge e_j$, then for any 2-plane $\pi\subset T_pM$, $\sec(\pi)\in[\min\lambda_{ij},\max\lambda_{ij}]$.*

**Theorem 1.2 (= Theorem 2.8).** *The Hopf conjecture holds for all compact locally conformally flat manifolds of even dimension $2n$ ($n\ge2$).* In the form of Theorem 2.8, for $n\ge4$: (1) positive sectional curvature gives $b_p(M)=0$ for all $1\le p\le n-1$, and $\chi(M)=2$ for even $n$; (2) negative (resp. nonpositive) sectional curvature and even $n$ gives $(-1)^{n/2}\chi(M)>0$ (resp. $\ge0$). Proof of (1) via Meyer [42].

> **Theorem 1.3.** *Let $(M,g)$ be compact of even dimension $2n$ ($n\ge2$) with $\sec_g\ge a>0$ (resp. $\sec_g\le -a<0$). If*
$$|W_g| < \sqrt{\frac{n(n-1)}{(n+1)(n-2)}}\,a,$$
*then $\mathcal R$ is positive (resp. negative); in particular $\chi(M)>0$ (resp. $(-1)^n\chi(M)>0$).*

## Eigenvalue machinery

> **Definition 2.9** (cf. [34, 43, 49]). *$(M,g)$ has positive $k$th-intermediate Ricci curvature, $k\in\{1,\dots,n-1\}$, if for any orthonormal $\{u,e_1,\dots,e_{n-1}\}$ the sum $\sum_{i=1}^k \sec_g(u,e_i) = \sum_{i=1}^k \mathrm{Rm}(u,e_i,u,e_i)$ is positive.* $\mathrm{Ric}_1>0$ is positive sectional curvature, $\mathrm{Ric}_{n-1}>0$ is positive Ricci curvature, and $\mathrm{Ric}_k>0 \Rightarrow \mathrm{Ric}_l>0$ for $l\ge k$.

> **Lemma 3.1** (cf. [1, p. 35], from Ky Fan's maximum principle). *For Hermitian $A,B$ with eigenvalues in increasing order: $\sum_{j=1}^k\lambda_j(A+B) \ge \sum_{j=1}^k(\lambda_j(A)+\lambda_j(B))$ and $\sum_{j=n-k+1}^n\lambda_j(A+B) \le \sum_{j=n-k+1}^n(\lambda_j(A)+\lambda_j(B))$.*

> **Lemma 3.2.** *Let $a_1\le\cdots\le a_N$ with $\sum_{i=1}^N a_i = 0$. Then for any $1\le k\le N$,*
$$\sum_{i=1}^k a_i \ge -\sqrt{\frac{k(N-k)}{N}}\Bigl(\sum_{i=1}^N a_i^2\Bigr)^{1/2}.$$
*Equality iff $a_1=\cdots=a_k=-(N-k)$ and $a_{k+1}=\cdots=a_N=k$ (up to scale), or all $a_i=0$.* Proof by Cauchy–Schwarz on the first $k$ and last $N-k$ terms separately. This is the inequality that converts a Weyl-norm bound into an eigenvalue bound; the traceless-ness of $\mathcal W$ is what supplies $\sum a_i = 0$.

> **Proposition 3.3.** *For compact $(M,g)$ of dimension $n\ge4$ with eigenvalues $\mu_1\le\cdots\le\mu_N$ of $\mathcal R$, $N=\frac{n(n-1)}2$: if $\mathrm{Ric}_k\ge ka$ then $\sum_{i=1}^k\mu_i \ge ka - \sqrt{\frac{k(N-k)}{N}}\,|W_g|$*, with the mirrored upper bound for $\mathrm{Ric}_k\le ka$.

> **Corollary 3.4.** *With $\sec_g\ge a>0$ (resp. $\le -a<0$) and $|W_g| < \sqrt{\frac{kN}{N-k}}\,a$, the curvature operator is $k$-positive (resp. $k$-negative).*

> **Proposition 4.4** (the scalar-curvature form of the estimate). *For compact $(M,g)$ of dimension $n\ge4$, the sum of the smallest $k$ eigenvalues of $\mathcal R$ satisfies*
$$\sum_{i=1}^k \mu_i \ \ge\ \frac{kR_g}{n(n-1)} - \sqrt{\frac{k(N-k)}{N}}\Bigl(\frac1{n-2}|\mathring{\mathrm{Ric}}_g| + |W_g|\Bigr),\qquad N=\tfrac{n(n-1)}2 .$$

## The integral-pinching vanishing theorems

> **Theorem 1.4.** *Let $(M,g)$ be compact of dimension $n\ge3$ with $\mathrm{Ric}_k \ge ka > 0$ for some $1\le k\le n-1$. If*
$$\Bigl(\frac{\int_M |W_g|^{n/2}}{\mathrm{Vol}(g)}\Bigr)^{2/n} \ < \ \sqrt{\frac{kN}{N-k}}\ \frac{n-2}{n}\,a,\qquad N=\tfrac{n(n-1)}2,$$
*then (1) for $1\le k\le\lceil n/2\rceil$, $b_p(M)=0$ for all $1\le p\le n-1$; (2) for $\lceil n/2\rceil+1\le k\le n-1$, $b_1(M)=\cdots=b_{n-k}(M)$.*

> **Remark 1.5**: the $L^{n/2}$-norm of $W_g$ is conformally invariant, and $[a\,\mathrm{Vol}(g)]^{2/n} \le \frac{\lambda(g)}{n(n-1)} \le [\mathrm{Vol}(S^n)]^{2/n}$ with $\lambda(g)$ the Yamabe constant (Proposition 4.2).

> **Theorem 1.6.** *Let $(M,g)$ be compact of dimension $n\ge8$ with positive Yamabe constant $\lambda(g)$ and $1\le k\le n-1$. If*
$$\Bigl(\int_M \bigl(\tfrac1{n-2}|\mathring{\mathrm{Ric}}_g| + |W_g|\bigr)^{n/2}\Bigr)^{2/n} < \frac{\lambda(g)}{n(n-1)}\sqrt{\frac{Nk}{N-k}},$$
*then (1) for $1\le k\le\lceil n/2\rceil$, $b_p(M)=0$ for all $1\le p\le\lceil n/2\rceil-2$; (2) for $\lceil n/2\rceil+1\le k\le n-1$, $b_p(M)=0$ for all $1\le p\le\min\{\lceil n/2\rceil-2,\,n-k\}$.*

> **Corollary 1.7** is the same statement with $R_g>0$ and $n\ge4$, under a constant differing by $\frac{n-2}{n^2(n-1)}\sqrt{k(N-k)/N}\,\lambda(g)$; conclusions are $b_p(M)=0$ for $1\le p\le n-1$, resp. $1\le p\le n-k$.

> **Remark 1.8** records the concircular curvature tensor $Z_g := \frac1{n-2}\mathring{\mathrm{Ric}}_g\odot g + W_g$ of Hebey–Vaugon [25], with $|Z_g|^2 = \frac4{n-2}|\mathring{\mathrm{Ric}}_g|^2 + |W_g|^2$ and $|Z_g| \ge \frac{2}{\sqrt5}\bigl(\frac1{n-2}|\mathring{\mathrm{Ric}}_g| + |W_g|\bigr)$.

## Betti-number and gap results

> **Theorem 3.5.** *Let $(M,g)$ be compact of dimension $n\ge4$ with $\mathrm{Ric}_k - \sqrt{\frac{k(N-k)}{N}}|W_g| \ge ka$ and $\mathrm{diam}(M)\le D$, where $\lceil n/2\rceil\le k\le n-1$. Then there is $C(n,aD^2)>0$ with*
$$b_p(M) \le \binom np \exp\Bigl(C(n,aD^2)\sqrt{-aD^2\,p(n-p)}\Bigr),\qquad 1\le p\le n-k,$$
*and $b_p(M)\le\binom np$ once $aD^2 \ge -\varepsilon(n)$.* Proof routes through [45, Lem. 2.1] and [45, Thm. 1.9] (Petersen–Wink).

> **Theorem 3.6.** *Let $(M,g)$ be compact of even dimension $2n$, $n\ge2$, with $b_1(M)\ge1$. There is $\varepsilon(n)>0$ such that if*
$$\Bigl(\mathrm{Ric}_n - \sqrt{\tfrac{n(n-3)}{n-1}}\,|W_g|\Bigr)\mathrm{diam}^2(M) \ \ge\ -\varepsilon(n),$$
*then $\chi(M)=0$.* Via Huang–Tan [27, Thm. 1.1].

> **Theorem 1.9** (gap results, harmonic Weyl curvature $\mathrm{div}\,W_g=0$, $n\ge4$). *(1) If $\mathrm{Ric}_k\ge ka>0$ for some $1\le k\le\lfloor\frac{n-1}2\rfloor$, then unless $W_g=0$,*
$$\Bigl(\frac{\int_M|W_g|^{n/2}}{\mathrm{Vol}(g)}\Bigr)^{2/n} \ \ge\ \min\Bigl\{\sqrt{\tfrac{Nk}{N-k}}\,a,\ \sqrt{\tfrac{n(n-2)}{8(n-1)}}\sqrt{\tfrac{Nk}{N-k}}\,a\Bigr\}.$$
*(2) If $\lambda(g)>0$ and $n\ge8$, then unless $W_g=0$,*
$$\Bigl(\int_M\bigl(\tfrac1{n-2}|\mathring{\mathrm{Ric}}_g|+|W_g|\bigr)^{n/2}\Bigr)^{2/n} \ \ge\ \frac{1}{\sqrt{2n(n-1)}}\,\lambda(g).$$

> **Corollary 2.11** (locally conformally flat, $n\ge3$): if $(\lambda_1+2\lambda_2+\lambda_3) - \frac2{n-2}R_g$ is quasi-positive, then $M$ is diffeomorphic to a spherical space form; for $n=4$ or $6$, conformally equivalent to the round sphere. Via Böhm–Wilking [3] and Ni–Wu [38, Cor. 2.3].

## What it cites, for the record

Petersen–Wink [45] for the $k$-positivity vanishing theorems (their Theorem A, Lemma 2.1, Theorem 1.9), this is the load-bearing external input for every Betti-number conclusion. Meyer [42] for rational homology spheres under $\mathcal R\succ0$; Hebey–Vaugon [25] for the concircular tensor and its integral pinching; Tachibana [53] and Brendle [6] for the Einstein rigidity ancestry; Tran [55] for Bochner–Weitzenböck–Lichnerowicz formulae for the Weyl tensor in dimension $>4$; Huang–Tan [27] for Theorem 3.6; Böhm–Wilking [3] and Ni–Wu [38] for Corollary 2.11; Li [37] and Gallot [17] for the diameter-dependent Betti bounds; Bhatia [1] for Ky Fan.

## Bearing on this project

The mechanism throughout is global: a Weitzenböck/Bochner argument on a compact manifold, consuming $\nabla$, integration, the Sobolev and Yamabe constants, and the diameter. The purely algebraic content is Theorem 1.1 (the diagonal/off-diagonal split of $\mathcal R$ in the Ricci eigenbasis) plus Lemmas 3.1 and 3.2 (Ky Fan plus a Cauchy–Schwarz bound on the lowest $k$ eigenvalues of a traceless operator). None of it produces an identity or inequality for the cubic $\langle R, R^2+R^\#\rangle$, and the eigenvalue estimates are all first-order in $\mathcal W$.
