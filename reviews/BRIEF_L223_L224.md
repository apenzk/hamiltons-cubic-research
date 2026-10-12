# Gate 2 brief, Lemma L224 (the pair-block supremum) and Lemma L223 (the stability of L57)

**Cold brief. Every passage is quoted verbatim from the record with its source. You are asked to break both results.** Verdicts: CONFIRMED, PLAUSIBLE or REFUTED with corrections, per claim. **L224 is the priority**: it claims a global supremum on a subalgebra, so a single counterexample or a single broken step matters more than anything in L223.

**Analysis only.** Argue from the definitions. You may run a computation of a few seconds on an object you construct to screen a step you are about to report, and you must report it as a screen, never as evidence for a positive claim. No sweeps, no optimisation, no open-ended search.

## Claim A under attack ([findings/second-order.md](../findings/second-order.md) lines 918-932)

#### Lemma L224, the pair-block subalgebra carries no value above the diagonal: $\sup P=\Theta_n$ on $\mathcal D_n\oplus V_{jk}$, attained only at the $(j,k)$-rotations of L57's maximisers

*Gate 2 owed. Derived 2026-09-14 for [I104](../plan.md). The polynomial cores are kernel-checked in [L224Statement.lean](../lean/HamiltonsCubic/Results/L224Statement.lean). The argument is global: it needs no smallness of $\nu$, no gap and no stability lemma.*

**Statement.** *Let $n\ge4$, $j\ne k$ and $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$. Every unit $W\in\mathcal S_{jk}$ has $P(W)\le\Theta_n$. Equality holds exactly when $W=e^{\varphi\xi}\cdot B$ for a unit diagonal $B$ attaining [L57](problem.md)'s equality and an angle $\varphi$, where $\xi$ generates the rotations of the $(j,k)$-plane.*

**Proof.** Indices $a,b$ run over $a\notin\{j,k\}$, and vectors $y,x,z$ live in $\{z\in\mathbb R^{n-2}:\sum z=0\}$. $G_z$ is [L222](#lemma-l222-the-pair-block-calculus-nucirc-nu-the-pinning-the-swap-parity-and-the-rotation-angle-on-mathcal-d_noplus-v_jk)'s diagonal tensor with $K_{ja}=K_{ka}=z_a^2$, $K_{jk}=-\lVert z\rVert^2$, $K_{ab}=2z_az_b$.
1. **Coordinates.** Let $\sigma$ swap $j$ and $k$. It fixes $K_{jk}$ and every $K_{ab}$, so a diagonal $D$ splits as $D=E+D^-_y$ with $E$ swap-even and $D^-_y$ the tensor with $K_{ja}=y_a$, $K_{ka}=-y_a$ and no other entry, which lies in $\mathcal D_n$ exactly when $\sum y=0$, with $\lVert D^-_y\rVert^2=2\lVert y\rVert^2$. Every element of $V_{jk}$ is $\nu_x=\sum_ax_a\,e_{ja}\odot e_{ka}$ with $\lVert\nu_x\rVert^2=2\lVert x\rVert^2$, and $\sigma$ fixes it. So $W=E+D^-_y+\nu_x$ and $\lVert W\rVert^2=\lVert E\rVert^2+2s$ with $s=\lVert y\rVert^2+\lVert x\rVert^2$.
2. **The two squares.** $\nu_x\circ\nu_x=G_x$ is L222's item 2. With the diagonal product $(A\circ A)_{pq}=A_{pq}^2+\sum_cA_{pc}A_{cq}$, $D^-_y\circ D^-_y$ has $(ja)$-entry $y_a^2$, $(jk)$-entry $\sum_ay_a(-y_a)=-\lVert y\rVert^2$ and $(ab)$-entry $y_ay_b+(-y_a)(-y_b)=2y_ay_b$, so it is $G_y$. The entries of $G_z$ are linear in $zz^{\mathsf T}$, so $G_y+G_x=\mathcal G(C)$ for $C=yy^{\mathsf T}+xx^{\mathsf T}$ with $\mathcal G$ linear.
3. **The cubic.** In $P(W)=T(W,W,W)$ a term with an odd number of factors $D^-_y$ vanishes, $\sigma$ being an automorphism that fixes $E$ and $\nu_x$ and reverses $D^-_y$. A term with an odd number of factors $\nu_x$ vanishes by the character $\varepsilon_j\varepsilon_k$ ([L120](#lemma-l120-l_m-is-block-diagonal-over-the-sign-characters-at-every-diagonal-critical-point), L222's item 1). What remains is $P(E)+3T(E,D^-_y,D^-_y)+3T(E,\nu_x,\nu_x)$, and total symmetry with step 2 gives $$P(W)=P(E)+3\langle E,G_y\rangle+3\langle E,G_x\rangle=P(E)+3\langle E,\mathcal G(C)\rangle .$$
4. **Rank one.** Let $\lambda$ be the top eigenvalue of the quadratic form $q_E(z)=\langle E,G_z\rangle$ on $\{\sum z=0\}$ and $z_*$ a unit eigenvector for it. Then $q_E(y)+q_E(x)\le\lambda s=q_E(\sqrt s\,z_*)$, so $W'=E+D^-_{\sqrt sz_*}$ is a unit diagonal tensor with $P(W)\le P(E)+3\lambda s=P(W')\le\Theta_n$ by L57.
5. **Equality.** If $P(W)=\Theta_n$ then $P(W')=\Theta_n$, $q_E(y)=\lambda\lVert y\rVert^2$ and $q_E(x)=\lambda\lVert x\rVert^2$. At $s=0$, $W=E$ is diagonal. At $s>0$, $\lVert E\rVert<1$ gives $P(E)\le\Theta_n\lVert E\rVert^3<\Theta_n$, so $\lambda>0$. $W'$ is an L57 maximiser $B'$ with swap-even part $E$ and nonzero odd part, so $j$ and $k$ lie in different blocks $A\ni j$, $B\ni k$ of $B'$, which is block-constant with values $\alpha_A,\alpha_B$ inside the blocks and $\gamma$ across. Since $G_z$ is swap-even, $q_E=q_{B'}$, and expanding, $q_{B'}(z)=(\alpha_A+\alpha_B-2\gamma)\big(\sum_{a\in A'}z_a\big)^2$ with $A'=A\setminus\{j\}$. On $\{\sum z=0\}$ this is $c\langle\bar u,z\rangle^2$ with $\bar u$ the centred indicator of $A'$, so $\lambda=c\lVert\bar u\rVert^2>0$ has the line of $\bar u$ as its whole eigenspace, and both $y$ and $x$ lie on it: $(y,x)=\sqrt s\,\hat u\,(\cos\psi,\sin\psi)$. By L222's item 5, $\xi\cdot E=0$, $\xi\cdot D^-_y=\nu_{2y}$ and $\xi\cdot\nu_x=D^-_{-2x}$, so $e^{\varphi\xi}$ fixes $E$ and rotates $(y,x)$ by $2\varphi$, and $W=e^{\varphi\xi}\cdot W'$ with $2\varphi=\psi$ up to the sign convention of $\xi$. Conversely $P$ is $O(n)$-invariant. $\square$

**What it gives.** **The pair-block stratum of I104 closes for global maximisers at every $n\ge4$:** a unit global maximiser of $P$ lying in some $\mathcal S_{jk}$ has value at least $\Theta_n$ by H1, hence exactly $\Theta_n$, and is a rotation of an L57 maximiser, which is a sphere product in another frame. *No smallness of $\nu$ enters, so the small-$\nu$ reduction of the [gap note](../reviews/2026-09-14-I104-pair-gap.md) and [L223](problem.md)'s use there are not needed for this stratum.* **The mechanism is that $P$ on $\mathcal S_{jk}$ sees its two swap-odd columns only through their Gram matrix, and a linear function of a positive semidefinite matrix of fixed trace peaks at rank one**, which is a diagonal tensor. *The question it hands to I104 is which larger subalgebras keep that structure, first several pair blocks sharing an index and the four-set blocks they generate.*

## Claim B under attack ([findings/problem.md](../findings/problem.md) lines 661-679)

#### Lemma L223, the stability of L57: a near-critical diagonal tensor of value near $\Theta_n$ lies near a sphere product

*Gate 2 owed. Derived 2026-09-14 for [I103](../plan.md) from L57's own chain with its three defects kept. The polynomial cores are kernel-checked in [L223Statement.lean](../lean/HamiltonsCubic/Results/L223Statement.lean), including L57's norm formula for $Z(v)$, which that block records as carried without a derivation.*

**Statement.** *Let $n\ge4$, $S\in\mathcal D_n$ with $\sum_{i<j}s_{ij}^2=1$, and $S\circ S=\lambda S+E$ with $E\in\mathcal D_n$ and $\lambda>\lvert E\rvert$, norms over unordered pairs. Put $\bar\Theta=\sqrt{2(n-1)(n-2)}/n$, which is $\Theta_n$ at even $n$, $Z_*^2=\frac{n-2}{2(n-1)}$, let $\mu$ be the top eigenvalue of $S$ with unit eigenvector $v$, $e_-=\max(0,-v^{\mathsf T}Ev)$ and $\Delta=\bar\Theta-\lambda+e_-/\mu$.*
1. *$\Delta\ge0$, and $\Delta\le\bar\Theta-\lambda+2\sqrt2\lvert E\rvert/(\lambda-\lvert E\rvert)$.*
2. *With $\alpha$ the angle between $S$ and $Z(v)$ and $\eta_1=\sum_{i<j}s_{ij}^2(v_i-v_j)^2-\mu^2/n$: $1-\cos\alpha\le\Delta/\bar\Theta$, $\eta_1\le\mu\Delta$, and $\lvert Z(v)\rvert\ge Z_*(1-\Delta/\bar\Theta)$.*
3. *$\sum_i(v_i^2-\tfrac1n)^2\le\frac{2(n-2)^2}{n(n-1)}\frac\Delta{\bar\Theta}$, so $w=\operatorname{sign}(v)/\sqrt n$ has $\lVert v-w\rVert^2\le\frac{2(n-2)^2}{n-1}\frac\Delta{\bar\Theta}$, and its sign classes of sizes $p,q$ have $\lvert p-q\rvert\le n\lVert v-w\rVert$.*
4. *If $4\sqrt{n-2}\sqrt{\Delta/\bar\Theta}<2(1-\Delta/\bar\Theta)$, then $p,q\ge2$ and $\lvert S-B\rvert\le\big(\sqrt2+\frac{4\sqrt{n-2}}{1-\Delta/\bar\Theta}\big)\sqrt{\Delta/\bar\Theta}$, where $B$ is the unit positive multiple of the projection of $(w_iw_j)$ onto $\mathcal D_n$, constant on the three classes of pairs of the sign partition, the vertex matrix of $S^p\times S^q$ up to sign.*

**Proof.**
1. **Step 1 with its defect.** Pairing the matrix equation with $vv^{\mathsf T}$ as in L57 gives $\lambda\mu+v^{\mathsf T}Ev=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2$, and Cauchy--Schwarz with $\sum_{i<j}s_{ij}(v_i-v_j)^2=-\mu$ and $\sum_{i<j}(v_i-v_j)^2=n$ makes $\eta_1\ge0$, so $\lambda=\frac{n-1}n\mu-\eta_1/\mu-v^{\mathsf T}Ev/\mu\le\frac{n-1}n\mu-\eta_1/\mu+e_-/\mu$.
2. **Steps 2 and 3 with theirs.** $\mu=2\langle S,Z(v)\rangle=2\lvert Z(v)\rvert\cos\alpha$. Pairing $Z(v)$ with $(v_iv_j)$, its projection property gives $\lvert Z(v)\rvert^2=\tfrac12(1-\sum v^4)-\frac{\sum v^4}{n-2}+\frac1{2(n-1)(n-2)}=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v^4$, using $\sum_{i<j}v_i^2v_j^2=\tfrac12(1-\sum v^4)$, $\sum_{i\ne j}v_i^3v_j=-\sum v^4$ and $\sum_{i<j}v_iv_j=-\tfrac12$. With $\sum v^4=\tfrac1n+\eta_3$, $\eta_3=\sum(v_i^2-\tfrac1n)^2\ge0$, this is $\lvert Z(v)\rvert^2=Z_*^2-\frac n{2(n-2)}\eta_3$. So $r=\lvert Z(v)\rvert/Z_*\in[0,1]$ and $\frac{n-1}n\cdot2Z_*=\bar\Theta$.
3. **The chain.** Together, $\lambda\le\bar\Theta r\cos\alpha-\eta_1/\mu+e_-/\mu$, that is $\bar\Theta(1-r\cos\alpha)+\eta_1/\mu\le\Delta$, and $r,\cos\alpha\in[0,1]$ give items 2's three bounds and $\Delta\ge0$. For item 1's upper bound, $\langle S\circ S,S\rangle=\tfrac12\sum_{i\ne j}s_{ij}^3+\tfrac12\operatorname{tr}S^3\le2\mu$ because $s_{ij}\le\mu$ (from $(e_i+e_j)^{\mathsf T}S(e_i+e_j)=2s_{ij}$) and every eigenvalue is at most $\mu$, while $\langle S\circ S,S\rangle=\lambda+\langle E,S\rangle\ge\lambda-\lvert E\rvert$. So $\mu\ge(\lambda-\lvert E\rvert)/2$, and $e_-\le\lVert E\rVert_{\mathrm{op}}\le\sqrt2\lvert E\rvert$.
4. **The vector.** $\eta_3=\frac{2(n-2)}nZ_*^2(1-r^2)\le\frac{(n-2)^2}{n(n-1)}\cdot2(1-r)$ gives item 3's first bound. $\big\lvert\lvert v_i\rvert-\tfrac1{\sqrt n}\big\rvert\le\sqrt n\,\lvert v_i^2-\tfrac1n\rvert$ gives the second. $\sum w=(p-q)/\sqrt n$ and $\sum v=0$ give $\lvert p-q\rvert/\sqrt n\le\sqrt n\lVert v-w\rVert$.
5. **The sphere product.** For unit $v,w$ the off-diagonal parts satisfy $\lvert(v_iv_j)-(w_iw_j)\rvert\le\lVert v-w\rVert$, and the projection onto $\mathcal D_n$ is non-expansive, so $\lvert Z(v)-\Pi(w_iw_j)\rvert\le\lVert v-w\rVert$. $\Pi(w_iw_j)$ is invariant under the permutations preserving the sign partition, hence constant on the three classes of pairs, hence a multiple of the vertex matrix of $S^p\times S^q$. Item 4's hypothesis makes $\lVert v-w\rVert<\lvert Z(v)\rvert$, so the multiple is nonzero and $p,q\ge2$. Then $\lvert S-B\rvert\le\lvert S-\hat Z(v)\rvert+\lvert\hat Z(v)-B\rvert\le\sqrt{2(1-\cos\alpha)}+2\lVert v-w\rVert/\lvert Z(v)\rvert$, and $2\sqrt{2(n-2)^2/(n-1)}/Z_*=4\sqrt{n-2}$. $\square$

**What it gives.** *A quantitative L57 for near-critical diagonal tensors, radius $O(\sqrt{n\Delta})$, the $\sqrt n$ matching the $\tfrac1{n-2}$ transverse gap of [L149](second-order.md). Its intended consumer, the small-$\nu$ regime of I104's pair-block stratum, is closed outright by [L224](second-order.md), so it is recorded as a tool.* **No screen is cited as evidence.**

## Given 1, Lemma L57's statement ([findings/problem.md](../findings/problem.md) lines 646-655)

Let $\mathcal D_n=\{S\ \text{symmetric, hollow},\ S\mathbf1=0\}$ be the vertex matrices of coordinate-diagonal Weyl operators. Then
\[
\langle Q(W),W\rangle\;\le\;\Theta_n\,\|W\|^3\qquad\text{for every diagonal }W\text{ at every }n\ge4,
\]
\[
\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}\ \ (n\text{ even}),\qquad
\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}\ \ (n\text{ odd}),
\]
with equality exactly at $S^{n/2}\times S^{n/2}$ for even $n$ and at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ for odd $n$, at the *geometric* Weyl tensor of that product, which is $-V/\lVert V\rVert$ under the record's $V$ convention. At even $n$, $\Theta_n=\theta_0(n)$.

## Given 2, L57's three steps and the projection $Z(v)$ ([findings/problem.md](../findings/problem.md) lines 356-381)

On the diagonal locus $\mathcal D_n=\{S$ symmetric, hollow, $S\mathbf 1=0\}$ with $\operatorname{tr}S^2=2$, **not $\lvert S\rvert=1$, which under [conventions.md](conventions.md)'s default of plain Frobenius over ordered pairs gives $\Theta_n/\sqrt2$**, the $\sqrt2$ trap that file records as having already cost a cycle, at a critical point $Q(S)=\lambda S$ (which is the record's own $S^{\circ2}+S^2=\lambda S+D$), let $\mu$ be the largest eigenvalue of $S$ with unit eigenvector $v\perp\mathbf1$.

1. **$\lambda\le\frac{n-1}{n}\mu$.** Pair the matrix identity with $v\otimes v$: $\lambda\mu=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2$; the row-sum condition gives $\sum_{i<j}s_{ij}(v_i-v_j)^2=-\mu$ and $\sum_{i<j}(v_i-v_j)^2=n$, so Cauchy–Schwarz gives $\sum s_{ij}^2(v_i-v_j)^2\ge\mu^2/n$. *This is the record's Dirichlet-energy step in [diagonal-half.md](diagonal-half.md).* **Equality at every $S^p\times S^q$, balanced or not, even or odd $n$**, checked at ten products to $10^{-16}$.
2. **$\mu=2\langle S,Z(v)\rangle$ with $Z(v)_{ij}=v_iv_j+\frac{v_i^2+v_j^2}{n-2}-\frac1{(n-1)(n-2)}$ the projection of $(v_iv_j)$ onto $\mathcal D_n$**, hence $\mu^2\le4\lvert Z(v)\rvert^2$, and $\lvert Z(v)\rvert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v_i^4$, the projection and the norm formula both verified to $10^{-12}$ at $n=6,7,8,11,12$.
3. **The parity-sensitive fourth-moment lemma.** For $\sum v=0$, $\sum v^2=1$: $\sum v^4\ge\frac1n$ ($n$ even), $\ge\frac{n^2+3}{n(n^2-1)}$ ($n$ odd), equality at the two-value vector with multiplicities $\lfloor n/2\rfloor,\lceil n/2\rceil$. *Re-derived here*: a three-coordinate smoothing reduces a minimiser to two values, and then $\sum v^4=\frac n{k(n-k)}-\frac3n$, minimised at $k=\lfloor n/2\rfloor$. Free minimisation over the constraint set matches the closed form at $n=4,\dots,12$ to $10^{-9}$.

Chaining: $\lambda^2\le\big(\tfrac{n-1}n\big)^2\cdot4\lvert Z\rvert^2_{\max}=\Theta_n^2$, with $\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}$ for even $n$ and $\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ for odd $n$, **the odd value is exactly Reviewer 89's $\tfrac{40}{27},\tfrac{120}{77},\tfrac{21}{13}$ at $n=11,13,15$**, so the two projects agree on the odd constant. Equality forces the two-value $v$ and $S\parallel Z(v)$, which is $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$.

#### Step 2 is now PROVED here, both halves, in a few lines each

**(a) $Z(v)\in\mathcal D_n$.** Symmetric and hollow by construction. Row sums, using $\sum v=0$ so $\sum_{j\ne i}v_j=-v_i$, and $\sum v^2=1$:

$$\sum_{j\ne i}Z_{ij}=-v_i^2+\frac{(n-1)v_i^2+(1-v_i^2)}{n-2}-\frac{n-1}{(n-1)(n-2)}=-v_i^2+v_i^2+\frac1{n-2}-\frac1{n-2}=0 .$$

**(b) $Z$ is the ORTHOGONAL projection**, the half that was owed. The residual is

$$(v_iv_j)-Z_{ij}=-\frac{v_i^2+v_j^2}{n-2}+\frac1{(n-1)(n-2)}=a_i+a_j+c,\qquad a_i=\frac{-v_i^2}{n-2},\quad c=\frac1{(n-1)(n-2)} .$$

For any $T\in\mathcal D_n$, $\sum_{i<j}(a_i+a_j)T_{ij}=\sum_ia_i\cdot(\text{row sum})=0$ and $\sum_{i<j}cT_{ij}=\tfrac c2\sum_i(\text{row sum})=0$. **A residual of the form $a_i+a_j+c$ is orthogonal to every hollow symmetric zero-row-sum matrix**, which is exactly $\mathcal D_n$. $\square$ *Checked: $\lvert\langle\text{residual},T\rangle\rvert\le3\times10^{-17}$ over 30 random $T\in\mathcal D_n$ at each of $n=5,\dots,12$.*

**(c) The equality case is the balanced product**, computed rather than asserted. At the balanced two-value $v$ ($k=n/2$, $a=b=1/\sqrt n$), $Z$ takes two values with

$$\frac{Z_{\text{same block}}}{Z_{\text{cross}}}=-\frac{n/2}{n/2-1},$$

which is exactly the within/cross ratio of $S^{n/2}\times S^{n/2}$'s vertex matrix, verified as $-1.5,-4/3,-1.25,-1.2$ at $n=6,8,10,12$ against the sphere product's own values. So $S\parallel Z(v)$ *is* the balanced product, up to the overall sign that scaling absorbs.

## Given 1, Lemma L120's statement ([findings/second-order.md](../findings/second-order.md) lines 624-631)

#### Lemma L120, $L_M$ is block-diagonal over the sign characters at every diagonal critical point

**Let $\Gamma=\{\operatorname{diag}(\varepsilon_1,\dots,\varepsilon_n):\varepsilon_i=\pm1\}\subset O(n)$ be the full diagonal sign group. Then $\mathcal W_n$ decomposes as**
$$\mathcal W_n=\underbrace{\mathcal D_n}_{n(n-3)/2}\ \oplus\ \bigoplus_{\{i,j,k,l\}}\underbrace{V_{ijkl}}_{2}\ \oplus\ \bigoplus_{\{j,k\}}\underbrace{V_{jk}}_{n-3},$$
**and at every diagonal $M$, **criticality is unused; $\Gamma$-equivariance needs only that $M$ is $\Gamma$-fixed**, the operator $L_M$ preserves each summand. Hence the Hessian of $P$ on the sphere is block-diagonal in the same way, and [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement)'s criterion is checkable block by block **once $\mathcal D_n$ is cut by $\langle M\rangle$**; the largest block a non-diagonal direction occupies has size $\max(2,n-3)$, and $\binom n4$ of them have size $2$.

> **THE CUT IS NOT OPTIONAL, AND THE SENTENCE ABOVE IS THE ONE EVERY CITATION QUOTES.** $e=M/\theta$ lies in $\mathcal D_n$ and $L_ee=e$, so read without it the criterion gives $\lambda_{\max}(L_e\vert_{\mathcal D_n})\ge1>\tfrac12$ and **no diagonal critical point is a maximiser, vacuously**, the balanced sphere product included. **$W^\perp$ cuts $\mathcal D_n$ and nothing else**, since $M$ spans the trivial character and every other summand lies wholly inside $W^\perp$ by isotypic orthogonality. *And the block size fails at $n=4$ as first printed, where the four-set block is $2$ against $n-3=1$.* *Gate 2, [r507](REVIEW_r507.md) and [r508](REVIEW_r508.md) on identical briefs, both CONFIRMED and agreeing on every repair.***

## Given 2, the conventions: $Q(W)=W^2+W^\#$, the diagonal product and the norms

On the diagonal locus a unit Weyl tensor has sectional matrix $K$ with $\sum_{a<b}K_{ab}^2=1$, and the product of two diagonal tensors has sectional matrix $(A\circ B)_{ab}=A_{ab}B_{ab}+\tfrac12\sum_c(A_{ac}B_{cb}+B_{ac}A_{cb})$ ([references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md), §2.6). $Q$ maps $\mathcal W_n$ into itself ([findings/curvature-invariants.md](../findings/curvature-invariants.md), Lemma L209). The norm on symmetric operators on $\Lambda^2$ is the Frobenius norm over all entries.

## Given 4, Lemma L222 as it stands after its Gate 2 ([findings/second-order.md](../findings/second-order.md) lines 896-917), items 1 to 6 CONFIRMED by two reviewers

#### Lemma L222, the pair-block calculus: $\nu\circ\nu$, the pinning, the swap parity and the rotation angle on $\mathcal D_n\oplus V_{jk}$

*Gate 2: [r943](../reviews/REVIEW_r943.md) and [r944](../reviews/REVIEW_r944.md) on identical briefs, items 1 to 6 CONFIRMED by both, and the paragraph on what it gives rewritten below on both reports. Derived in the [pair-block note](../reviews/2026-09-14-I104-pair-block.md) for [I104](../plan.md). The polynomial cores are kernel-checked in [L222Statement.lean](../lean/HamiltonsCubic/Results/L222Statement.lean). This lemma records identities, and the pair-block stratum is argued from them in the [gap note](../reviews/2026-09-14-I104-pair-gap.md).*

**Statement.** *Let $n\ge4$, $j\ne k$, and $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$. Write $\nu\in V_{jk}$ as $\nu=\sum_ax_a\,e_{ja}\odot e_{ka}$ ($a\notin\{j,k\}$, $\sum x=0$, $\lVert\nu\rVert^2=2\lVert x\rVert^2$), $D\in\mathcal D_n$ with sectional matrix $K$, and let $\sigma$ swap $j$ and $k$ with $D=D^++D^-$ its even and odd parts, the odd part having entries $K_{ja}=-K_{ka}$. Let $\xi\in\mathfrak{so}(n)$ be the generator with $\xi e_j=e_k$, $\xi e_k=-e_j$. Sums over $a$ run over $a\notin\{j,k\}$.*
1. *$\mathcal S_{jk}$ is a subalgebra, preserved by rotations in the $(j,k)$-plane.*
2. *$\nu\circ\nu=G_x$, the diagonal tensor with $K_{ja}=K_{ka}=x_a^2$, $K_{jk}=-\lVert x\rVert^2$, $K_{ab}=2x_ax_b$, and $\lVert G_x\rVert^2=3\lVert x\rVert^4$, so $\lVert\nu\circ\nu\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$.*
3. *If $W=D+\nu$ is a unit critical point with $\nu\ne0$, then $\langle D,\hat g\rangle=\theta/\sqrt3$ for $\hat g=G_x/\lVert G_x\rVert$, and $2L_{D^+}D^-=\theta D^-$.*
4. *On the odd part, identified with $\{y:\sum y=0\}$, $L_{G_x}$ acts as $y\mapsto\tfrac12\lVert x\rVert^2y+x\langle x,y\rangle$.*
5. *$\xi\cdot D\in V_{jk}$ with coordinates $K_{ja}-K_{ka}$, and $\xi\cdot\nu\in\mathcal D_n$ with $\lVert\xi\cdot\nu\rVert^2=4\lVert\nu\rVert^2$. At an angle of the $(j,k)$-rotation minimising $\lVert\nu\rVert^2$, with $D$, $K$ and $x$ those of the rotated tensor: $\langle x,K_{j\cdot}-K_{k\cdot}\rangle=0$, and $\lVert\nu\rVert^2\le\tfrac12\sum_a(K_{ka}-K_{ja})^2$.*
6. *At a diagonal critical point $D$ and $x\perp\mathbf1$, $\theta\langle D,G_x\rangle=\langle L_{G_x}D,D\rangle$, where $\langle D,G_x\rangle=\sum_{a<b}K_{ab}(G_x)_{ab}$ over unordered pairs.*

**Proof.**
1. The fixed space of $\ker(\varepsilon_j\varepsilon_k)$: a four-set character $\chi_Q$ is $-1$ on the flip at an index of $Q\setminus\{j,k\}$, a pair character $\varepsilon_a\varepsilon_b\ne\varepsilon_j\varepsilon_k$ on the flip at an index of $\{a,b\}\setminus\{j,k\}$. Both witnesses lie in $\ker(\varepsilon_j\varepsilon_k)$, and the fixed space of a group of automorphisms is closed under $\circ$. A rotation in the $(j,k)$-plane commutes with every flip outside $\{j,k\}$ and with $\varepsilon_j\varepsilon_k$.
2. $Q=W^2+W^\#$ with $(R^\#)_{ab,ab}=\sum_{c,c'}[R_{ac,ac'}R_{bc,bc'}-R_{ac,bc'}R_{bc,ac'}]$, which reduces to $(S^2)_{ab}$ on diagonal tensors. For $\nu$: $(\nu^2)_{ja,ja}=(\nu^2)_{ka,ka}=x_a^2$; $(\nu^\#)_{ab,ab}=2x_ax_b$ from $\{c,c'\}=\{j,k\}$; $(\nu^\#)_{jk,jk}=-\sum_ax_a^2$ from the second term at $c=c'=a$; every other diagonal entry vanishes, and the off-diagonal part vanishes by character. The norm over unordered pairs is $2\sum x^4+\lVert x\rVert^4+4\sum_{a<b}x_a^2x_b^2=3\lVert x\rVert^4$. *$G_x$ is [Lemma L122](#lemma-l122-the-pair-block-is-a-graph-laplacian-of-the-sectional-matrix)'s pair block read in reverse, which fixes the sign of $K_{jk}$ a second way, with the zero row sums a third.*
3. $V_{jk}$'s equation is $L_D\nu=\tfrac\theta2\nu$, and $\langle L_D\nu,\nu\rangle=\langle D,\nu\circ\nu\rangle$, so $\langle D,G_x\rangle=\tfrac\theta2\lVert\nu\rVert^2$; divide by $\lVert G_x\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$. The $\mathcal D_n$ equation is $D\circ D+G_x=\theta D$, $G_x$ is swap-even, and $(D\circ D)^-=2D^+\circ D^-$.
4. With the diagonal product $(A\circ B)_{ab}=A_{ab}B_{ab}+\tfrac12\sum_c(A_{ac}B_{cb}+B_{ac}A_{cb})$ and $Y_{ja}=y_a$, $Y_{ka}=-y_a$: $(G\circ Y)_{ja}=x_a^2y_a+\tfrac12\big(\lVert x\rVert^2y_a+2x_a(\langle x,y\rangle-x_ay_a)\big)=\tfrac12\lVert x\rVert^2y_a+x_a\langle x,y\rangle$, and the even part of $G\circ Y$ vanishes.
5. $\Lambda^2\xi$ sends $e_{ja}\mapsto e_{ka}$, $e_{ka}\mapsto-e_{ja}$, and $\xi\cdot W=[\Lambda^2\xi,W]$. For diagonal $D$ the commutator has entries $K_{ja}-K_{ka}$ at $(ja,ka)$ and $(ka,ja)$. For $\nu$ it is diagonal with $\mp2x_a$ at $(ja),(ka)$, norm$^2$ $8\lVert x\rVert^2$. Along $e^{\varphi\xi}$ the $V_{jk}$-part is $\nu+\varphi\,\xi\cdot D+\tfrac{\varphi^2}2\xi^2\cdot\nu+O(\varphi^3)$, so $\lVert\nu(\varphi)\rVert^2=\lVert\nu\rVert^2+2\varphi\langle\nu,\xi\cdot D\rangle+\varphi^2(\lVert\xi\cdot D\rVert^2-\lVert\xi\cdot\nu\rVert^2)+O(\varphi^3)$, and a minimum gives both conditions. Restricting to $a\notin\{j,k\}$ matters: the indices $a=j,k$ would add $2K_{jk}^2$ to the sum. The first condition says $\nu$ is orthogonal to the orbit direction $\xi\cdot D$, which is a $\tfrac\theta2$-eigenvector of $L_D$ at a critical point ([diagonal-half.md](diagonal-half.md)).
6. Pair $Q(D)=\theta D$ with $G_x$ and use total symmetry: $\theta\langle D,G_x\rangle=\langle D\circ D,G_x\rangle=\langle L_{G_x}D,D\rangle$. $\square$

**What it gives.** *With $x\perp y$, where $y$ is the odd part's coordinate vector, the swap parity kills $\langle L_{G_x}D^+,D^-\rangle$ and items 4 and 6 turn a pair-block gap at a diagonal critical point, $\langle D,G_x\rangle\le\theta-2\gamma$ over unit $x\perp\mathbf1$ off the orbit direction for a constant $\gamma>0$, into $\langle L_{G_x}D^+,D^+\rangle+\tfrac12\lVert D^-\rVert^2\le\theta^2-2\gamma\theta$.* **That gap is one ingredient of the pair-block stratum, not the stratum**: the stratum also needs the gap to survive the perturbation the critical equations allow, and constants derived for the chain at large $\lVert\nu\rVert$ ([pair-block note](../reviews/2026-09-14-I104-pair-block.md)). *Over all diagonal critical points the gap is false, [post F48](#post-f48-lambda_maxwidetilde-nlethetam_jk-is-false-at-padded-pairs-and-it-was-never-what-the-pair-clause-asked)'s padded $S^6\times S^6$ refuting it, so the stratum is argued at maximisers in the [gap note](../reviews/2026-09-14-I104-pair-gap.md).* **No screen is cited as evidence for any of it.**

## The Lean declarations, docstrings removed

[L224Statement.lean](../lean/HamiltonsCubic/Results/L224Statement.lean):

```lean
import Mathlib

set_option linter.style.longLine false


namespace HamiltonsCubic.L224Statement

theorem two_columns_le {V : Type*} (q : V → ℝ) (nrm : V → ℝ) (lam : ℝ) (hq : ∀ z, q z ≤ lam * nrm z)
    (y x : V) : q y + q x ≤ lam * (nrm y + nrm x) := by
  have := hq y; have := hq x; linarith

theorem two_columns_eq {V : Type*} (q : V → ℝ) (nrm : V → ℝ) (lam : ℝ) (hq : ∀ z, q z ≤ lam * nrm z)
    (y x : V) (h : q y + q x = lam * (nrm y + nrm x)) : q y = lam * nrm y ∧ q x = lam * nrm x := by
  have := hq y; have := hq x; constructor <;> linarith

theorem pair_value_le (PW PE PW' Q lam s Θ : ℝ) (hW : PW = PE + 3 * Q) (hQ : Q ≤ lam * s)
    (hW' : PW' = PE + 3 * (lam * s)) (hL57 : PW' ≤ Θ) :
    PW ≤ Θ ∧ (PW = Θ → Q = lam * s ∧ PW' = Θ) := by
  refine ⟨by linarith, fun h => ⟨by linarith, by linarith⟩⟩

theorem block_form {α β : Type*} [Fintype α] [Fintype β] (z : α ⊕ β → ℝ) (αA αB γ : ℝ)
    (hz : ∑ i, z i = 0) :
    (∑ a : α, z (Sum.inl a) ^ 2 * (αA + γ) + ∑ b : β, z (Sum.inr b) ^ 2 * (γ + αB))
      - γ * (∑ a : α, z (Sum.inl a) ^ 2 + ∑ b : β, z (Sum.inr b) ^ 2)
      + αA * ((∑ a : α, z (Sum.inl a)) ^ 2 - ∑ a : α, z (Sum.inl a) ^ 2)
      + αB * ((∑ b : β, z (Sum.inr b)) ^ 2 - ∑ b : β, z (Sum.inr b) ^ 2)
      + 2 * γ * (∑ a : α, z (Sum.inl a)) * (∑ b : β, z (Sum.inr b))
      = (αA + αB - 2 * γ) * (∑ a : α, z (Sum.inl a)) ^ 2 := by
  rw [Fintype.sum_sum_type] at hz
  have hB : ∑ b : β, z (Sum.inr b) = -∑ a : α, z (Sum.inl a) := by linarith
  rw [hB]
  have e1 : ∑ a : α, z (Sum.inl a) ^ 2 * (αA + γ) = (αA + γ) * ∑ a : α, z (Sum.inl a) ^ 2 := by
    rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun a _ => by ring
  have e2 : ∑ b : β, z (Sum.inr b) ^ 2 * (γ + αB) = (γ + αB) * ∑ b : β, z (Sum.inr b) ^ 2 := by
    rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun b _ => by ring
  rw [e1, e2]
  ring

theorem sub_lt_of_mass (PE Θ e s : ℝ) (hΘ : 0 < Θ) (he : 0 ≤ e) (hes : e ^ 2 = 1 - 2 * s) (hs : 0 < s)
    (hP : PE ≤ Θ * e ^ 3) : PE < Θ := by
  have he1 : e < 1 := by nlinarith
  have h3 : e ^ 3 ≤ e ^ 2 := by nlinarith [sq_nonneg e]
  have h2 : e ^ 2 < 1 := by linarith
  nlinarith

example : (1 : ℝ) ≤ 1 ∧ ((1 : ℝ) = 1 → (0 : ℝ) = 1 * 0 ∧ (1 : ℝ) = 1) :=
  pair_value_le 1 1 1 0 1 0 1 (by norm_num) (by norm_num) (by norm_num) le_rfl

end HamiltonsCubic.L224Statement
```

[L223Statement.lean](../lean/HamiltonsCubic/Results/L223Statement.lean):

```lean
import Mathlib

set_option linter.style.longLine false


namespace HamiltonsCubic.L223Statement

open Finset

variable {ι : Type*} [Fintype ι]

theorem fourth_moment_defect (v : ι → ℝ) (hn : 0 < (Fintype.card ι : ℝ)) (h2 : ∑ i, v i ^ 2 = 1) :
    ∑ i, (v i ^ 2 - 1 / (Fintype.card ι : ℝ)) ^ 2 = ∑ i, v i ^ 4 - 1 / (Fintype.card ι : ℝ) := by
  have e : ∀ i, (v i ^ 2 - 1 / (Fintype.card ι : ℝ)) ^ 2
      = v i ^ 4 - 2 / (Fintype.card ι : ℝ) * v i ^ 2 + 1 / (Fintype.card ι : ℝ) ^ 2 := fun i => by ring
  simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, h2,
    Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  field_simp
  ring

theorem Z_norm_sq (v : ι → ℝ) (n : ℝ) (hn3 : 3 < n)
    (h1 : ∑ i, v i = 0) (h2 : ∑ i, v i ^ 2 = 1) :
    (∑ i, ∑ j, (v i * v j + (v i ^ 2 + v j ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v j)
      - ∑ i, (v i * v i + (v i ^ 2 + v i ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v i
      = 2 * ((n ^ 2 - 3 * n + 3) / (2 * (n - 1) * (n - 2)) - n / (2 * (n - 2)) * ∑ i, v i ^ 4) := by
  have hn2 : n - 2 ≠ 0 := by linarith
  have hn1 : n - 1 ≠ 0 := by linarith
  have inner : ∀ i, ∑ j, (v i * v j + (v i ^ 2 + v j ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v j
      = v i ^ 2 * (∑ j, v j ^ 2) + v i ^ 3 / (n - 2) * (∑ j, v j) + v i / (n - 2) * (∑ j, v j ^ 3)
        - v i / ((n - 1) * (n - 2)) * (∑ j, v j) := by
    intro i
    calc ∑ j, (v i * v j + (v i ^ 2 + v j ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v j
        = ∑ j, (v i ^ 2 * v j ^ 2 + v i ^ 3 / (n - 2) * v j + v i / (n - 2) * v j ^ 3
            - v i / ((n - 1) * (n - 2)) * v j) :=
          Finset.sum_congr rfl fun j _ => by field_simp; ring
      _ = _ := by
          rw [Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.mul_sum,
            Finset.mul_sum, Finset.mul_sum, Finset.mul_sum]
  have h3 : ∑ i, ∑ j, (v i * v j + (v i ^ 2 + v j ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v j
      = 1 := by
    rw [Finset.sum_congr rfl fun i _ => inner i]
    simp only [h1, h2, mul_zero, mul_one, add_zero, sub_zero, Finset.sum_add_distrib, ← Finset.sum_mul,
      ← Finset.sum_div, zero_div, zero_mul]
  have h4 : ∑ i, (v i * v i + (v i ^ 2 + v i ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v i
      = (1 + 2 / (n - 2)) * ∑ i, v i ^ 4 - 1 / ((n - 1) * (n - 2)) := by
    have : ∀ i, (v i * v i + (v i ^ 2 + v i ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v i
        = (1 + 2 / (n - 2)) * v i ^ 4 - 1 / ((n - 1) * (n - 2)) * v i ^ 2 := fun i => by ring
    simp only [this, Finset.sum_sub_distrib, ← Finset.mul_sum, h2, mul_one]
  rw [h3, h4]
  field_simp
  ring

theorem coord_bound (a c : ℝ) (ha : 0 ≤ a) (hc : 0 < c) : |a - c| ≤ |a ^ 2 - c ^ 2| / c := by
  rw [le_div_iff₀ hc, show a ^ 2 - c ^ 2 = (a - c) * (a + c) by ring, abs_mul,
    abs_of_nonneg (by linarith : 0 ≤ a + c)]
  exact mul_le_mul_of_nonneg_left (by linarith) (abs_nonneg _)

theorem chain_defects (Θ lam μ r c η e : ℝ) (hΘ : 0 < Θ) (hμ : 0 < μ) (hr0 : 0 ≤ r) (hr1 : r ≤ 1)
    (hc0 : 0 ≤ c) (hc1 : c ≤ 1) (hη : 0 ≤ η)
    (hchain : lam ≤ Θ * r * c - η / μ + e / μ) :
    1 - c ≤ (Θ - lam + e / μ) / Θ ∧ 1 - r ≤ (Θ - lam + e / μ) / Θ ∧ η ≤ μ * (Θ - lam + e / μ) := by
  have hημ : 0 ≤ η / μ := div_nonneg hη hμ.le
  have hrc : r * c ≤ c := by nlinarith
  have hrc' : r * c ≤ r := by nlinarith
  have key : Θ * (1 - r * c) + η / μ ≤ Θ - lam + e / μ := by nlinarith
  refine ⟨?_, ?_, ?_⟩
  · rw [le_div_iff₀ hΘ]; nlinarith
  · rw [le_div_iff₀ hΘ]; nlinarith
  · have h1 : η / μ ≤ Θ - lam + e / μ := by nlinarith
    have := mul_le_mul_of_nonneg_left h1 hμ.le
    rwa [mul_div_cancel₀ η hμ.ne'] at this

theorem cube_le (s μ : ℝ) (hs : s ≤ μ) : s ^ 3 ≤ μ * s ^ 2 := by
  nlinarith [sq_nonneg s]

theorem mu_lower (lam μ E P : ℝ) (hP : P ≤ 2 * μ) (hPE : lam - E ≤ P) : (lam - E) / 2 ≤ μ := by
  linarith

theorem one_sub_sq_le (r : ℝ) : 1 - r ^ 2 ≤ 2 * (1 - r) := by
  nlinarith [sq_nonneg (1 - r)]

theorem Zstar_theta (n : ℝ) (hn : 2 < n) :
    ((n - 1) / n) ^ 2 * 4 * ((n - 2) / (2 * (n - 1))) = 2 * (n - 1) * (n - 2) / n ^ 2 := by
  have : n - 1 ≠ 0 := by linarith
  have : n ≠ 0 := by linarith
  field_simp
  ring

theorem radius_constant (n : ℝ) (hn : 2 < n) :
    (4 * (2 * (n - 2) ^ 2 / (n - 1))) / ((n - 2) / (2 * (n - 1))) = 16 * (n - 2) := by
  have : n - 1 ≠ 0 := by linarith
  have : n - 2 ≠ 0 := by linarith
  field_simp
  ring

theorem theta_gap_odd (n : ℝ) (hn : 2 < n) :
    2 * (n - 1) * (n - 2) / n ^ 2 - 2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))
      = 8 * (n - 1) / (n ^ 2 * (n + 1) * (n - 2)) := by
  have : n - 2 ≠ 0 := by linarith
  have : n + 1 ≠ 0 := by linarith
  have : n ≠ 0 := by linarith
  field_simp
  ring

theorem unit_diff_le {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] (x y : E) (hx : x ≠ 0)
    (hy : y ≠ 0) : ‖‖x‖⁻¹ • x - ‖y‖⁻¹ • y‖ ≤ 2 * ‖x - y‖ / ‖x‖ := by
  have hxn : 0 < ‖x‖ := norm_pos_iff.mpr hx
  have hyn : 0 < ‖y‖ := norm_pos_iff.mpr hy
  have split : ‖x‖⁻¹ • x - ‖y‖⁻¹ • y = ‖x‖⁻¹ • (x - y) + (‖x‖⁻¹ - ‖y‖⁻¹) • y := by
    rw [smul_sub, sub_smul]; abel
  have t1 : ‖‖x‖⁻¹ • (x - y)‖ = ‖x - y‖ / ‖x‖ := by
    rw [norm_smul, norm_inv, norm_norm, inv_mul_eq_div]
  have t2 : ‖(‖x‖⁻¹ - ‖y‖⁻¹) • y‖ = |‖y‖ - ‖x‖| / ‖x‖ := by
    rw [norm_smul, Real.norm_eq_abs, show ‖x‖⁻¹ - ‖y‖⁻¹ = (‖y‖ - ‖x‖) / (‖x‖ * ‖y‖) by
      field_simp, abs_div, abs_of_pos (mul_pos hxn hyn)]
    field_simp
  have t3 : |‖y‖ - ‖x‖| ≤ ‖x - y‖ := by
    rw [abs_sub_comm]; exact abs_norm_sub_norm_le x y
  calc ‖‖x‖⁻¹ • x - ‖y‖⁻¹ • y‖ ≤ ‖‖x‖⁻¹ • (x - y)‖ + ‖(‖x‖⁻¹ - ‖y‖⁻¹) • y‖ := by
        rw [split]; exact norm_add_le _ _
    _ = ‖x - y‖ / ‖x‖ + |‖y‖ - ‖x‖| / ‖x‖ := by rw [t1, t2]
    _ ≤ ‖x - y‖ / ‖x‖ + ‖x - y‖ / ‖x‖ := by gcongr
    _ = 2 * ‖x - y‖ / ‖x‖ := by ring

theorem balanced_split (p q : ℤ) (h : |p - q| < 2) (hpar : Even (p + q)) : p = q := by
  obtain ⟨k, hk⟩ := hpar
  rw [abs_lt] at h
  omega

theorem split_le (pq s d : ℝ) (hs : 0 < s) (hsum : |pq / s| ≤ s * d) : |pq| ≤ s ^ 2 * d := by
  rw [abs_div, abs_of_pos hs, div_le_iff₀ hs] at hsum
  nlinarith

example : 1 - (1 : ℝ) ≤ (1 - 1 / 2 + 0 / 1) / 1 ∧ 1 - (1 : ℝ) ≤ (1 - 1 / 2 + 0 / 1) / 1 ∧
    (0 : ℝ) ≤ 1 * (1 - 1 / 2 + 0 / 1) :=
  chain_defects 1 (1 / 2) 1 1 1 0 0 one_pos one_pos zero_le_one le_rfl zero_le_one le_rfl le_rfl
    (by norm_num)

end HamiltonsCubic.L223Statement
```

## What to attack, every item answered in writing, including "no finding"

**Read each written chain link by link before deriving anything: does each step follow from the one above and from the hypotheses actually stated?**

**Claim A (L224).**
1. *Step 1.* Is every element of $\mathcal D_n$ exactly $E+D^-_y$ with $E$ swap-even and $D^-_y$ as defined, and is $D^-_y\in\mathcal D_n$ exactly when $\sum y=0$? Is $\nu_x$ swap-fixed? Are the norms $2\lVert y\rVert^2$, $2\lVert x\rVert^2$ right in the unordered convention?
2. *Step 2.* Recompute $D^-_y\circ D^-_y$ from the product formula in Given 3, every entry class, and compare with $G_y$ in the same normalisation as L222's $\nu\circ\nu=G_x$. A factor of $2$ between the two squares would break the Gram structure: check it.
3. *Step 3.* List every term of $T(W,W,W)$ for $W=E+D^-_y+\nu_x$ with its multinomial coefficient, and for each vanishing term name the mechanism (swap parity or character) and check that the mechanism applies. Is the swap an automorphism of $Q$ and of $T$? Does total symmetry of $T$ hold in this record's normalisation?
4. *Step 4.* Is $q_E$ a quadratic form on $\{\sum z=0\}$, is $q_E(y)+q_E(x)\le\lambda s$ right, is $W'$ unit and diagonal, and does L57 apply to it as stated (any unit diagonal tensor, not only critical points)?
5. *Step 5, equality.* Does $P(W')=\Theta_n$ force $W'$ to be an L57 maximiser in these coordinates, including at odd $n$? Is the claim "$j,k$ in one block makes $B'$ swap-even" right? Recompute $q_{B'}(z)$ for a block-constant $B'$ with $j\in A$, $k\in B$, including unbalanced blocks at odd $n$, and check the rank-one form and the positivity argument $\lambda>0$. Check the rotation action read from L222's item 5, the factor $2\varphi$, and that the conclusion "$W=e^{\varphi\xi}\cdot W'$" follows. Check the converse.
6. *Scope.* Is $n\ge4$ enough everywhere (at $n=4$ the space $\{\sum z=0\}$ in $\mathbb R^2$ is a line)? Is anything used that holds only at critical points? Does "What it gives" follow: a global maximiser of $P$ on $\mathcal W_n$ lying in some $\mathcal D_n\oplus V_{jk}$ is a sphere product in another frame?
7. *Counterexample hunt, by structure.* Name the object that would falsify the supremum (a unit $W\in\mathcal S_{jk}$ with $P(W)>\Theta_n$) and try the structured candidates: padded $W_{\mathbb{CP}^2}$ placed so it meets $V_{jk}$, padded products with $j,k$ in the padding, and rank-two Gram matrices at the balanced product. A random point is not a test.
8. *Record.* Is the argument already on the record under another name (search by the identity $P(E+D^-+\nu)=P(E)+3\langle E,G_y+G_x\rangle$ and by "rank one"), and does it contradict any recorded value in $\mathcal D_n\oplus V_{jk}$?

**Claim B (L223).**
9. *Step 1.* Recompute the pairing identity with the forcing $E$ and its sign, and $\eta_1\ge0$.
10. *Step 2.* Recompute $\lvert Z(v)\rvert^2$ from the three sums quoted, and $\frac{n-1}n\cdot2Z_*=\bar\Theta$.
11. *Step 3.* Check $\langle S\circ S,S\rangle\le2\mu$ term by term, $s_{ij}\le\mu$, and $e_-\le\sqrt2\lvert E\rvert$ in the stated norms.
12. *Steps 4 and 5.* Check each inequality, the Lipschitz bound for $(v_iv_j)$ at unit vectors, the invariance argument that $\Pi(w_iw_j)$ is a multiple of a sphere product's vertex matrix, the nonvanishing and $p,q\ge2$, the sign of $B$, and the constant $4\sqrt{n-2}$.
13. *Scope.* Odd $n$, $n=4$, $\ker S\ne0$, and whether "What it gives" overclaims.

**Lean.** For each file, does each declaration state what its docstring and the lemma use it for, or something weaker? Any vacuous hypothesis?

## Report and log

Write your report to `reviews/REVIEW_rN.md` with a claim table first (one row per numbered item, verdict in capitals), a one-line summary, then a section per item with the derivation. **Commit a skeleton report in your first phase** (title, the claim table with every verdict NOT REACHED, the log path) with `git add reviews/REVIEW_rN.md` then `git commit -m "review(L224): rN skeleton" -- reviews/REVIEW_rN.md`, and update it as each phase lands. Commit only your own report, by pathspec. **Do not edit reviews/INDEX.md or any findings file.** Log to `agent_logs/review-rN.log`: first line with your PID and phase plan, a line at every phase transition, a heartbeat at least every three minutes carrying live state including any finding the moment you have it, and a closing line opening with `DONE` or `FAILED`, as the last line of the file.
