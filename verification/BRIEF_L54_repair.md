# Brief, round L54, the repair

**Cold brief for two verifiers on a repaired proof. Every passage is quoted verbatim with its source lines. No prior verdict is included.** *The task is the one a Gate 2 audit performs: the proof below is new text, and it must be attacked before it counts.*

## Passage A, the statement and proof under audit ([findings/bispectral.md](../findings/bispectral.md) lines 476-498)

#### Lemma L54, the two diagonals, and rigidity at $t=2$

*Proof written in full at [ROUND_L54](../verification/ROUND_L54.md), audited there; the statement's earlier argument was a pointer to a numerical check.*

**Statement.** Let $W\in\mathrm{Weyl}_n$, $n\ge4$, act on $\Lambda^2$ as $M$ with $\lVert M\rVert_F=1$ and spectrum $\mu$, and let $\mathring W$ be its curvature operator of the second kind on $S^2_0$ in Li's convention, with spectrum $\omega$. Fix a frame $F$, let $K=K(F)$, $K_{ab}=W_{abab}$, and $t_F=\sum_{a\ne b}K_{ab}^2$. Take the orthonormal basis $\{\varphi_{ab}\}_{a<b}\cup\{\psi_k\}_{k<n}$ of $S^2_0$ with $\varphi_{ab}=(e_a\odot e_b)/\sqrt2$ and $\psi_k=\mathop{\mathrm{diag}}(v_k)$ for an orthonormal **eigenbasis** $\{v_k\}$ of $K$ on $\mathbf1^\perp$, and let $d_\varphi$, $d_\psi$, $d=(d_\varphi,d_\psi)$ be the diagonal entries of $M$ in the pair basis $\{e_a\wedge e_b\}$ and of $\mathring W$ in this basis. Then:

1. $d_\varphi=(K_{ab})_{a<b}$ for both $M$ and the $\varphi$-block of $\mathring W$, the $\psi$-block of $\mathring W$ is diagonal with $d_\psi=-(\text{eigenvalues of }K\text{ on }\mathbf1^\perp)$, and $\sum d_\varphi^2=t_F/2$, $\sum d^2=\tfrac32t_F$.
2. $\mu\succ d_\varphi$ and $\omega\succ d$.
3. $t_F\le2$, with equality exactly when $W$ is coordinate-diagonal in $F$.
4. At $t_F=2$, $\mu=d_\varphi$ and $\omega=d$ as multisets.

**Proof.** *(0) $K\mathbf1=0$*: $\sum_bK_{ab}=\sum_bW_{abab}=\mathrm{Ric}(W)_{aa}=0$, $W$ being Weyl. So $K$ preserves $\mathbf1^\perp$ and the eigenbasis exists.

*(1)* $M_{(ab),(ab)}=W_{abab}$ and $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=W_{abab}$ are [Lemma L52](../findings/bispectral.md#lemma-l52-the-shared-frame-majorization-bound-and-what-its-equality-clause-needs)'s statement. For diagonal traceless $h=\mathop{\mathrm{diag}}(v)$ the quadratic form $\langle\mathring Wh,h\rangle=-v^{\mathsf T}Kv$ is derived under [the SAME wall](../findings/bispectral.md#both-sided-schurhorn-and-the-vertex-matrix-budget-are-the-same-wall); polarising, $\langle\mathring W\mathop{\mathrm{diag}}(u),\mathop{\mathrm{diag}}(v)\rangle=-u^{\mathsf T}Kv$ for $u,v\perp\mathbf1$, so in the eigenbasis the $\psi$-block is $\mathop{\mathrm{diag}}(-\kappa_k)$ with $Kv_k=\kappa_kv_k$. Then $\sum d_\varphi^2=\sum_{a<b}K_{ab}^2=t_F/2$ and, by (0), $\sum d_\psi^2=\sum_k\kappa_k^2=\mathop{\mathrm{tr}}K^2=t_F$.

*(2)* The diagonal of a real symmetric matrix in an orthonormal basis is majorized by its spectrum (Schur, 1923); $M$ has $N=\binom n2$ diagonal entries in the pair basis and $\mathring W$ has $N+n-1=\dim S^2_0$ in this basis.

*(3)* $t_F=2\sum_{a<b}M_{(ab),(ab)}^2\le2\lVert M\rVert_F^2=2$, with equality exactly when every off-diagonal entry of $M$ in the pair basis of $F$ vanishes, which is $W$ coordinate-diagonal in $F$. *[Lemma L94](../findings/bispectral.md#lemma-l94-kappa2le2lvert-mrvert_f2-with-equality-exactly-when-w-is-coordinate-diagonal-in-some-frame) is the maximum of this over frames.*

*(4)* **Rigidity.** If $x\succ y$ in $\mathbb R^m$ and $\sum x_i^2=\sum y_i^2$ then $x^\downarrow=y^\downarrow$: with both sorted decreasingly and $X_k,Y_k$ the partial sums, $X_k\ge Y_k$ and $X_m=Y_m$, so $\sum y_i(x_i-y_i)=\sum_{k<m}(X_k-Y_k)(y_k-y_{k+1})\ge0$ and $0=\sum x_i^2-\sum y_i^2=\sum(x_i-y_i)^2+2\sum y_i(x_i-y_i)\ge\sum(x_i-y_i)^2$. At $t_F=2$, (1) gives $\sum d_\varphi^2=1=\sum\mu^2$ and $\sum d^2=3=\sum\omega^2$, the last by [Lemma L50](../findings/bispectral.md#lemma-l50-the-potential-is-a-function-of-two-spectra-and-collapses-to-one-only-below-dimension-six-canonical-statement-and-proof)'s normalisation, so (2) and rigidity give the sorted equalities. *And directly*: by (3) $M$ is diagonal in the pair basis, so its spectrum is $d_\varphi$; a coordinate-diagonal $W$ has $W_{iklj}\ne0$ only when $\{i,k\}=\{l,j\}$, so $(\mathring Wh)_{ij}$ reads $h_{ij}$ alone for $i\ne j$ and $h$'s diagonal alone for $i=j$, which makes $\mathring W$ diagonal on the $\varphi$-block and equal to $-K$ on the diagonal block, hence diagonal in the eigenbasis, and its spectrum is $d$. $\square$

**The eigenbasis is load-bearing.** Nienhaus–Petersen–Wink's staircase $\psi_k$ are fixed by the frame, and they diagonalise $K$ on $\mathbf1^\perp$ only when $K$ happens to be diagonal in them: at the $n=4$ coordinate-diagonal tensor with $K_{12}=K_{34}=\tfrac12$, $K_{13}=K_{24}=-\tfrac12$, $K_{14}=K_{23}=0$, $t_F=2$ while the staircase diagonal has $\sum d^2=\tfrac32$ against $\sum\omega^2=3$.


## Passage B, the canonical statements ([results.md](../results.md) lines 330 and 1082)

- **Lemma L54 (second-order). The two diagonals, and rigidity at $t=2$.** In a frame $F$, with the $\varphi$-vectors of Nienhaus–Petersen–Wink and $\psi_k$ an eigenbasis of $K$ on $\mathbf1^\perp$, the $\varphi$-diagonal of $\mathring W$ and of $M$ is $K$ and the $\psi$-block of $\mathring W$ is $-K$ on $\mathbf1^\perp$, so $\mu\succ d_\varphi$ and $\omega\succ d$; $t_F\le2$ with equality exactly when $W$ is coordinate-diagonal **in $F$**, and there both majorizations are equalities.

Let $W\in\mathrm{Weyl}_n$, $n\ge4$, with $\lVert M\rVert_F=1$. Fix a frame $F$ and take the orthonormal basis $\{\varphi_{ij},\psi_k\}$ of $S^2_0$ whose $\varphi_{ij}$ are the off-diagonal Nienhaus–Petersen–Wink vectors and **whose $\psi_k$ are an eigenbasis of $K$ on $\mathbf1^\perp$**, NPW's own staircase $\psi_k$ will not serve, being fixed by the frame alone. In that basis the diagonal of the second-kind operator $\mathring W$ on the $\varphi$-block is exactly the sectional vector $K$, the $\psi$-block of $\mathring W$ is exactly $-K$ restricted to $\mathbf 1^\perp$, and the diagonal of $M$ in the $\varphi$-basis of $\Lambda^2$ is $K$ as well. Consequently $\sum d_\varphi^2=t/2$ and $\sum d^2=\tfrac32t$ for the full $S^2_0$ diagonal $d$, and Schur–Horn gives $\mu\succ d_\varphi$ and $\omega\succ d$. In every frame $t_F=2\sum_{a<b}M_{(ab),(ab)}^2\le2\lVert M\rVert_F^2=2$, with equality exactly when $W$ is coordinate-diagonal **in that frame** (L94 is its maximum over frames), and at $t_F=2$ majorization has equal sums and equal norms on both sides, $\sum\omega^2=3$ by Lemma L50, forcing $\mu^\downarrow=d_\varphi^\downarrow$ and $\omega^\downarrow=d^\downarrow$ by the rigidity of majorization at equal $2$-norms. The vectors agree too: at $t_F=2$, $M$ is diagonal in the pair basis and $\mathring W$ is diagonal in the $\varphi$-and-eigenbasis.

## Passage C, the givens the proof cites, verbatim

**Lemma L52's statement** ([findings/bispectral.md](../findings/bispectral.md) line 75):

**Statement.** In any orthonormal frame, $M_{(ij),(ij)}=W_{ijij}$ and $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$ for $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$. Writing $K$ for the sectional vector and $K'$ for the $\mathring W$ diagonal **in the basis $\{\varphi_{ij},\psi_k\}$ whose $\psi_k$ are an eigenbasis of $K$ on $\mathbf1^\perp$**, a stipulation the frame alone does not supply, since the $\psi$-block carries $O(n-1)$ of further freedom, **Schur's theorem** gives $K\prec\mu$ and $K'\prec\omega$. Majorization alone bounds nothing, $t^3$ being neither convex nor concave; with $\omega_i\ge-m$ and $\mu_i\le M_+$ the functions $t^3+3mt^2$ and $t^3-3M_+t^2$ are respectively convex on $[-m,\infty)$ and concave on $(-\infty,M_+]$, and both diagonals lie in those ranges, giving

**The quadratic form on diagonal $h$** ([findings/bispectral.md](../findings/bispectral.md) lines 275-277):

**The chain CAPS $\mu$ itself, and that cap is a theorem, the earlier claim here that $\mu$ is uncapped was FALSE.** *Gate 2, reviewer 131, and it is five lines.* Let $h$ be the unit bottom eigenvector of $\mathring W$ on $S^2_0$. Every traceless symmetric $h$ is diagonal in **its own** eigenframe $F$, so $h=\mathrm{diag}(v)$ with $\sum v=0$, $\sum v^2=1$, and there

$$\langle\mathring Wh,h\rangle=\sum_{i\ne j}W_{ijji}v_iv_j=-v^{\mathsf T}K^Fv,\qquad\text{so}\qquad \mu=v^{\mathsf T}K^Fv\le\mu_1(K^F).$$

**Lemma L50's statement** ([findings/bispectral.md](../findings/bispectral.md) lines 133-135):

**Statement.** Let $W\in\mathrm{Weyl}_n$ act on $\Lambda^2\mathbb R^n$ as $M$, with $\lVert M\rVert_F=1$ and spectrum $\mu$. Let $\mathring W$ be the curvature operator of the second kind on trace-free symmetric $2$-tensors, $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$, with spectrum $\omega$. Then

$$\theta=\langle W,Q(W)\rangle=\tfrac32\,p_3(\mu)-\tfrac12\,p_3(\omega),\qquad \sum\mu=\sum\omega=0,\quad\sum\mu^2=1,\quad\sum\omega^2=3 .$$

## Sources

- Nienhaus–Petersen–Wink Proposition 3.10 and Li's convention for $\mathring W$: [references/](../references/) (search `nienhaus` and `li-2022`). Schur's majorization theorem (1923) is cited and not filed.

## What to attack

1. **Each numbered step of the proof, link by link**, (0) to (4), against the statement's hypotheses and the givens in Passage C, including whether each given is stated for the object it is applied to (Li's convention, the normalisation $\lVert M\rVert_F=1$, $n\ge4$).
2. **The polarisation in (1)**: from $\langle\mathring Wh,h\rangle=-v^{\mathsf T}Kv$ on diagonal traceless $h$ to $\langle\mathring W\mathop{\mathrm{diag}}(u),\mathop{\mathrm{diag}}(v)\rangle=-u^{\mathsf T}Kv$, and whether $\mathring W$ is symmetric so that polarisation applies; and whether "the $\psi$-block is diagonal" means the whole compression.
3. **The per-frame bound (3)**: that $t_F=2\sum_{a<b}M_{(ab),(ab)}^2$, that the inequality is the Frobenius norm against the diagonal, and the equality case read as coordinate-diagonal in $F$.
4. **The rigidity argument in (4)**: the Abel summation, the sign of each factor, the role of equal totals, and that sorting both vectors is legitimate for the majorization definition used.
5. **The direct route in (4)**: the claim about which $W_{iklj}$ are nonzero at a coordinate-diagonal $W$, the resulting form of $(\mathring Wh)_{ij}$ in Li's convention, and whether it yields $\omega=d$ as multisets.
6. **The closing witness**: that the stated $K$ is the $K$ of a coordinate-diagonal Weyl tensor at $n=4$, $t_F=2$, and the staircase diagonal has $\sum d^2=\tfrac32$.
7. The canonical forms (Passage B) against Passage A.
8. The boundary: $n=4$, odd $n$, repeated eigenvalues of $K$ on $\mathbf1^\perp$, $t_F=0$.

