# Gate 2 brief, the double-rotation inequality, for I121 (route R52)

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md) as it stands at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions; compute only to refute, the smallest computation that does it, saying why an argument could not.

## Definitions and givens

- Operators are symmetric linear maps $R$ on $\Lambda^2\mathbb R^n$ with the Hilbert–Schmidt norm, in the basis $e_{ab}=e_a\wedge e_b$, $a<b$, of an orthonormal frame; $a_{ab}=R_{ab,ab}$ are the diagonal entries and the **diagonal mass** is $\sum_{a<b}a_{ab}^2$. $g\in O(n)$ acts by $R\mapsto\hat gR\hat g^{\mathsf T}$ with $\hat g=\Lambda^2g$.
- **A frame globally maximises the diagonal mass of $W$** when no $g\in O(n)$ gives $\hat gW\hat g^{\mathsf T}$ a larger diagonal mass in that frame.
- Weyl operators satisfy the first Bianchi identity $W_{12,34}+W_{13,42}+W_{14,23}=0$ and $\operatorname{Ric}=0$.

## The claims

## First attempt at 27.2: the finite-angle inequality in one plane adds nothing, in two planes it reaches the four-set blocks

- **One plane, exactly.** A rotation by $\varphi$ in the plane $(i,j)$ moves only the diagonal entries $a_{ik},a_{jk}$ and the pair-block profile $x_k=W_{ik,jk}$ of character $\chi_{ij}$, and with $\delta_k=\tfrac12(a_{ik}-a_{jk})$ the diagonal mass changes by $2\sum_k\big[(\cos2\varphi\,\delta_k-\sin2\varphi\,x_k)^2-\delta_k^2\big]$. Global frame maximality against every such rotation is therefore exactly $\langle\delta,x\rangle=0$ and $\lVert x\rVert\le\lVert\delta\rVert$, so $\lVert B_{ij}\rVert^2\le\tfrac12\sum_{k}(a_{ik}-a_{jk})^2$ for every pair block.
- **Classified: agreement.** The [2026-09-14 I100 derivation](2026-09-14-I100-derivation.md) states the first-order condition $\langle n_{kl},x^{(kl)}\rangle=0$ per pair block and the general second-order condition, both unused there; the one-plane bound is the second-order condition at a plane rotation. *In one plane the mass is a quadratic form in $(\cos2\varphi,\sin2\varphi)$, so finite angle and second order coincide.*
- **Where finite angle can add information.** A rotation in two planes $(i,j)$ and $(k,l)$ moves the diagonal entries of the six pairs in $\{i,j,k,l\}$ through the four-set block $\chi_{ijkl}$ as well as the pair blocks $\chi_{ij},\chi_{kl}$, and the diagonal mass is a trigonometric polynomial of degree two in each angle, whose maximum over the torus second-order data at the identity does not fix. **This is where the author's open core sits (active weight-four rectangles), and it is the next computation**: the exact two-plane condition on a four-set block in terms of the diagonal and the two pair blocks.

## The double-rotation inequality: frame maximality bounds a four-set block by the diagonal's rectangle difference

**Derived here, screened, owed Gate 2 and Lean.** Fix four indices, written $1,2,3,4$, and rotate by $\theta_1$ in the plane $(1,2)$ and by $\theta_2$ in the plane $(3,4)$. On $\operatorname{span}\{e_{13},e_{14},e_{23},e_{24}\}\cong\mathbb R^2\otimes\mathbb R^2$ write the $4\times4$ block of $W$ in the products of $I$, $Z=\operatorname{diag}(1,-1)$, $X=\left(\begin{smallmatrix}0&1\\1&0\end{smallmatrix}\right)$ and $J\otimes J$. Conjugation rotates the $(Z,X)$ pair in each factor by twice the angle and fixes $I$ and $J\otimes J$, and the diagonal mass of the block is $4(\alpha_{II}^2+\alpha_{IZ}^2+\alpha_{ZI}^2+\alpha_{ZZ}^2)$. **The four-set block enters only through $\alpha_{XX}=\tfrac12(W_{13,24}+W_{14,23})$, and it trades with $\alpha_{ZZ}=\tfrac14\square$, $\square=a_{13}-a_{14}-a_{23}+a_{24}$, the rectangle difference of the diagonal.** At $\theta_1=\theta_2=\tfrac\pi4$ the two exchange completely, and the whole change of the diagonal mass is, exactly,
$$(v+w)^2-\tfrac14\square^2+\big[(x^{34}_1+x^{34}_2)^2-(\delta^{34}_1+\delta^{34}_2)^2\big]+\big[(x^{12}_3+x^{12}_4)^2-(\delta^{12}_3+\delta^{12}_4)^2\big]+2\sum_{m\ge5}\big[(x^{12}_m)^2-(\delta^{12}_m)^2+(x^{34}_m)^2-(\delta^{34}_m)^2\big],$$
with $v=W_{13,24}$, $w=W_{14,23}$, $x^{ij}_m=W_{im,jm}$ and $\delta^{ij}_m=\tfrac12(a_{im}-a_{jm})$. **In a frame that globally maximises the diagonal mass this is $\le0$**, so $(v+w)^2$ is bounded by $\tfrac14\square^2$ plus pair-block slack. The other two pairings of $\{1,2,3,4\}$ bound $u-w$ and $u+v$ (up to sign, $u=W_{12,34}$) the same way, and with Bianchi $u-v+w=0$ the three together control the whole four-set block.

- **Gate 1 (b)**, a second route sharing no algebra: the formula matches the diagonal mass of the conjugated operator to $4\times10^{-14}$ on twenty random symmetric operators on $\Lambda^2\mathbb R^7$ ([screen_I121_double_rotation.py](../scripts/misc/screen_I121_double_rotation.py)). It holds for every symmetric operator; Weyl and criticality are not used.
- **Beyond second order.** At the identity, $\alpha_{XX}$ enters the Hessian only multiplied by $\alpha_{ZZ}$, so second-order frame data sees the four-set block only through the rectangle difference; the finite angle sees $\alpha_{XX}^2$ itself. *This is the content of the author's remark that the finite-angle family retains the rectangles.*
- **Classified.** New to the record: [r353](REVIEW_r353.md)'s and [r760](REVIEW_r760.md)'s observation is the reverse flow, a coordinate-diagonal operator acquiring four-set entries under a two-plane rotation. **At a block-constant diagonal** (a product of spheres in its own frame) with $\{1,2\}$ in one factor and $\{3,4\}$ in the other, every $\delta$ and $\square$ vanish, so the inequality forces $v+w=0$ and every pair profile $x^{12}$, $x^{34}$ to vanish.
- **Next**: its consequence for [I104](../plan.md)'s overlapping four-sets with $\tau>0$, the open core of 27.1, where the closed branch makes $A/t$ a diagonal critical point.

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| the one-plane change $2\sum_k[(\cos2\varphi\,\delta_k-\sin2\varphi\,x_k)^2-\delta_k^2]$ at $\varphi=\pi/4$ | `pair_exchange` in [DoubleRotation.lean](../lean/HamiltonsCubic/Results/DoubleRotation.lean) | the $2\times2$ block's diagonal mass change |
| the one-plane condition at every angle | `one_plane` | $\langle\delta,x\rangle=0$ and $\lVert x\rVert^2\le\lVert\delta\rVert^2$ from the inequality on the unit circle |
| the double-rotation formula, block part | `block_exchange` | the $4\times4$ block's diagonal mass change at $(\pi/4,\pi/4)$ |
| which entries form the blocks, and that nothing else moves | none: the combinatorics of $\Lambda^2$ under two plane rotations; this is what you check by hand | |
| the three pairings controlling the whole four-set block | none: a two-line linear-algebra consequence of Bianchi; check it | |
| "beyond second order" | none: a statement about the Hessian at the identity; check it | |
| the block-constant corollary | none: check it | |

`#print axioms` on all three: `propext`, `Classical.choice`, `Quot.sound`.

## What to attack

1. **Read each written step link by link first.** Is the one-plane diagonal-mass change exactly as stated, for every $\varphi$, and does global maximality give exactly $\langle\delta,x\rangle=0$ and $\lVert x\rVert\le\lVert\delta\rVert$?
2. **The structural half of the double rotation.** Under rotations in the planes $(1,2)$ and $(3,4)$, which bivectors move, and is it true that the only diagonal entries that change are those of $e_{13},e_{14},e_{23},e_{24}$ and of $e_{1m},e_{2m},e_{3m},e_{4m}$ for $m\ge5$, each through the stated blocks? Check the signs of $v$, $w$ and the pair profiles against the orientation $e_{ab}$, $a<b$.
3. **The formula at $(\pi/4,\pi/4)$**: every term, including the factor $\tfrac14$ on $\square^2$ and the factor $2$ on the outside sum.
4. **The three pairings with Bianchi**: do the three moved combinations span the four-set block's two dimensions?
5. **Beyond second order**: is it true that at the identity the four-set combination enters the Hessian only through its product with the rectangle difference?
6. **The block-constant corollary**: with $\{1,2\}$ in one factor and $\{3,4\}$ in the other of a product-of-spheres diagonal, does every $\delta$ and $\square$ vanish, and does the inequality then force $v+w=0$ and the pair profiles to vanish?
7. **The classification**: is the one-plane condition the record's second-order condition from the [2026-09-14 I100 derivation](2026-09-14-I100-derivation.md), and is the double-rotation inequality absent from the record? [r353](REVIEW_r353.md) and [r760](REVIEW_r760.md) are the nearest entries.

## Protocol

- Log to the path in your dispatch: first line your PID and phase plan, a heartbeat at least every three minutes with live state, closing with a line opening `DONE` or `FAILED`.
- Commit a skeleton to your `reviews/REVIEW_rN.md` (already created empty as your claim) in your first phase, every verdict `NOT REACHED`, then overwrite rows. **Do not edit [reviews/INDEX.md](INDEX.md).** Commit only your own files, named after `--`.
