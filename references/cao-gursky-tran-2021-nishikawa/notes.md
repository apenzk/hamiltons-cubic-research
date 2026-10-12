# Cao–Gursky–Tran, Curvature of the second kind and a conjecture of Nishikawa

Transcribed from [cgt-2112.01212.pdf](https://arxiv.org/abs/2112.01212), arXiv:2112.01212v1 [math.DG], dated 2 Dec 2021, 18 pages. Section and equation numbers below are the paper's own.

## Conventions (§1, §2.1)

$V$ is an $n$-dimensional real inner product space and $R:\otimes^4 V\to\mathbb R$ an algebraic curvature tensor. The space of bilinear forms splits as $T_2(V)=S^2(V)\oplus\Lambda^2(V)$, and $R$ induces two maps. The **first kind** is $\mathcal R:\Lambda^2(V)\to\Lambda^2(V)$,

$$\mathcal R(e^i\wedge e^j)=\tfrac12\sum_{k,\ell}R_{ijk\ell}\,e^k\wedge e^\ell.\tag{1.1}$$

The **second kind** is $\hat R:S^2(V)\to S^2(V)$,

$$\hat R(e^i\odot e^j)=\sum_{k,\ell}R_{ik\ell j}\,e^k\odot e^\ell.\tag{1.2}$$

$S^2(V)=S^2_0(V)\oplus\mathrm{Id}$, and $\hat R$ induces a bilinear form on $S^2_0$ by restriction. Nishikawa named $\hat R$ the curvature operator of the second kind, against $\mathcal R$ the first kind ([19], and [3]). **$\hat R>0$ (resp. $\ge0$) means the eigenvalues of $\hat R$ as a bilinear form on $S^2_0(V)$ are positive (resp. non-negative)**; the paper notes $\hat R>0$ implies positive sectional curvature.

The $k$-positivity convention is stated in §2.1: "We say that the (Riemannian) curvature operator of the second kind $\hat R$ is $k$-positive (non-negative) if the sum of any $k$ eigenvalues of $\hat R|_{S^2_0}$ is positive (non-negative)." **The thresholds throughout the paper are counts of eigenvalues, not dimensions.**

Products: $e^i\odot e^j=e^i\otimes e^j+e^j\otimes e^i$ and $e^i\wedge e^j=e^i\otimes e^j-e^j\otimes e^i$, with $\langle u,v\rangle=\mathrm{Tr}(u^Tv)$ on $S^2$ and $\tfrac12\mathrm{Tr}(u^Tv)$ on $\Lambda^2$. The Kulkarni–Nomizu product is $(A\circ B)_{ijk\ell}=A_{ik}B_{j\ell}+A_{j\ell}B_{ik}-A_{i\ell}B_{jk}-A_{jk}B_{i\ell}$, and $E$ is the traceless Ricci tensor. The identification $\hat T$ of $T\in\mathcal R(V)$ with an element of $\mathrm{End}(S^2)$ is $(\hat TA)(e_i,e_k)=\sum_{j,l}T(e_i,e_j,e_l,e_k)A(e_j,e_l)$.

## The conjecture

> **Conjecture 1.1.** Let $(M,g)$ be a closed, simply connected Riemannian manifold. If $\hat R\ge0$ then $M$ is diffeomorphic to a Riemannian locally symmetric space. If the inequality is strict, then $M$ is diffeomorphic to a round sphere.

The paper records the prior state: in dimension three $\hat R\ge0$ implies $Rc\ge\frac S6$, so the positive case follows from Hamilton [14]; in all dimensions $\hat R>0$ makes $M$ a real homology sphere [20]; under extra conditions such as harmonic curvature the conjecture holds [15] (Kashiwada).

## The main theorems

> **Theorem 1.2.** Let $(M,g)$ be a closed Riemannian manifold such that $\hat R$ is two-positive (i.e., the sum of the smallest two eigenvalues of $\hat R$ is positive). Then $M$ is diffeomorphic to a spherical space form.

> **Definition 1.3.** $(M,g)$ satisfies the PIC1 condition if for any orthonormal frame $\{e_1,e_2,e_3,e_4\}$ we have
> $$R_{1313}+\lambda^2R_{1414}+R_{2323}+\lambda^2R_{2424}-2\lambda R_{1234}>0\quad\text{for all }\lambda\in[0,1].\tag{1.3}$$
> If the quantity in (2.4) is non-negative for any orthonormal frame, then we say that $(M,g)$ satisfies the NIC1 condition.

> **Theorem 1.4.** Let $(M,g)$ be a Riemannian manifold of dimension $n\ge4$ for which $\hat R$ is two-positive (resp., two-non-negative). Then $(M,g)$ satisfies PIC1 (resp. NIC1).

> **Theorem 1.5.** Let $(M,g)$ be a Riemannian manifold of dimension $n\ge4$ for which $\hat R$ is four-positive (respectively, four-non-negative). Then $(M,g)$ satisfies PIC (resp., non-negative isotropic curvature).

> **Theorem 1.6.** Let $(M,g)$ be a simply connected Riemannian manifold of dimension $n\ge4$ for which $\hat R$ is four-positive. Then $(M,g)$ is homeomorphic to $S^n$.

> **Theorem 1.7.** Let $(M,g)$ be a compact Einstein manifold of dimension $n\ge4$. If $\hat R$ is four-positive, then $(M,g)$ has constant sectional curvature. If $\hat R$ is four-non-negative, then $(M,g)$ is locally symmetric.

Theorem 1.2 is deduced from Theorem 1.4 plus Brendle's convergence theorem; Theorem 1.6 from Theorem 1.5 plus Micallef–Moore [16]; Theorem 1.7 from Theorem 1.5 plus Brendle [5] (Micallef–Wang [17] in dimension four).

> **Theorem 1.8.** Let $(M^4,g)$ be a closed, oriented four-manifold. Then there is a basis of $S^2_0(TM^4)$ with respect to which the matrix of $\hat R$ is given by
> $$\hat R=\begin{pmatrix}D_1&O_1&O_2\\-O_1&D_2&O_3\\-O_2&-O_3&D_3\end{pmatrix},\tag{1.5}$$
> and the $D_i$'s are diagonal matrices given by
> $$D_i=\mathrm{diag}\Big(-4(\lambda_i+\mu_1)+\tfrac13S,\;-4(\lambda_i+\mu_2)+\tfrac13S,\;-4(\lambda_i+\mu_3)+\tfrac13S\Big),\tag{1.6}$$
> where $\{\lambda_1,\lambda_2,\lambda_3\}$ are the eigenvalues of $W^+$, and $\{\mu_1,\mu_2,\mu_3\}$ are the eigenvalues of $W^-$. Moreover, $O_1,O_2,O_3$ are skew-symmetric $3\times3$ matrices which vanish if and only if $(M^4,g)$ is Einstein.

> **Theorem 1.9.** Let $(M,g)$ be a simply connected Einstein four-manifold such that $\hat R$ is five-non-negative. Then $(M^4,g)$ is isometric, up to rescaling, to either the round sphere or complex projective space with the Fubini-Study metric.

## Background results the paper imports (§2)

> **Proposition 2.1** (Berger [1]). Let $(M,g)$ be a four-manifold. At each point $p\in M$, there exists an orthonormal basis $\{e_i\}_{1\le i\le4}$ of $T_pM$, such that relative to the corresponding basis $\{e_i\wedge e_j\}_{1\le i<j\le4}$ of $\wedge^2T_pM$, $W$ takes the form $\mathcal W=\begin{pmatrix}A&B\\B&A\end{pmatrix}$, where $A=\mathrm{Diag}\{a_1,a_2,a_3\}$, $B=\mathrm{Diag}\{b_1,b_2,b_3\}$. Moreover: (1) $a_1=W(e_1,e_2,e_1,e_2)=W(e_3,e_4,e_3,e_4)=\min_{|a|=|b|=1,\,a\perp b}W(a,b,a,b)$; (2) $a_3=W(e_1,e_4,e_1,e_4)=\max_{|a|=|b|=1,\,a\perp b}W(a,b,a,b)$; (3) $a_2=W(e_1,e_3,e_1,e_3)=W(e_2,e_4,e_2,e_4)$; (4) $b_1=W_{1234}$, $b_2=W_{1342}$, $b_3=W_{1423}$; (5) $a_1+a_2+a_3=b_1+b_2+b_3=0$; (6) $|b_2-b_1|\le a_2-a_1$, $|b_3-b_1|\le a_3-a_1$, $|b_3-b_2|\le a_3-a_2$.

> **Definition 2.2.** $(M,g)$ is said to have non-negative isotropic curvature if, for any orthonormal frame $\{e_1,e_2,e_3,e_4\}$ we have $R_{1313}+R_{1414}+R_{2323}+R_{2424}-2R_{1234}\ge0$. If the inequality is strict then it is said to have positive isotropic curvature.

> **Lemma 2.3** ([16]). In dimension four, non-negative isotropic curvature is equivalent to $-\mathcal W^\pm+\frac S{12}\mathrm{Id}\ge0$, as a bilinear form on $\Lambda^2_\pm$.

> **Definition 2.4.** $(M,g)$ is said to be NIC1 if for any orthonormal frame $\{e_1,e_2,e_3,e_4\}$ we have $R_{1313}+\lambda^2R_{1414}+R_{2323}+\lambda^2R_{2424}-2\lambda R_{1234}\ge0$ for all $\lambda\in[0,1]$. If the inequality is strict then $(M,g)$ is said to be PIC1.

> **Definition 2.5.** $(M,g)$ is said to be NIC2 if for any orthonormal frame $\{e_1,e_2,e_3,e_4\}$ we have $R_{1313}+\lambda^2R_{1414}+\mu^2R_{2323}+\lambda^2\mu^2R_{2424}-2\lambda\mu R_{1234}\ge0$ for all $\lambda,\mu\in[0,1]$. If the inequality is strict then $(M,g)$ is said to be PIC2.

> **Theorem 2.6** ([4]). Let $(M,g)$ be a Riemannian manifold satisfying the PIC1 condition. Then the normalized Ricci flow exists for all time and converges to a constant curvature metric as $t\to\infty$. In particular, the manifold is diffeomorphic to a spherical space form.

## The proofs that matter (§3)

**Both proofs are purely algebraic and pointwise**: a finite list of explicit trace-free symmetric two-tensors is fed to $\hat R$, the resulting quadratic forms are summed, and the first Bianchi identity converts the sum into the isotropic-curvature expression. No flow, no integration, no Bochner formula appears in §3.

### Theorem 1.4 (two-positive $\Rightarrow$ PIC1)

Fix $p$ and an orthonormal basis $\{e^1,\dots,e^n\}$ of $T^*_pM$. Set $h_1=e^1\odot e^3+\lambda e^2\odot e^4$ and $h_2=e^2\odot e^3-\lambda e^1\odot e^4$; these are orthogonal in $S^2$, so two-positivity gives $0<\hat R(h_1,h_1)+\hat R(h_2,h_2)$. The paper computes

$$\hat R(h_1,h_1)=2\big(2\lambda R_{1243}+R_{1313}+2\lambda R_{1423}+\lambda^2R_{2424}\big),$$
$$\hat R(h_2,h_2)=2\big(-2\lambda R_{1234}-2\lambda R_{1324}+\lambda^2R_{1414}+R_{2323}\big),$$

whose sum, after the first Bianchi identity, is

$$0<(R_{1313}+R_{2323})+\lambda^2(R_{1414}+R_{2424})-6\lambda R_{1234}.\tag{3.1}$$

Interchanging $e_1$ and $e_2$, with $h_3=e^2\odot e^3+\lambda e^1\odot e^4$ and $h_4=e^1\odot e^3-\lambda e^2\odot e^4$, and $\hat R(h_3,h_3)=2(R_{2323}+\lambda^2R_{1414}+2\lambda R_{1324}+2\lambda R_{2143})$, $\hat R(h_4,h_4)=2(R_{1313}+\lambda^2R_{2424}-2\lambda R_{1423}-2\lambda R_{2134})$, gives

$$0<(R_{1313}+R_{2323})+\lambda^2(R_{1414}+R_{2424})-6\lambda R_{2134}.\tag{3.2}$$

From (3.1) and (3.2), $R_{1313}+R_{2323}+\lambda^2R_{1414}+\lambda^2R_{2424}>|6\lambda R_{1234}|$, which is stronger than the PIC1 inequality $R_{1313}+R_{2323}+\lambda^2R_{1414}+\lambda^2R_{2424}+2\lambda R_{1234}>0$ of Definition 2.4. **Theorem 1.2 is then one line**: PIC1 by Theorem 1.4, then Theorem 2.6.

### Theorem 1.5 (four-positive $\Rightarrow$ PIC)

The six mutually orthogonal, equal-magnitude tensors are
$$h_1=\tfrac12(-e^1\odot e^1-e^2\odot e^2+e^3\odot e^3+e^4\odot e^4),\quad h_2=e^1\odot e^4-e^2\odot e^3,\quad h_3=-e^1\odot e^3-e^2\odot e^4,$$
$$h_4=-e^1\odot e^4-e^2\odot e^3,\quad h_5=\tfrac12(-e^1\odot e^1+e^2\odot e^2-e^3\odot e^3+e^4\odot e^4),\quad h_6=\tfrac12(-e^1\odot e^1+e^2\odot e^2+e^3\odot e^3-e^4\odot e^4).$$

Four-positivity applied to $\{h_1,h_2,h_4,h_5\}$, with
$$\hat R(h_1,h_1)=2(-R_{1212}-R_{3434}+R_{1313}+R_{1414}+R_{2323}+R_{2424}),\qquad \hat R(h_2,h_2)=2(R_{1414}+R_{2323}+2R_{1243}+2R_{1342}),$$
$$\hat R(h_4,h_4)=2(-2R_{1243}-2R_{1342}+R_{1414}+R_{2323}),\qquad \hat R(h_5,h_5)=2(-R_{1313}-R_{2424}+R_{1414}+R_{2323}+R_{1212}+R_{3434}),$$
yields
$$0<R_{1414}+R_{2323}.\tag{3.3}$$

Applied instead to $\{h_1,h_2,h_3,h_6\}$, with $\hat R(h_3,h_3)=2(-2R_{1234}-2R_{1432}+R_{1313}+R_{2424})$ and $\hat R(h_6,h_6)=2(-R_{1414}-R_{2323}+R_{1313}+R_{1212}+R_{3434}+R_{2424})$, the first Bianchi identity gives
$$0<3(R_{1313}+R_{2424})+(R_{1414}+R_{2323})-6R_{1234}.\tag{3.4}$$

Adding (3.4) and twice (3.3): $0<3(R_{1313}+R_{1414}+R_{2323}+R_{2424}-2R_{1234})$, which is PIC since the four-tuple was arbitrary.

## Dimension four: the matrix of $\hat R$ (§4)

Bases of $\Lambda^2_\pm(T_pM^4)$ with $|\omega^\alpha|^2=|\eta^\beta|^2=2$:
$$\omega^1=e^1\wedge e^2+e^3\wedge e^4,\quad \omega^2=e^1\wedge e^3-e^2\wedge e^4,\quad \omega^3=e^1\wedge e^4+e^2\wedge e^3,\tag{4.1}$$
$$\eta^1=e^1\wedge e^2-e^3\wedge e^4,\quad \eta^2=e^1\wedge e^3+e^2\wedge e^4,\quad \eta^3=e^1\wedge e^4-e^2\wedge e^3.\tag{4.2}$$

With $\mathcal W=\mathrm{diag}(A+B,\,A-B)$ from Proposition 2.1, the eigenvalues are ordered as $\lambda_1=a_1+b_1\le\lambda_2=a_2+b_2\le\lambda_3=a_3+b_3$ and $\mu_1=a_1-b_1\le\mu_2=a_2-b_2\le\mu_3=a_3-b_3$ (4.4).

> **Proposition 4.1** (excerpted from Derdziński [12], based on Singer–Thorpe [21]). Let $(M^4,g)$ be an oriented, four-dimensional Riemannian manifold, $p\in M^4$. (i) There is an orthogonal basis of $\Lambda^2_+$ (resp. $\Lambda^2_-$) consisting of eigenforms $\{\omega^1,\omega^2,\omega^3\}$ (resp. $\{\eta^1,\eta^2,\eta^3\}$) of $W^+$ (resp. $W^-$) of the form (4.1) (resp. (4.2)) for some choice of basis $\{e^1,\dots,e^4\}$ of $T^*_pM^4$. (ii) With respect to these bases $W_{ijk\ell}=\frac12(\lambda_1\omega^1_{ij}\omega^1_{k\ell}+\lambda_2\omega^2_{ij}\omega^2_{k\ell}+\lambda_3\omega^3_{ij}\omega^3_{k\ell})+\frac12(\mu_1\eta^1_{ij}\eta^1_{k\ell}+\mu_2\eta^2_{ij}\eta^2_{k\ell}+\mu_3\eta^3_{ij}\eta^3_{k\ell})$ (4.5), with $\lambda_1+\lambda_2+\lambda_3=0$ and $\mu_1+\mu_2+\mu_3=0$ (4.6). (iii) The bases have a quaternionic structure: $[(\omega^\alpha)^2]_{ij}=[(\eta^\alpha)^2]_{ij}=-\delta_{ij}$ (4.7), with $\omega^1\omega^2=-\omega^3$, $\omega^1\omega^3=\omega^2$, $\omega^2\omega^3=-\omega^1$, $\eta^1\eta^2=\eta^3$, $\eta^1\eta^3=-\eta^2$, $\eta^2\eta^3=\eta^1$ (4.8). (iv) They generate an orthogonal basis of $S^2_0(T^*_pX^4)$ by $h^{(\alpha,\beta)}_{ij}=\omega^\alpha_{ik}\eta^\beta_{kj}$ (4.9), with $|h^{(\alpha,\beta)}|=2$.

Relabelled $h^{(1,1)}=h^1,\dots,h^{(3,3)}=h^9$ (4.10).

> **Lemma 4.2.** The basis elements in (4.10) satisfy $(h^\alpha)^2_{ij}=h^\alpha_{ik}h^\alpha_{kj}=\delta_{ij}$, and $h^1h^5=-h^9$, $h^1h^6=h^8$, $h^1h^8=h^6$, $h^1h^9=-h^5$, $h^2h^4=h^9$, $h^2h^6=-h^7$, $h^2h^7=-h^6$, $h^2h^9=h^4$, $h^3h^4=-h^8$, $h^3h^5=h^7$, $h^3h^7=h^5$, $h^3h^8=-h^4$, $h^4h^8=-h^3$, $h^4h^9=h^2$, $h^5h^7=h^3$, $h^5h^9=-h^1$, $h^6h^7=-h^2$, $h^6h^8=h^1$. Every remaining product (marked $*$ in the paper's multiplication table) is a skew-symmetric matrix.

With $\hat W(s,t)=W_{ik\ell j}s_{k\ell}t_{ij}$ (4.11):

> **Proposition 4.3.** The basis in (4.9) diagonalizes the Weyl tensor, interpreted as a symmetric bi-linear form as in (4.11). With respect to this basis the matrix of $W$ is $\hat W=\mathrm{diag}(D_1,D_2,D_3)$ (4.12) with $D_i=\mathrm{diag}(-4(\lambda_i+\mu_1),-4(\lambda_i+\mu_2),-4(\lambda_i+\mu_3))$ (4.13).

The curvature decomposition then gives, for $s,t\in S^2_0$,
$$\hat R(s,t)=\hat W(s,t)+\hat E(s,t)+\tfrac1{12}S\langle s,t\rangle,\qquad \hat E(s,t)=E_{ij}s_{ik}t_{kj}=\langle E,st\rangle.\tag{4.15, 4.16}$$
Writing $E_{ij}=\frac14\epsilon_\gamma h^\gamma_{ij}$ with $\epsilon_\alpha=\langle E,h^\alpha\rangle$ (4.17–4.18):

> **Proposition 4.4.** With respect to the basis in (4.9), the matrix of $\hat E$ is $\hat E=\begin{pmatrix}0&O_1&O_2\\-O_1&0&O_3\\-O_2&-O_3&0\end{pmatrix}$ (4.20), where $O_1=\begin{pmatrix}0&-\epsilon_9&\epsilon_8\\\epsilon_9&0&-\epsilon_7\\-\epsilon_8&\epsilon_7&0\end{pmatrix}$, $O_2=\begin{pmatrix}0&\epsilon_6&-\epsilon_5\\-\epsilon_6&0&\epsilon_4\\\epsilon_5&-\epsilon_4&0\end{pmatrix}$, $O_3=\begin{pmatrix}0&-\epsilon_3&\epsilon_2\\\epsilon_3&0&-\epsilon_1\\-\epsilon_2&\epsilon_1&0\end{pmatrix}$ (4.21–4.23). Moreover, these matrices all vanish if and only if $(M^4,g)$ is Einstein.

The proof of Proposition 4.4 is short and worth recording: the diagonal entries vanish because $(h^\alpha)^2=I$ forces $\hat E(h^\alpha,h^\alpha)=\langle E,I\rangle=\mathrm{tr}\,E=0$; and for $1\le\alpha,\beta\le3$ with $\alpha\ne\beta$ the product $h^\alpha h^\beta$ is skew-symmetric by Lemma 4.2, so $\hat E(h^\alpha,h^\beta)=\langle E,h^\alpha h^\beta\rangle=0$ against the symmetric $E$, killing each diagonal $3\times3$ block. Theorem 1.8 is Propositions 4.3 and 4.4 together with (4.15).

## Einstein four-manifolds (§5)

Normalising $Rc=g$, so $S=4$ and $E\equiv0$, the matrix of $\hat R$ is diagonal and **its eigenvalues are $\frac13-\lambda_i-\mu_j$.**

Proof of Theorem 1.9: five-non-negativity is the three inequalities $0\le\frac53-3\lambda_3-3\mu_3-\lambda_2-\lambda_1-\mu_2-\mu_1$, $0\le\frac53-3\lambda_3-2\mu_3-2\lambda_2-2\mu_2-\mu_1$, $0\le\frac53-2\lambda_3-3\mu_3-2\lambda_2-2\mu_2-\lambda_1$. Using $\sum_i\lambda_i=\sum_i\mu_i=0$ and Proposition 2.1 these reduce to $0\le\frac53-2(\lambda_3+\mu_3)=\frac53-4a_3=\frac53-4W_{1414}=\frac53-4(R_{1414}-\frac13)$, i.e. $R_{1414}\le\frac34$. By the ordering (4.4) the sectional curvature is bounded above by $\frac34$, and [9, Corollary 1.3] (Cao–Tran, *Four-manifolds of pinched sectional curvature*) gives the conclusion.

> **Proposition 5.1.** Let $(M,g)$ be a simply connected Einstein four-manifold with positive scalar curvature. If $\hat R$ is 6-positive then its sectional curvature is bounded above by the Einstein constant. Moreover, the curvature operator (of first kind) is 4-non-negative.

Its proof reduces six-non-negativity to $0\le2-(\lambda_3+\mu_3)+\lambda_1+\mu_1\le2-2a_3+2a_1$, $0\le2+3\lambda_1$, $0\le2+3\mu_1$; the first is $R_{1414}-R_{1212}\le1$, which with $R_{1212}+R_{1313}+R_{1414}=1$ and $R_{1212}\le R_{1313}\le R_{1414}$ gives $R_{1414}\le1$. The eigenvalues of the **first-kind** operator are $\lambda_i+\frac13$ and $\mu_i+\frac13$, so its 4-non-negativity is $0\le\frac43-\lambda_3-\mu_3$, $0\le\frac43+\lambda_1$, $0\le\frac43+\mu_1$, the first again equivalent to $R_{1414}\le1$.

### §5.1 Examples, where the sharpness lives

| model | data | $\hat R$ | conclusion |
| --- | --- | --- | --- |
| $(S^4,g_0)$, round | $W=0$, $S=12$ | $\hat R=4I$ | positive definite |
| $(\mathbb{CP}^2,g_{FS})$ | $W^-\equiv0$, $S=8$, Kähler so $W^+=\mathrm{diag}(\frac16S,\frac1{12}S,\frac1{12}S)$ (5.1, Prop. 2 of [12]) | $\hat R=16\,\mathrm{diag}(-\tfrac12 I_3,\,I_3,\,I_3)$ (5.2) | sum of the four smallest eigenvalues is negative, of the five smallest positive: **5-positive but not 4-positive** |
| $(S^2\times S^2,g_p)$, product | $S=4$, Kähler for both orientations, so (5.1) holds for $W^+$ and $W^-$ | $\hat R=4\,\mathrm{diag}(-1,0,0,0,0,1,1,1,1)$ (5.3) | sum of the five smallest eigenvalues is negative: **not five-non-negative, but six-non-negative** |

$(S^2\times S^2,g_p)$ is therefore the model that makes the hypothesis of Theorem 1.9 sharp, and $(\mathbb{CP}^2,g_{FS})$ the one that makes Theorem 1.7's four-positivity sharp. **Both are single four-dimensional examples with explicit eigenvalue lists; the paper states no family of products of spheres and no dimension-indexed threshold.**

## What the paper cites

Its 22 references are the four-manifold and Ricci-flow literature. The load-bearing ones: Brendle [4] for the PIC1 convergence theorem (= Theorem 2.6), Brendle [5] for Einstein + NIC $\Rightarrow$ locally symmetric, Brendle–Schoen [7] for the $1/4$-pinched differentiable sphere theorem, Böhm–Wilking [2] for two-positive first-kind curvature operators, Micallef–Moore [16] for isotropic curvature and Lemma 2.3, Micallef–Wang [17] in dimension four, Berger [1] for Proposition 2.1, Singer–Thorpe [21] and Derdziński [12] for Proposition 4.1 and (5.1), Cao–Tran [8, 9] for the pinched-sectional-curvature classification closing Theorem 1.9, Nishikawa [19] for the conjecture and the terminology, Kashiwada [15] for the harmonic-curvature case, Ogiue–Tachibana [20] for the real-homology-sphere result, and Mikeš–Rovenski–Stepanov [18] for $\hat R$ as the curvature term of the Lichnerowicz Laplacian.

## Relation to the record's other second-kind sources

The paper is the direct ancestor of [li-2021-nonnegative-second-kind](../li-2021-nonnegative-second-kind/notes.md), which cites it as [CGT21] and improves Theorem 1.2 from two-positivity to three-positivity. **The two secondhand quotations previously held in this folder are now checked against the source**: Li's "two-positive curvature operator of the second kind implies strictly PIC1" is Theorem 1.4 above, and the "four-nonnegative implies nonnegative isotropic curvature" attribution is Theorem 1.5. The Nienhaus–Petersen–Wink attribution, 4-nonnegative Einstein $\Rightarrow$ locally symmetric, 4-positive $\Rightarrow$ constant sectional curvature, is Theorem 1.7.
