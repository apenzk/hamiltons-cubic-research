# Gate 2 brief, the product foothold and the knapsack reading of (MG), for I121 (route R53)

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28-LIT-step8-sweep.md](2026-09-28-LIT-step8-sweep.md) as it stands at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions; compute only to refute, the smallest computation that does it, saying why an argument could not (numpy is available under `sage -python`). A run of a few minutes on objects you construct is allowed; no sweeps, censuses or open-ended searches.

## Definitions

- $\mathcal W_n$ is the space of algebraic Weyl tensors, viewed as symmetric operators on $\Lambda^2\mathbb R^n$ with the Hilbert–Schmidt inner product. $Q(R)=R^2+R^\#$, $P(W)=\langle Q(W),W\rangle$, $L_WX=Q(W,X)$ the polarisation, so $P(W)=\langle L_WW,W\rangle$ and $\langle L_XY,Z\rangle$ is totally symmetric. A unit critical point has $Q(W)=\rho W$ (here the record's $\theta$). $\Theta_n=\max P$ on the unit sphere of $\mathcal W_n$.
- In an orthonormal frame, $\mathcal D_n$ is the subspace of operators diagonal in the pair basis $e_i\wedge e_j$, $\pi_{\mathcal D}$ the orthogonal projection, $A=\pi_{\mathcal D}W$, $B=W-A$, $t=\lVert A\rVert$, $b=\lVert B\rVert$, $a=\langle L_AB,B\rangle$, $a_{ij}=W(e_i\wedge e_j,e_i\wedge e_j)$. A frame is **globally maximal** when it maximises $\lVert\pi_{\mathcal D}(g\cdot W)\rVert^2$ over $g\in O(n)$.
- **(MG)**: $\rho\le\max\{\sqrt{3/2},P(A)/\lVert A\rVert^3\}$ in a globally maximal frame.

## Givens, each stated in full

- **[L214](../findings/second-order.md)** (Gate 2 passed, proved in Lean). In any orthonormal frame, with $D=\pi_{\mathcal D}W$, $N=W-D$, **$t_{214}=\lVert D\rVert^2$** (the square of this brief's $t$) and $a=\langle D\circ N,N\rangle$, at a unit critical point:
$$\theta\,t=P(D)+a,\qquad\theta\,(1-t)=2a+P(N),$$
**and if in addition $L_W\le\tfrac\theta2$ on $W^\perp$, which [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement) gives at every GLOBAL maximiser, and at a local one with $\theta>0$, then**
$$a\ \ge\ \tfrac\theta2\,t(1-t),\qquad\text{equivalently}\qquad P(D)\ \le\ \tfrac\theta2\,t(1+t).$$
- **[L120](../findings/second-order.md)** (Gate 2 passed, Lean): $\mathcal W_n=\mathcal D_n\oplus\bigoplus V_{ijkl}\oplus\bigoplus V_{jk}$, the isotypic summands of the diagonal sign group $\Gamma$, and at every diagonal $M$ the operator $L_M$ preserves each summand.
- **The one-plane bound** (Gate 2 passed, [r1797](REVIEW_r1797.md), [r1798](REVIEW_r1798.md)), from the note [2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md): **One plane, exactly.** A rotation by $\varphi$ in the plane $(i,j)$ moves only the diagonal entries $a_{ik},a_{jk}$ and the pair-block profile $x_k=W_{ik,jk}$ of character $\chi_{ij}$, and with $\delta_k=\tfrac12(a_{ik}-a_{jk})$ the diagonal mass changes by $2\sum_k\big[(\cos2\varphi\,\delta_k-\sin2\varphi\,x_k)^2-\delta_k^2\big]$. Global frame maximality against every such rotation is therefore exactly $\langle\delta,x\rangle=0$ and $\lVert x\rVert\le\lVert\delta\rVert$, so $\lVert B_{ij}\rVert^2=2\lVert x\rVert^2\le\tfrac12\sum_{k}(a_{ik}-a_{jk})^2$ for every pair block, $B_{ij}$ being the $\chi_{ij}$ component in the Hilbert–Schmidt norm and $x_k=W(e_i\wedge e_k,e_j\wedge e_k)$ in wedge order ([r1797](REVIEW_r1797.md) O1, O2). *The rotation moves more of the operator than these entries; the diagonal mass depends on these alone.*
- **The double-rotation inequality** (Gate 2 passed, same audit), from the same note: Fix four indices, written $1,2,3,4$, and rotate by $\theta_1$ in the plane $(1,2)$ and by $\theta_2$ in the plane $(3,4)$. On $\mathop{\mathrm{span}}\{e_{13},e_{14},e_{23},e_{24}\}\cong\mathbb R^2\otimes\mathbb R^2$ write the $4\times4$ block of $W$ in the products of $I$, $Z=\mathop{\mathrm{diag}}(1,-1)$, $X=\left(\begin{smallmatrix}0&1\\1&0\end{smallmatrix}\right)$ and $J\otimes J$. Conjugation rotates the $(Z,X)$ pair in each factor by twice the angle and fixes $I$ and $J\otimes J$, and the diagonal mass of the block is $4(\alpha_{II}^2+\alpha_{IZ}^2+\alpha_{ZI}^2+\alpha_{ZZ}^2)$. **The four-set block enters only through $\alpha_{XX}=\tfrac12(W_{13,24}+W_{14,23})$, and it trades with $\alpha_{ZZ}=\tfrac14\square$, $\square=a_{13}-a_{14}-a_{23}+a_{24}$, the rectangle difference of the diagonal.** At $\theta_1=\theta_2=\tfrac\pi4$ the two exchange completely, and the whole change of the diagonal mass is, exactly,
$$(v+w)^2-\tfrac14\square^2+\big[(x^{34}_1+x^{34}_2)^2-(\delta^{34}_1+\delta^{34}_2)^2\big]+\big[(x^{12}_3+x^{12}_4)^2-(\delta^{12}_3+\delta^{12}_4)^2\big]+2\sum_{m\ge5}\big[(x^{12}_m)^2-(\delta^{12}_m)^2+(x^{34}_m)^2-(\delta^{34}_m)^2\big],$$
with $v=W_{13,24}$, $w=W_{14,23}$, $x^{ij}_m=W_{im,jm}$ and $\delta^{ij}_m=\tfrac12(a_{im}-a_{jm})$. **In a frame that globally maximises the diagonal mass this is $\le0$**, so $(v+w)^2$ is bounded by $\tfrac14\square^2$ plus pair-block slack. The other two pairings of $\{1,2,3,4\}$ bound $u-w$ and $-(u+v)$ ($u=W_{12,34}$) the same way. **Exactly, under Bianchi $u-v+w=0$: $(v+w)^2+(u-w)^2+(u+v)^2=3(u^2+v^2+w^2)$** ([r1798](REVIEW_r1798.md)), so the three pairings bound the whole four-set block's norm; without Bianchi the three forms have rank two, their common kernel $(1,-1,1)$ being the direction Bianchi removes ([r1797](REVIEW_r1797.md) O6).
- **The spectrum of $L_e$ per character at a sphere product** (the outside author's Proposition 25.1, rebuilt and CONFIRMED where used by [r1801](REVIEW_r1801.md) and [r1802](REVIEW_r1802.md)), with $e$ the unit Weyl tensor of $S^p\times S^q$ in its own frame, $Q(e)=de$, $c_*=d\tfrac{n-2}{2(p-1)(q-1)}$, $\tau_P=d\tfrac{p-2}{2(p-1)}$, factors $P$ and $Q'$. Multiplicities as the author states them:

| character | spectrum of $L_e$ there |
|---|---|
| pair block $\chi_{ij}$, $i,j$ in one factor $P$ | $0$, $-c_*$, $\tau_P$, with multiplicities $p-3$, $q-1$, $1$ |
| pair block, $i\in P$, $j\in Q'$ | $0$, and $d/2$ on the orbit line |
| four-set with $r\ne2$ indices in $P$ | $0$ |
| four-set split $2+2$, $\{i,j\}\subset P$, $\{k,l\}\subset Q'$ | $\pm c_*$, eigenvectors $(u,v,w)\propto(2,1,-1)$ for $+c_*$ and $(0,1,1)$ for $-c_*$ |

with $u=W_{ij,kl}$, $v=W_{ik,jl}$, $w=W_{il,jk}$, Bianchi $u-v+w=0$.
- $\dim\mathcal D_n=\tfrac{n(n-3)}2$ and $\dim\mathcal W_n=\tfrac{n(n-3)(n+1)(n+2)}{12}$ ([conventions.md](../findings/conventions.md)).
- [F67](../findings/fence-posts.md): bounding $P(d)\le\Theta_n$ and $\langle L_d\nu,\nu\rangle\le\Lambda_n$ separately in L214's unit identity $\theta=\sqrt{t_{214}}P(d)+\tfrac{1-t_{214}}{\sqrt{t_{214}}}\langle L_d\nu,\nu\rangle$, with $\Lambda_n$ the supremum over all diagonal unit $d$ and unit $\nu\perp\mathcal D_n$, never beats $\Theta_n$, because the orbit direction $\mathrm{ad}_{E_{kl}}W_0$ is a $\tfrac12$-eigenvector of $L_e$ at the balanced product and lies in $\mathcal D_n^\perp$.

## The claims

**Agreement, not new.** With $W=A+B$ in the maximal frame, $t=\lVert A\rVert$, $b=\lVert B\rVert$ and $a=\langle L_AB,B\rangle$, [L214](../findings/second-order.md)'s relations are $P(A)=\rho t^2-a$ and $P(B)=\rho b^2-2a$, and its test vector gives $\langle L_WX,X\rangle=\rho t^2b^2-a$ (L214 writes $t$ for the mass $t^2$ here). Hence, for $\rho>\sqrt{3/2}$, **(MG) $\iff P(A)\ge\rho t^3\iff a\le\rho\,t^2(1-t)$**, while L214's cap gives $a\ge\tfrac\rho2t^2(1-t^2)$. *So (MG) is the upper bound on the coupling that the record lacks.* In L214's unit form this is its identity $\rho=t\,P(\hat A)+\tfrac{1-t^2}t\langle L_{\hat A}\nu,\nu\rangle$ with $\hat A=A/t$, $\nu=B/b$, and [F67](../findings/fence-posts.md) is the statement that bounding $\langle L_{\hat A}\nu,\nu\rangle$ by its supremum over all $\nu\perp\mathcal D_n$ never beats $\Theta_n$, **the orbit direction alone carrying $\tfrac12\theta$**. What clears F67 is that the orbit direction is exactly the one the maximal frame's first-order condition removes from $\nu$.

**The general sufficient condition (derived here, unreviewed).** $L_{\hat A}$ preserves each sign character ([L120](../findings/second-order.md)), and its spectrum on each is explicit for every diagonal $\hat A$: the four-set block by [L121](../findings/second-order.md), the pair block by [L122](../findings/second-order.md). Write $y_i$ for $B$'s mass on the $i$-th eigenmode, eigenvalue $\lambda_i$, so $\sum y_i=b^2$ and $a=t\sum\lambda_iy_i$. Then
$$(\mathrm{MG})\iff\sum_i\Big(\lambda_i-\frac{\rho\,t}{1+t}\Big)\,y_i\le0,$$
so (MG) is a knapsack: the modes with $\lambda_i>\rho t/(1+t)$ must carry little mass, and the maximal frame's inequalities are what bound it (the one-plane bound per pair block, the double rotation per four-set, the orbit line removed exactly).

**The foothold: a diagonal part proportional to a product (derived here, unreviewed).** Suppose $\hat A=e$, the unit Weyl tensor of $S^p\times S^q$, $n=p+q$, $p,q\ge2$ and $(p,q)\ne(2,2)$, in its own frame, $Q(e)=de$, $d>0$. *Then $c_*<d$, since $c_*/d<1$ is $(2p-3)(2q-3)>1$, and $S^2\times S^2$ is the one product with $c_*=d$.* The character table of the [closed-branch analysis](2026-09-28-I121-MG-audit.md) (Gate 2, [r1801](REVIEW_r1801.md), [r1802](REVIEW_r1802.md)) gives, **using none of its $C=0$ rows' eigenvector argument**: a pair block inside a factor has $\delta=0$, so the one-plane bound makes $B$ vanish there; a mixed pair block carries $0$ and $\tfrac d2$ on the orbit line, which the first-order condition removes; four-sets inside a factor and split $3+1$ carry $0$; a $2+2$ four-set carries $\pm c_*$, $c_*=d\tfrac{n-2}{2(p-1)(q-1)}$, and its double rotation in the two within-factor planes sees only within-factor pair blocks, which vanish, so it forces $v+w=0$ and $B$ keeps the $+c_*$ mode only. So $a\le t\,c_*\,b^2$. With $P(A)=dt^3$, (MG) reads $\rho\le d$, and the relation $P(A)=\rho t^2-a$ gives
$$\rho\ \le\ d\,t+c_*\,\frac{1-t^2}t .$$
At a global maximiser $\rho=\Theta_n\ge d$, so **either $b=0$ ($W$ is diagonal) or $t\le\dfrac{c_*}{d-c_*}$**, and (MG) holds whenever $t\ge c_*/(d-c_*)$. At the balanced product $p=q=m$, $c_*=\tfrac d{m-1}$ and the threshold is $t\ge\tfrac1{m-2}$. *No closedness is used, so this covers the nonclosed branch at such a diagonal.*

**A corollary from averaging.** The maximal frame carries at least the $O(n)$-average diagonal mass, and by Schur's lemma on the irreducible $\mathcal W_n$ that average is $\dim\mathcal D_n/\dim\mathcal W_n$, so $t^2\ge\tfrac6{(n+1)(n+2)}$, in agreement with the frame average $\tfrac{12}{(n+1)(n+2)}$ of [bispectral.md](../findings/bispectral.md) over ordered pairs. Against the balanced threshold $\tfrac1{(m-2)^2}=\tfrac4{(n-4)^2}$ this wins exactly when $n^2-30n+44\ge0$, **so at even $n\ge30$ a global maximiser whose maximal-frame diagonal part is proportional to the balanced product is diagonal.** Below $n=30$ the case needs a frame lower bound on $t$ stronger than the average.

**What it leaves.** Diagonal parts not proportional to a product, where the pair blocks' $\delta$ is small rather than zero and the one-plane and double-rotation bounds bound masses instead of killing modes. This is the knapsack above with those bounds as its constraints.

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| (MG) at $\rho>\sqrt{3/2}$ is $a\le\rho t^2(1-t)$ | `mg_iff_coupling` in [ProductFoothold.lean](../lean/HamiltonsCubic/Results/ProductFoothold.lean) | the scalar equivalence from $P(A)=\rho t^2-a$ |
| the knapsack form | `coupling_iff_knapsack` | the rearrangement with $a=tS$, $b^2=1-t^2$; **not** the mode decomposition $a=t\sum\lambda_iy_i$, which rests on L120 |
| $a\le t\,c_*\,b^2$ at a product diagonal part | none: it rests on the per-character spectrum and the frame inequalities, which the layer does not state at the operator level; check each character | |
| $\rho\le dt+c_*(1-t^2)/t$ | `value_bound` | from the four scalar facts |
| the dichotomy $b=0$ or $t\le c_*/(d-c_*)$ | `dichotomy` | same, with $d\le\rho$ and $c_*<d$ |
| (MG) above the threshold | `mg_of_threshold` | same |
| the balanced threshold $\tfrac1{m-2}$ | `balanced_threshold` | $c_*=\tfrac d{m-1}$ substituted |
| $t^2\ge\tfrac6{(n+1)(n+2)}$ in a maximal frame | none: Schur's lemma on the $O(n)$-module $\mathcal W_n$, which the layer does not carry; check it | |
| $n\ge30$ suffices at the balanced product | `average_beats_threshold` | $\tfrac4{(n-4)^2}<\tfrac6{(n+1)(n+2)}$ at $n\ge30$ |
| $c_*<d$ off $S^2\times S^2$ | none: one line of algebra; check it | |

## What to attack

1. **The coupling bound $a\le t\,c_*\,b^2$, row by row, with $C$ arbitrary.** For each character, does the stated frame fact force $B$'s component there to vanish, or to lie in eigenspaces of $L_e$ with eigenvalue at most $c_*$? In particular: is the orbit line of a mixed pair block exactly the direction $\langle\delta,x\rangle=0$ removes, and is the rest of that block's spectrum $0$? Does the double rotation for the pairing $(ij\,|\,kl)$, $\{i,j\}\subset P$, $\{k,l\}\subset Q'$, involve only the pair profiles $\chi_{ij}$ and $\chi_{kl}$, and do both vanish? Is summing over characters legitimate, i.e. do cross terms between characters vanish in $\langle L_eB,B\rangle$?
2. **$P(A)=dt^3$ and "(MG) reads $\rho\le d$"**, and $\rho=\Theta_n\ge d$ at a global maximiser.
3. **The value bound and the dichotomy**, including the case $t=1$ and whether $c_*<d$ is needed and sufficient.
4. **The averaging corollary**: is $\mathcal W_n$ irreducible under $O(n)$ at the $n$ used, does the maximal frame carry at least the average mass, is the average $\dim\mathcal D_n/\dim\mathcal W_n$ in the norm in which $t=\lVert A\rVert$, and does $n^2-30n+44\ge0$ exactly mark where it beats $\tfrac1{(m-2)^2}$ at $n=2m$?
5. **The knapsack equivalence**, and whether $a=t\sum_i\lambda_iy_i$ with $\sum_iy_i=b^2$ holds for an eigenbasis of $L_{\hat A}$ on $\mathcal D_n^\perp$.
6. **The F67 clearance**: does removing the orbit direction through the first-order frame condition answer F67's obstruction, or does another direction of eigenvalue near $\tfrac12\rho$ survive (for instance $\tau_P$ in the within-factor pair blocks) that the argument must also remove?
7. **Hypotheses**: every place the argument assumes a global maximiser, a globally maximal frame, $n=p+q$, $d>0$, or $C=0$. Is any used without being stated? Is anything in the claims true only in the closed case?
