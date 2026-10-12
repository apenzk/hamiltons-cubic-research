# I73 sub-step (c): the projected pair quotient in closed form, and what it does to R33

*Working note, derived 2026-09-23 at the raised effort level the user reported. Recorded as [Lemma L234](../findings/second-order.md), Gate 2 by [r1093](REVIEW_r1093.md) and [r1094](REVIEW_r1094.md), who confirmed every step and corrected the R33 conclusion, repaired below.*

## Statement

Let $n\ge5$, let $e$ be ANY element of $\mathcal W_n$ (criticality, unit norm and the eigenvector hypothesis are all inert), let $u,v\in\Lambda^2$ be orthonormal with matrices $U,V$, and put $Y_0=u\odot v=\tfrac12(u\otimes v+v\otimes u)$, $X=\pi_{\mathcal W_n}Y_0$, $N=Y_0-X$. In the four-tensor convention $R_{ijkl}=\langle\varphi_{ij},R\varphi_{kl}\rangle$, set

$$h=\operatorname{Ric}(Y_0)=-\tfrac12(UV+VU),\qquad \omega_{ijkl}=(Y_0)_{[ijkl]}=u_{[ij}v_{kl]},$$
$$\langle h,\mathring e h\rangle=\sum e_{ijkl}h_{ik}h_{jl},\qquad \langle\omega,e\diamond\omega\rangle=\sum e_{ijkl}\,\omega_{ijab}\,\omega_{klab}.$$

Then

$$\boxed{\ \langle X,e\circ X\rangle=\langle Y_0,e\circ Y_0\rangle-\frac1{2(n-2)}\langle h,\mathring eh\rangle-\frac38\langle\omega,e\diamond\omega\rangle\ }$$
$$\lVert X\rVert^2=\tfrac12-\frac{\lvert h\rvert^2}{n-2}-\lVert\omega\rVert^2_{\mathrm{op}},$$

and the first term on the right is [L233](../findings/second-order.md#lemma-l233-the-pair-directions-second-order-quotient-and-where-its--content-actually-lives)'s, $\tfrac12\big[\tfrac12(\langle u,eu\rangle+\langle v,ev\rangle)-\tfrac12\langle[u,v],e[u,v]\rangle\big]$.

## Derivation

**Step 1, the split.** $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric on self-adjoint operators (the first-variation derivation in [second-order.md](../findings/second-order.md), step 5). And $e\circ Z\in\mathcal W_n$ for $e,Z\in\mathcal W_n$, the polarisation of $Q(\mathcal W_n)\subseteq\mathcal W_n$, the classical fact that $Q$ preserves first Bianchi and Ricci-flatness. **That fact is the one input not on file**, and [second-order.md](../findings/second-order.md) says so in its own words. With $N\perp\mathcal W_n$ it gives $\langle N,e\circ X\rangle=0$, so
$$\langle X,e\circ X\rangle=\langle Y_0,e\circ X\rangle=\langle Y_0,e\circ Y_0\rangle-\langle Y_0,e\circ N\rangle=\langle Y_0,e\circ Y_0\rangle-\langle N,e\circ N\rangle,$$
the last step using $\langle X,e\circ N\rangle=\langle N,e\circ X\rangle=0$.

**Step 2, $N$ has two parts and they do not interact.** $\mathrm{Sym}^2\Lambda^2=\mathcal W_n\oplus\{k\owedge g\}\oplus\Lambda^4$, and $\operatorname{scal}(Y_0)\propto\langle u,v\rangle=0$, so $N=N_r+N_4$ with $N_r=h\owedge g/(n-2)$, since $\operatorname{Ric}(k\owedge g)=(n-2)k$ at traceless $k$, and $N_4=\omega$. The cross term $\langle N_r,e\circ N_4\rangle=\langle e,N_r\circ N_4\rangle$ is an equivariant bilinear map $S^2_0\times\Lambda^4\to\mathcal W_n$. Its only candidate is one contraction, $W_{abcd}k_{ed}$ antisymmetrised over $a,b,c,e$, and antisymmetrising over $a,b,c$ first gives $W_{[abc]d}=0$ by Bianchi. **So the cross term vanishes.**

**Step 3, the Ricci constant.** $\langle N_r,e\circ N_r\rangle=\langle e,Q(N_r)\rangle$. Only the Weyl part of $Q(k\owedge g)$ pairs with $e$, and it is an equivariant quadratic in $k$, so it is proportional to $W(k\owedge k)$, and one diagonal $k$ fixes the constant. There $K=k\owedge g$ is diagonal on $\Lambda^2$ with entries $k_i+k_j$, and the diagonal $R^\#$ formula $(R^\#)_{ij}=\sum_{m\ne i,j}r_{im}r_{jm}$ with $\sum k_m=0$ gives
$$Q(K)=\tfrac{n-2}2\,k\owedge k-k^2\owedge g+\tfrac12\lvert k\rvert^2 g\owedge g .$$
So the Weyl part of $Q(k\owedge g)$ is $\tfrac{n-2}2W(k\owedge k)$ at every $k$, by equivariance, and with $\langle e,k\owedge k\rangle_{\mathrm{op}}=\sum e_{ijkl}k_{ik}k_{jl}$ the Ricci term is $\frac1{(n-2)^2}\cdot\frac{n-2}2\langle h,\mathring eh\rangle$. $\lVert N_r\rVert^2=\lvert h\rvert^2/(n-2)$ follows from $\lVert k\owedge g\rVert^2_{\mathrm{op}}=(n-2)\lvert k\rvert^2$.

**Step 4, the $\Lambda^4$ constant.** $\operatorname{Hom}(S^2\Lambda^4,\mathcal W_n)^{O(n)}$ has one generator, the two-contraction $\omega_{ijab}\omega_{klab}$, so $\langle e,Q(\omega)\rangle=\gamma\langle\omega,e\diamond\omega\rangle$ and one $\omega$ fixes $\gamma$. At $\omega=s\,\mathrm{vol}_B$ on a four-block $B$: $\omega^2=s^2\Pi_B$, and $\omega^\#=2s^2\Pi_B$, because $\omega=s(\Pi_+-\Pi_-)$ on $\Lambda^2B=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$, the two factors bracket to zero, and $\Pi_\pm^\#=2\Pi_\pm$ from $\mathrm{id}_B^\#=2\,\mathrm{id}_B$. So $\langle e,Q(\omega)\rangle=3s^2\operatorname{tr}(e\vert_{\Lambda^2B})$, while $\sum_{ab}\omega_{ijab}\omega_{klab}=2s^2(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})_B$ gives $\langle\omega,e\diamond\omega\rangle=8s^2\operatorname{tr}(e\vert_{\Lambda^2B})$. **Hence $\gamma=\tfrac38$.** At $n=5$ both sides vanish identically, since $\Lambda^4\cong\Lambda^1$ and $S^2\Lambda^1$ carries no Weyl component. $\square$

## Corollary: the four-symbol law, at every Weyl $e$

For a disjoint coordinate pair $u=\varphi_{ab}$, $v=\varphi_{cd}$: $UV=VU=0$ so $h=0$, and $\omega\cdot\omega$ is diagonal, equal to $\tfrac1{18}$ on each of the six planes of $S=\{a,b,c,d\}$ and zero elsewhere, with $\lVert\omega\rVert^2_{\mathrm{op}}=\tfrac16$. So $\langle\omega,e\diamond\omega\rangle=\tfrac29\operatorname{tr}(e\vert_{\Lambda^2S})$, $\lVert X\rVert^2=\tfrac13$, and with $e_P=\langle\varphi_P,e\varphi_P\rangle$,
$$\frac{\langle X,e\circ X\rangle}{\lVert X\rVert^2}=\tfrac12(e_{ab}+e_{cd})-\tfrac14(e_{ac}+e_{ad}+e_{bc}+e_{bd}).$$
**This is [r1091](REVIEW_r1091.md)'s screened law, derived, and at every Weyl $e$ rather than only the coordinate-diagonal ones it was screened at.** At a two-block sphere product it gives $\mu$ across the blocks and $0$ inside one, the first two rows of sub-step (a).

## Consequence for R33

At a maximiser, [L125](../findings/second-order.md) applied to $X$ reads
$$\tfrac12\cdot\mathrm{L233}(u,v)-\tfrac14\ \le\ \frac1{2(n-2)}\langle h,\mathring eh\rangle+\frac38\langle\omega,e\diamond\omega\rangle-\tfrac12\Big(\frac{\lvert h\rvert^2}{n-2}+\lVert\omega\rVert^2_{\mathrm{op}}\Big).$$
The left side is linear in $T$ with $\lambda$-coefficients. **The right side is not a function of the pair's $(\lambda,T)$ data**, and here is the witness. At padded $W_{\mathbb{CP}^2}$, $n=8$, the pairs $(\varphi_{45},\varphi_{67})$, $(\varphi_{04},\varphi_{15})$ and $(\varphi_{04},\varphi_{25})$ all lie in $e$'s $0$-eigenspace, all commute (so every $T_{\alpha\beta\gamma}$ of the pair vanishes), and all have unprojected numerator $0$ and $\lVert X\rVert^2=\tfrac13$. By the corollary, with $e_{01}=\tfrac13$ and $e_{02}=-\tfrac16$ there, their projected quotients are $0$, $-\tfrac1{12}$ and $+\tfrac1{24}$.

**So the pair inequality is NON-LOCAL in $(\lambda,T)$**: no function of the pair's own row can carry it. *It is not outside the calculus*: the whole squared tensor separates the three pairs, $\sum\lambda_\gamma T_{\gamma\beta\delta}T_{\delta\alpha\varepsilon}$ being $0,\tfrac13,-\tfrac16$, $-4$ times the quotients ([r1094](REVIEW_r1094.md)), and $e_{01}$, $e_{02}$ are $\lambda$-weighted $T$-rows of neighbouring pairs ([r1093](REVIEW_r1093.md)). **Sub-step (c) therefore needs row-coupling terms, and whether the quotient is a function of the squared $T$ in general is open.** *A first version of this paragraph said (c) could not run inside the pinned calculus at all, which the witness does not show.*

## Screens run (seconds, objects constructed for the purpose)

All in [screen_I73_projected_split.py](../scripts/misc/screen_I73_projected_split.py):

| check | result |
|---|---|
| split identity, eigenpairs of random $W\in\mathcal W_n$, $n=5,6,7$ | residual $\le3\cdot10^{-15}$ |
| Ricci and $\Lambda^4$ cross term | $\le4\cdot10^{-16}$ |
| Ricci constant against $\frac1{2(n-2)}$, $n=5\ldots8$ | exact to $10^{-12}$ |
| $\Lambda^4$ constant against $\tfrac38$, $n=6,7,8$, and both sides zero at $n=5$ | exact, and $\le7\cdot10^{-17}$ at $n=5$ |
| four-symbol law at a generic non-diagonal Weyl $e$, $n=5,6,7$ | $\le3\cdot10^{-16}$ |
| the three witness pairs at padded $W_{\mathbb{CP}^2}$, $n=8$ | $0$, $-\tfrac1{12}$, $+\tfrac1{24}$ |

## Owed after the effort drop

- Gate 2, two reviewers: new mathematics, and it refutes a route premise.
- **Lean**: step 3's diagonal identity is `diag_Q_kg` in [I73ProjectedPair.lean](../lean/HamiltonsCubic/Results/I73ProjectedPair.lean). The split and the $\Lambda^4$ constant are blocked on two absences a grep confirms: no orthogonal projection onto $\mathcal W_n$ and no theorem concluding `IsWeyl (Qop _)`.
- Recording: a block in [second-order.md](../findings/second-order.md) beside L233, R33's row in [routes.md](../routes.md), and I73's grade in [plan.md](../plan.md). `attackable` falls, since the registered instrument is gone.
