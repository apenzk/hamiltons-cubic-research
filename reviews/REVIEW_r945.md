# Gate 2 review r945: Lemma L224 (the pair-block supremum) and Lemma L223 (the stability of L57)

Brief: [BRIEF_L223_L224.md](BRIEF_L223_L224.md). Log: [agent_logs/review-r945.log](../agent_logs/review-r945.log). Worked from the brief and its quoted definitions only. Analysis only, with one screen of a few seconds, labelled as such in item 3 and cited as evidence for nothing.

## Claim table

| Item | Claim | Verdict |
|---|---|---|
| 1 | L224 step 1, coordinates and norms | CONFIRMED |
| 2 | L224 step 2, $D^-_y\circ D^-_y=G_y$ in the normalisation of $\nu_x\circ\nu_x=G_x$ | CONFIRMED |
| 3 | L224 step 3, $P(W)=P(E)+3\langle E,G_y+G_x\rangle$ | CONFIRMED |
| 4 | L224 step 4, rank one and $P(W)\le\Theta_n$ | CONFIRMED |
| 5 | L224 step 5, the equality case and its converse | CONFIRMED |
| 6 | L224 scope ($n\ge4$, no criticality) and What it gives | CONFIRMED, with a scope note |
| 7 | L224 counterexample hunt by structure | CONFIRMED (no counterexample, and the $n=4$ case is explained) |
| 8 | L224 record search | CONFIRMED (no prior statement, no contradiction found) |
| 9 | L223 step 1, the pairing identity and $\eta_1\ge0$ | CONFIRMED |
| 10 | L223 step 2, $\lvert Z(v)\rvert^2$ and $\bar\Theta$ | CONFIRMED |
| 11 | L223 step 3, $\langle S\circ S,S\rangle\le2\mu$ and $e_-\le\sqrt2\lvert E\rvert$ | CONFIRMED |
| 12 | L223 steps 4 and 5, the vector and the sphere product | CONFIRMED, with two minor repairs |
| 13 | L223 scope and What it gives | CONFIRMED |
| Lean | [L224Statement.lean](../lean/HamiltonsCubic/Results/L224Statement.lean), [L223Statement.lean](../lean/HamiltonsCubic/Results/L223Statement.lean) | CONFIRMED as scalar cores, nothing vacuous |

**Summary: L224 survives every attack, its supremum and equality case are correct at every $n\ge4$ for every unit $W\in\mathcal D_n\oplus V_{jk}$, and L223 is correct up to two cosmetic repairs (the value of $\operatorname{sign}(0)$ and the sign of $B$).**

## Claim A, Lemma L224

### Item 1, step 1: CONFIRMED

- $\sigma$ acts on a diagonal tensor by $K_{pq}\mapsto K_{\sigma p\,\sigma q}$. It fixes $K_{jk}$ and every $K_{ab}$ and exchanges $K_{ja}\leftrightarrow K_{ka}$. The swap-odd part $(D-\sigma D)/2$ therefore vanishes on $K_{jk}$ and $K_{ab}$ and has $K_{ja}=-K_{ka}=y_a$, which is exactly $D^-_y$.
- Row sums of $D^-_y$: row $j$ gives $\sum y$, row $k$ gives $-\sum y$, row $a$ gives $y_a-y_a=0$. So $D^-_y\in\mathcal D_n$ exactly when $\sum y=0$. For $D\in\mathcal D_n$ this holds automatically because $\sigma D\in\mathcal D_n$, and then $E=D-D^-_y\in\mathcal D_n$ as well.
- $\Lambda^2\sigma$ sends $e_{ja}\mapsto e_{ka}$ and $e_{ka}\mapsto e_{ja}$, so $e_{ja}\odot e_{ka}$ is fixed and $\sigma\nu_x=\nu_x$. On $e_{jk}$ it acts by $-1$, which squares away in the diagonal entry.
- Norms, Frobenius over all entries of an operator on $\Lambda^2$ (one diagonal entry per unordered pair): $\lVert D^-_y\rVert^2=\sum_a(y_a^2+y_a^2)=2\lVert y\rVert^2$. $\nu_x$ has the entry $x_a$ at both $(ja,ka)$ and $(ka,ja)$, so $\lVert\nu_x\rVert^2=2\lVert x\rVert^2$. $E$, $D^-_y$ and $\nu_x$ are pairwise orthogonal (even against odd, diagonal against off-diagonal), so $\lVert W\rVert^2=\lVert E\rVert^2+2s$.
- This norm agrees with L57's: $\operatorname{tr}S^2=2$ is $\sum_{i<j}s_{ij}^2=1$, the same unit sphere. A sanity value confirms it: at $n=4$ with $K_{12}=K_{34}=2/\sqrt{12}$ and cross entries $-1/\sqrt{12}$, the product formula gives $P=3/\sqrt{12}=\sqrt3/2=\Theta_4$.

### Item 2, step 2: CONFIRMED

From $(A\circ A)_{pq}=A_{pq}^2+\sum_cA_{pc}A_{cq}$ with $A=D^-_y$:

- $(ja)$: $y_a^2+\sum_cK_{jc}K_{ca}$. Every $K_{jc}K_{ca}$ has $K_{ca}=0$ for $c\in\{k\}\cup\{b\ne a\}$, so the entry is $y_a^2$. The $(ka)$ entry is $(-y_a)^2=y_a^2$.
- $(jk)$: $0+\sum_aK_{ja}K_{ak}=-\lVert y\rVert^2$.
- $(ab)$: $0+K_{aj}K_{jb}+K_{ak}K_{kb}=2y_ay_b$.
- This is $G_y$ with the same three entry classes as L222's $G_x$, no factor between them.

**An independent analytic check of the relative normalisation**, which is the point where a factor of $2$ would break the Gram structure. By L222 item 5, $\xi\cdot E=0$ ($K_{ja}=K_{ka}$, and $\Lambda^2\xi\,e_{jk}=0$), $\xi\cdot D^-_y=\nu_{2y}$ and $\xi\cdot\nu_x=D^-_{-2x}$. So $e^{\varphi\xi}(E+D^-_y)=E+D^-_{y\cos2\varphi}+\nu_{y\sin2\varphi}$. Step 3's parity argument (item 3) gives $P(E+D^-_y+\nu_x)=P(E)+3q_1(y)+3q_2(x)$ with $q_1(y)=\langle E,D^-_y\circ D^-_y\rangle$ and $q_2(x)=\langle E,\nu_x\circ\nu_x\rangle$. $O(n)$-invariance of $P$ at $x=0$ then gives $\cos^2\!2\varphi\,q_1(y)+\sin^2\!2\varphi\,q_2(y)=q_1(y)$ for every $\varphi$, so $q_2=q_1$ as quadratic forms. The Gram structure is forced by the rotation, independently of the entrywise computation.

A side fact the step uses implicitly: $A\circ A\in\mathcal D_n$ for $A\in\mathcal D_n$. The row sum is $\sum_bK_{pb}^2+\sum_c K_{pc}\big(\sum_{b\ne p}K_{cb}\big)=\sum_bK_{pb}^2-\sum_cK_{pc}^2=0$, so no projection is hidden in the product.

### Item 3, step 3: CONFIRMED

Write $D=D^-_y$, $\nu=\nu_x$. The ten terms of $T(W,W,W)$ with multinomial coefficients, and the mechanism for each:

| Term | Coefficient | $D$-count | $\nu$-count | Fate |
|---|---|---|---|---|
| $P(E)$ | 1 | 0 | 0 | survives |
| $P(D)$ | 1 | 3 | 0 | swap |
| $P(\nu)$ | 1 | 0 | 3 | character |
| $T(E,E,D)$ | 3 | 1 | 0 | swap |
| $T(E,E,\nu)$ | 3 | 0 | 1 | character |
| $T(E,D,D)$ | 3 | 2 | 0 | survives, $=\langle E,G_y\rangle$ |
| $T(E,\nu,\nu)$ | 3 | 0 | 2 | survives, $=\langle E,G_x\rangle$ |
| $T(D,D,\nu)$ | 3 | 2 | 1 | character |
| $T(D,\nu,\nu)$ | 3 | 1 | 2 | swap |
| $T(E,D,\nu)$ | 6 | 1 | 1 | swap (or character) |

- **Swap.** $\sigma\in O(n)$, and $Q=W^2+W^\#$ is built from contractions with the metric, so it is $O(n)$-equivariant (determinant $-1$ included) and $T(\sigma A,\sigma B,\sigma C)=T(A,B,C)$. With $\sigma E=E$, $\sigma\nu=\nu$, $\sigma D=-D$, a term odd in $D$ equals its negative.
- **Character.** The flip $\varepsilon_j$ fixes every diagonal tensor and sends $e_{ja}\mapsto-e_{ja}$, $e_{ka}\mapsto e_{ka}$, so $\nu\mapsto-\nu$. A term odd in $\nu$ vanishes. The brief's phrase "by the character $\varepsilon_j\varepsilon_k$" names the character, and $\varepsilon_j$ is the group element that witnesses it.
- **Total symmetry.** $\operatorname{tr}(ABC)$ is totally symmetric on symmetric operators ($\operatorname{tr}ABC=\operatorname{tr}(ABC)^{\mathsf T}=\operatorname{tr}CBA$ joins the two cyclic classes), and $\langle A\#B,C\rangle$ is the polarisation of a cubic form. Any non-Weyl part of $A\circ B$ pairs to zero with a Weyl $C$, so the identity is insensitive to whether $\circ$ includes a projection.
- $\nu\circ\nu$ is $\Gamma$-fixed (fixed by $\ker\varepsilon_j\varepsilon_k$, and by $\varepsilon_j$ because $(-\nu)\circ(-\nu)=\nu\circ\nu$), hence diagonal, and L222 item 2 identifies it as $G_x$.

**Screen, not evidence.** An index-level implementation of $Q(R)=R^2+R^\#$ with $(R^\#)_{abcd}=\sum_{p,q}(R_{apcq}R_{bpdq}-R_{apdq}R_{bpcq})$, run for a few seconds, returned $P(S^2\times S^2)=0.86602540\ldots=\Theta_4$ at $n=4$, and at $n=6$ with a random swap-even $E\in\mathcal D_6$ and random centred $y,x$: $\lvert Q(\nu_x)-G_x\rvert\le4\times10^{-18}$, $Q(D^-_y)=G_y$ exactly, and $P(W)$ equal to $P(E)+3\langle E,G_y+G_x\rangle$ to $10^{-14}$. Script at scratchpad path `r945_screen.py`, not committed.

### Item 4, step 4: CONFIRMED

- $G_z$ has entries quadratic in $z$, so $q_E(z)=\langle E,G_z\rangle$ is a quadratic form on the $(n-3)$-dimensional space $\{\sum z=0\}$, and $\lambda$, $z_*$ are well defined.
- $q_E(y)\le\lambda\lVert y\rVert^2$ and $q_E(x)\le\lambda\lVert x\rVert^2$ give $q_E(y)+q_E(x)\le\lambda s$. This holds for $\lambda$ of either sign.
- $W'=E+D^-_{\sqrt s z_*}$ is diagonal, in $\mathcal D_n$ (as $\sum z_*=0$), and $\lVert W'\rVert^2=\lVert E\rVert^2+2s=1$.
- $P(W')=P(E)+3q_E(\sqrt s z_*)=P(E)+3\lambda s$ is step 3's identity at $x=0$.
- L57 is stated for every diagonal $W$, not only critical ones: $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$. It applies to $W'$ directly. Nothing in steps 1 to 4 uses criticality of $W$.

### Item 5, step 5: CONFIRMED

- $P(W)=\Theta_n$ forces $P(W')=\Theta_n$ and $q_E(y)+q_E(x)=\lambda s$, hence each of $q_E(y)=\lambda\lVert y\rVert^2$, $q_E(x)=\lambda\lVert x\rVert^2$ (each is at most its share).
- $s>0$: $\lVert E\rVert^2=1-2s<1$ and $P(E)\le\Theta_n\lVert E\rVert^3<\Theta_n$ (also when $E=0$), so $3\lambda s=\Theta_n-P(E)>0$ and $\lambda>0$.
- $W'$ is a unit diagonal tensor at L57's equality, so by L57's proof it is $S\parallel Z(v)$ at a two-valued $v$, block-constant in these coordinates on the sign partition $A\sqcup B$ with $\lvert A\rvert,\lvert B\rvert=\lfloor n/2\rfloor,\lceil n/2\rceil$. At odd $n$ the blocks are unbalanced and nothing below needs balance. Both blocks have size at least $2$ at $n\ge4$.
- **Same block makes $B'$ swap-even.** If $j,k\in A$ then $K_{ja}=K_{ka}$ for every $a$ (both $\alpha_A$ on $A$, both $\gamma$ on $B$), so the odd part vanishes, contradicting $s>0$. So $j\in A$, $k\in B$.
- **Recomputed $q_{B'}$**, with $A'=A\setminus\{j\}$, $B''=B\setminus\{k\}$, $u=\sum_{A'}z=-\sum_{B''}z$:
  - $\sum_a(K_{ja}+K_{ka})z_a^2=(\alpha_A+\gamma)\sum_{A'}z^2+(\gamma+\alpha_B)\sum_{B''}z^2$
  - $-K_{jk}\lVert z\rVert^2=-\gamma\lVert z\rVert^2$
  - $\sum_{a<b}2K_{ab}z_az_b=\alpha_A\big(u^2-\sum_{A'}z^2\big)+\alpha_B\big(u^2-\sum_{B''}z^2\big)-2\gamma u^2$
  - The squared sums cancel exactly and $q_{B'}(z)=(\alpha_A+\alpha_B-2\gamma)u^2$, unbalanced blocks included. This is the Lean declaration block_form.
- $q_E=q_{B'}$ because $G_z$ is swap-even and $D^-$ is odd. On $\{\sum z=0\}$, $u=\langle\bar u,z\rangle$ with $\bar u=1_{A'}-\tfrac{\lvert A'\rvert}{n-2}\mathbf 1$, nonzero since $1\le\lvert A'\rvert\le n-3$. The form $c\langle\bar u,\cdot\rangle^2$ has spectrum $\{c\lVert\bar u\rVert^2,0,\dots\}$, so $\lambda>0$ forces $c>0$ and the $\lambda$-eigenspace is exactly the line of $\bar u$. At $n=4$ that line is the whole space, which is consistent.
- Both $y$ and $x$ attain $\lambda$, so both lie on the line: $(y,x)=\sqrt s\,\hat u(\cos\psi,\sin\psi)$.
- **Rotation.** From item 2's reading of L222 item 5 the generator acts on $(y,x)$ by $(y,x)\mapsto(-2x,2y)$ and fixes $E$, so $e^{\varphi\xi}$ rotates $(y,x)$ by $2\varphi$. Then $W=e^{\varphi\xi}\cdot(E+D^-_{\sqrt s\hat u})$ with $2\varphi=\psi$. If $z_*=-\hat u$ the base point differs from $W'$ by a rotation through $\pi$ in $(y,x)$, that is $\varphi=\pi/2$, so it is again a unit diagonal L57 maximiser. The statement's $B$ exists in every case.
- **Converse.** $e^{\varphi\xi}\in O(n)$ preserves $P$ and the norm, and preserves $\mathcal S_{jk}$ by L222 item 1. If $j,k$ lie in one block of $B$, the rotation fixes $B$, which is harmless.

### Item 6, scope: CONFIRMED, with a scope note

- $n\ge4$ suffices everywhere: $\{\sum z=0\}$ is nonzero, L57 holds from $n=4$, and the blocks have size at least $2$. Nothing uses criticality.
- **What it gives follows.** A unit global maximiser $W$ of $P$ on $\mathcal W_n$ with $W\in\mathcal S_{jk}$ in some frame has $P(W)\ge\sup_{\mathcal D_n}P=\Theta_n$, hence $=\Theta_n$ by L224, hence $W=e^{\varphi\xi}\cdot B$, which is a sphere product in the rotated frame. Rotating back also gives zero pair component at the minimising angle.
- **Scope note, not a defect of the lemma.** [plan.md](../plan.md)'s I104 theorem for the pair-block stratum speaks of every *local* maximiser at its minimising angle. L224 delivers the statement for *global* maximisers, which is what What it gives says. A local maximiser of $P$ on $\mathcal W_n$ that lies in $\mathcal S_{jk}$ with value below $\Theta_n$ is outside L224's reach, so "the stratum closes" should be read with the word "global" attached wherever it is quoted.

### Item 7, counterexample hunt: CONFIRMED

The falsifier would be a unit $W\in\mathcal S_{jk}$ with $P(W)>\Theta_n$. Structured candidates:

- **$W_{\mathbb{CP}^2}$ at $n=4$**, the natural threat since $P(W_{\mathbb{CP}^2})=\sqrt{3/2}>\Theta_4=\sqrt3/2$ (the same constant L178 records). With $j,k=1,2$ and the self-dual basis $e_{12}+e_{34}$, $e_{13}-e_{24}$, $e_{14}+e_{23}$, a diagonal tensor has $W^\pm=\operatorname{diag}(p,q,r)$ on both halves, and $\nu_x$ acts as $\begin{psmallmatrix}0&x\\x&0\end{psmallmatrix}$ on the last two self-dual vectors and as $\begin{psmallmatrix}0&-x\\-x&0\end{psmallmatrix}$ on the last two anti-self-dual ones. So every element of $\mathcal S_{jk}$ at $n=4$ has $W^+$ and $W^-$ isospectral, while $W_{\mathbb{CP}^2}$ has $W^-=0\ne W^+$. It meets no $\mathcal S_{jk}$ in any frame, since $O(4)$ preserves or exchanges the two spectra. The same observation shows $\mathcal S_{jk}\subset O(4)\cdot\mathcal D_4$ at $n=4$, so there L224 reduces to L57 directly, an independent confirmation.
- **Padded products with $j,k$ in the padding.** Then $E$ is swap-even with $K_{ja}=K_{ka}$, and the theorem's chain applies unchanged. No special structure escapes step 4.
- **Rank-two Gram at the balanced product**, $j\in A$, $k\in B$, $y\parallel\bar u$, $x\perp\bar u$. Then $q_E(x)=0<\lambda\lVert x\rVert^2$ and $P(W)<\Theta_n$ strictly, as step 5 predicts.

No candidate survives, which is what a correct proof implies.

### Item 8, record: CONFIRMED

A search of findings for "rank one" and the identity finds no earlier statement of $P(E+D^-+\nu)=P(E)+3\langle E,G_y+G_x\rangle$ beyond L224's own index row. L178's $\sqrt{3/2}$ at $W_{\mathbb{CP}^2}$ sits in the four-set block, not in $\mathcal S_{jk}$, consistent with item 7. Plan.md's I104 text records L224 as closing the pair-block stratum, subject to item 6's scope note. No recorded value in $\mathcal D_n\oplus V_{jk}$ above $\Theta_n$ was found.

## Claim B, Lemma L223

### Item 9, step 1: CONFIRMED

- On matrices, $S^{\circ2}+S^2=\lambda S+E+\operatorname{diag}\big((S^2)_{ii}\big)$, the diagonal term carrying the diagonal of $S^2$. Pairing with $vv^{\mathsf T}$: $\sum_{i\ne j}s_{ij}^2v_iv_j+\mu^2=\lambda\mu+v^{\mathsf T}Ev+\sum_{i\ne j}s_{ij}^2v_i^2$, and $\sum_{i\ne j}s_{ij}^2(v_iv_j-v_i^2)=-\sum_{i<j}s_{ij}^2(v_i-v_j)^2$. This gives $\lambda\mu+v^{\mathsf T}Ev=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2$ with the sign as stated.
- $\mu>0$ since $\operatorname{tr}S=0$ and $S\ne0$, so $v\perp\mathbf 1$ (the eigenvalue of $\mathbf 1$ is $0$). Then $\sum_{i<j}s_{ij}(v_i-v_j)^2=\sum_iv_i^2\cdot(\text{row sum})-\mu=-\mu$ and $\sum_{i<j}(v_i-v_j)^2=n$. Cauchy-Schwarz gives $\eta_1\ge0$.
- Rearranged, $\lambda=\tfrac{n-1}n\mu-\eta_1/\mu-v^{\mathsf T}Ev/\mu\le\tfrac{n-1}n\mu-\eta_1/\mu+e_-/\mu$.

### Item 10, step 2: CONFIRMED

- $\langle S,Z(v)\rangle=\langle S,(v_iv_j)\rangle=\sum_{i<j}s_{ij}v_iv_j=\mu/2$ by the projection property (Given 2 (b)).
- $\lvert Z\rvert^2=\langle Z,(v_iv_j)\rangle$, and the three quoted sums are right: $\sum_{i<j}v_i^2v_j^2=\tfrac12(1-\sum v^4)$, $\sum_{i\ne j}v_i^3v_j=-\sum v^4$, $\sum_{i<j}v_iv_j=-\tfrac12$. The total is $\frac{(n-1)(n-2)+1}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v^4$, and $(n-1)(n-2)+1=n^2-3n+3$.
- With $\sum v^4=\tfrac1n+\eta_3$: $\frac{n^2-3n+3-(n-1)}{2(n-1)(n-2)}=\frac{(n-2)^2}{2(n-1)(n-2)}=Z_*^2$.
- $\tfrac{n-1}n\cdot2Z_*=\sqrt{4(n-1)^2(n-2)/(2n^2(n-1))}=\sqrt{2(n-1)(n-2)}/n=\bar\Theta$.

### Item 11, step 3: CONFIRMED

- The chain $\bar\Theta(1-r\cos\alpha)+\eta_1/\mu\le\Delta$ follows, and with $r,\cos\alpha\in[0,1]$ ($\cos\alpha>0$ from $\mu>0$) it gives $\Delta\ge0$ and item 2's three bounds.
- $\langle S\circ S,S\rangle=\sum_{i<j}s_{ij}^3+\sum_{i<j}(S^2)_{ij}s_{ij}=\tfrac12\sum_{i\ne j}s_{ij}^3+\tfrac12\operatorname{tr}S^3$, using $s_{ii}=0$.
- Term by term: $s_{ij}^3\le\mu s_{ij}^2$ for $s_{ij}\le\mu$ (negative $s_{ij}$ trivially), and $s_{ij}\le\mu$ from the Rayleigh quotient at $e_i+e_j$. So $\sum_{i<j}s_{ij}^3\le\mu$. Likewise $\lambda_i^3\le\mu\lambda_i^2$ for every eigenvalue, so $\tfrac12\operatorname{tr}S^3\le\tfrac12\mu\operatorname{tr}S^2=\mu$.
- $\langle S\circ S,S\rangle=\lambda+\langle E,S\rangle\ge\lambda-\lvert E\rvert$, so $\mu\ge(\lambda-\lvert E\rvert)/2>0$.
- $e_-\le\lVert E\rVert_{\mathrm{op}}\le\lVert E\rVert_{F,\text{all entries}}=\sqrt2\lvert E\rvert$. Item 1's upper bound follows.

### Item 12, steps 4 and 5: CONFIRMED, with two minor repairs

- $\eta_3=\tfrac{2(n-2)}nZ_*^2(1-r^2)=\tfrac{(n-2)^2}{n(n-1)}(1-r^2)\le\tfrac{(n-2)^2}{n(n-1)}\cdot2(1-r)$, and $1-r\le\Delta/\bar\Theta$. Item 3's first bound holds.
- $\lvert\lvert v_i\rvert-\tfrac1{\sqrt n}\rvert\le\sqrt n\lvert v_i^2-\tfrac1n\rvert$ gives $\lVert v-w\rVert^2\le n\eta_3$ and the second bound.
- **Repair 1, the value of $\operatorname{sign}(0)$.** With the usual $\operatorname{sign}(0)=0$, a coordinate $v_i=0$ gives $w_i=0$, so $w$ is not a unit vector, $p+q<n$, and step 5's "for unit $v,w$" fails. The bound itself survives if $\operatorname{sign}(0)$ is read as $+1$ (or either sign), since then $\lvert v_i-w_i\rvert=1/\sqrt n=\lvert\lvert v_i\rvert-1/\sqrt n\rvert$. The statement should say so.
- $\lvert p-q\rvert/\sqrt n=\lvert\sum(w-v)\rvert\le\sqrt n\lVert v-w\rVert$ by Cauchy-Schwarz.
- **Lipschitz bound.** In the unordered norm, $\lvert(v_iv_j)-(w_iw_j)\rvert^2=\tfrac12\big(2-2c^2-\sum(v_i^2-w_i^2)^2\big)\le1-c^2\le2(1-c)=\lVert v-w\rVert^2$ with $c=\langle v,w\rangle\le1$.
- **Invariance.** $\mathcal D_n$ is permutation-invariant, so $\Pi$ is permutation-equivariant, and $\Pi(ww^{\mathsf T})$ is constant on the orbits of $S_p\times S_q$ on pairs. An element of $\mathcal D_n$ constant on the three classes satisfies $(p-1)a+q\gamma=0$ and $(q-1)b+p\gamma=0$. At $p,q\ge2$ it is a multiple of the vertex matrix. At $p=1$ the single row forces $\gamma=0$ and then $b=0$, and at $p=0$ everything vanishes. So nonzero forces $p,q\ge2$, as claimed.
- **Nonvanishing.** $\lVert v-w\rVert\le Z_*\cdot2\sqrt{n-2}\sqrt{\Delta/\bar\Theta}$ and $\lvert Z(v)\rvert\ge Z_*(1-\Delta/\bar\Theta)$. The hypothesis, halved, is $2\sqrt{n-2}\sqrt{\Delta/\bar\Theta}<1-\Delta/\bar\Theta$, which gives $\lVert v-w\rVert<\lvert Z(v)\rvert$ and so $\Pi(ww^{\mathsf T})\ne0$.
- **The constant.** $\lvert S-\hat Z\rvert=\sqrt{2(1-\cos\alpha)}\le\sqrt2\sqrt{\Delta/\bar\Theta}$. $\lvert\hat Z-B\rvert\le2\lVert v-w\rVert/\lvert Z\rvert\le4\sqrt{n-2}\sqrt{\Delta/\bar\Theta}/(1-\Delta/\bar\Theta)$, and $2(n-2)\sqrt{2/(n-1)}\big/\sqrt{(n-2)/(2(n-1))}=4\sqrt{n-2}$.
- **Repair 2, the sign of $B$.** "Up to sign" is true but weaker than what holds. Pairing $ww^{\mathsf T}$ with the vertex matrix normalised to cross entry $-1$ (within entries $q/(p-1)$, $p/(q-1)$) gives $\tfrac1n\big(\tfrac{pq}2+\tfrac{pq}2+pq\big)=\tfrac{2pq}n>0$. So $B$ has positive within-block and negative cross entries, the geometric sign of $S^p\times S^q$, and the phrase can be dropped.

### Item 13, scope: CONFIRMED

- **$n=4$.** All formulas need only $n>2$, and the product is $S^2\times S^2$.
- **Odd $n$.** Nothing uses parity. $\Delta\ge\bar\Theta-\Theta_n>0$ at an exact critical point, with the gap $\bar\Theta^2-\Theta_n^2=\frac{8(n-1)}{n^2(n+1)(n-2)}$ (the Lean theta_gap_odd). Item 4 then yields some $p,q\ge2$ with $\lvert p-q\rvert\le n\lVert v-w\rVert$ and does not claim balance, which is correct.
- **$\ker S\ne0$** plays no role, since only $\mu>0$ and $v\perp\mathbf 1$ are used.
- **What it gives.** The radius is $\sim4\sqrt{n\Delta/\bar\Theta}=O(\sqrt{n\Delta})$. The link to L149's $\tfrac1{n-2}$ gap is heuristic and phrased as such. It is recorded as a tool, correctly, given item 5 above. No overclaim.

## Lean

- **[L224Statement.lean](../lean/HamiltonsCubic/Results/L224Statement.lean): CONFIRMED as scalar cores.**
  - two_columns_le and two_columns_eq are steps 4 and 5's "each at most its share".
  - pair_value_le is the chain $P(W)\le P(W')\le\Theta$ with its equality consequences.
  - block_form is exactly item 5's expansion of $q_{B'}$ on $\alpha\oplus\beta=A'\sqcup B''$ under $\sum z=0$.
  - sub_lt_of_mass is $P(E)<\Theta$ at $s>0$.
  - None is vacuous, and the examples instantiate the hypotheses consistently. The tensor calculus of steps 1 to 3 (the swap, the character and $D^-_y\circ D^-_y=G_y$) and the identification of block_form's left side with $\langle B',G_z\rangle$ are unformalised, which "polynomial cores" discloses.
- **[L223Statement.lean](../lean/HamiltonsCubic/Results/L223Statement.lean): CONFIRMED as scalar cores.**
  - fourth_moment_defect, coord_bound, chain_defects, cube_le, mu_lower, one_sub_sq_le, Zstar_theta, radius_constant ($16(n-2)=(4\sqrt{n-2})^2$), unit_diff_le and split_le match the steps that cite them.
  - Z_norm_sq holds for every real $n>3$, not only $n=\lvert\iota\rvert$. It checks the pairing $\sum_{i\ne j}Z_{ij}v_iv_j$, and the equality of that pairing with $2\lvert Z\rvert^2$ comes from the projection property on record, not from Lean.
  - theta_gap_odd and balanced_split are unused by the statement as quoted. They are harmless, and they bear on the odd-$n$ and balanced readings.
  - No vacuous hypothesis.
