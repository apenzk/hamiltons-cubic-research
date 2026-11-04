# Gate 2 brief, the reduction at I121's small-mass node: above $\sqrt{3/2}$ the value lives in the visible and diagonal parts

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28d-I121-smallmass-direct.md](2026-09-28d-I121-smallmass-direct.md) as it stands at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions, reading the written chain link by link; compute only to refute or to check a value, the smallest computation that does it (numpy under `sage -python`). A run of a few minutes on objects you construct is allowed; no sweeps or open-ended searches. **Screens are screens, not evidence for a positive claim.**

## Definitions

- $\mathcal W_n$: algebraic Weyl tensors as symmetric operators on $\Lambda^2\mathbb R^n$ in the orthonormal basis $e_{ab}$, Hilbert–Schmidt norm, $Q(R)=R^2+R^\#$ with Hamilton's $\#$ normalised by $I^\#=(n-2)I$, $P(W)=\langle Q(W),W\rangle$. A unit critical point has $Q(W)=\theta W$, $\lVert W\rVert=1$, $\theta=P(W)$. $\lambda_k$ are the eigenvalues of $W$ on $\Lambda^2$.
- In a frame, $W=A+B_p+B_f$ (diagonal, pair, four-set parts), $a_e$ the diagonal entry on the edge $e$, $t^2=\lVert A\rVert^2$. For disjoint edges $e=\{i,j\}$, $f=\{k,l\}$: $J_{ef}=W_{ij,kl}$ and $X_{ef}=\tfrac12(W_{ik,jl}+W_{il,jk})$. A rectangle $R$ is three disjoint edges. $\theta_0(n)$ is the balanced product's value, $\Theta_n$ the diagonal maximum.

## Givens

- **[L198](../findings/bounds.md)** (Gate 2, r840, r841): *at every critical point of unit norm, $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1-\lambda_k^2$ at every $k$, hence $\theta\lambda_{\max}\le1$.*
- **The whole of $P$ at pair-free $W$** (Gate 2, [r1846](REVIEW_r1846.md), [r1847](REVIEW_r1847.md), CONFIRMED): $P(W)=P(A)+3\sum_{(e,f)}(\tfrac32J_{ef}^2-2X_{ef}^2)(a_e+a_f)+\sum_R(9JJJ+24XXX)_R$, and $\mathop{\mathrm{tr}}B_f^3=6\sum_RJ_{12}J_{13}J_{23}$.
- **The matching inequality** (Gate 2, [r1836](REVIEW_r1836.md), [r1837](REVIEW_r1837.md)): in a globally maximal frame every perfect matching $M$ satisfies $E(M)+\sum(x^e_k+x^e_l)^2+\tfrac14\sum s_{ef}^2\le t^2-\sum_{e\in M}a_e^2$, with $E(M)=\sum_{e<f\in M}4X_{ef}^2$. Per four-set block, $\sum_\pi4X_\pi^2=\tfrac32\lVert\nu_Q\rVert^2$ over its three pairings.
- **L57**: $P(D)\le\Theta_n\lVert D\rVert^3$ on diagonal Weyl tensors.

## The claims

## The reduction: above $\sqrt{3/2}$, the value lives in the visible and diagonal parts (after Gate 2 dispatch, unreviewed)

**Claim 1 (frame-free).** *Put $E(W)=P(W)-\tfrac32\mathop{\mathrm{tr}}W^3=\langle W^\#,W\rangle-\tfrac12\mathop{\mathrm{tr}}W^3$, an $O(n)$-invariant cubic. At every unit critical point, $\theta^2\le\tfrac32+\theta\,E(W)$. So $\theta>\sqrt{3/2}$ forces $E(W)>0$, and $\theta\ge\theta_0(n)$ forces $E(W)\ge\varepsilon_n:=\theta_0-\tfrac3{2\theta_0}$*, which is $0.02247$ at $n=12$ and tends to $\sqrt2-\tfrac3{2\sqrt2}=0.35355$. **Proof.** $\mathop{\mathrm{tr}}W^3=\sum\lambda_k^3\le\lambda_{\max}\sum\lambda_k^2=\lambda_{\max}$, as $\lambda^3\le\lambda_{\max}\lambda^2$ termwise with $\lambda_{\max}\ge0$ from $\mathop{\mathrm{tr}}W=0$, and $\theta\lambda_{\max}\le1$ is [L198](../findings/bounds.md). So $\theta=\tfrac32\mathop{\mathrm{tr}}W^3+E\le\tfrac3{2\theta}+E$. The threshold is the root of $\theta^2-\theta E-\tfrac32=0$, increasing in $E$. $\square$

**Claim 2 (the invariant in a frame, at pair-free $W=A+B_f$).**
$$E(W)=\Big[P(A)-\tfrac32\mathop{\mathrm{tr}}A^3\Big]-6\sum_{(e,f)}(a_e+a_f)X_{ef}^2+24\sum_RX_{12}X_{13}X_{23},$$
*every $J$ cancelling.* **Proof.** $\mathop{\mathrm{tr}}W^3=\mathop{\mathrm{tr}}A^3+3\mathop{\mathrm{tr}}(AB_f^2)+\mathop{\mathrm{tr}}B_f^3$, since $\mathop{\mathrm{tr}}(A^2B_f)=0$ ($B_f$ has zero diagonal), and $\mathop{\mathrm{tr}}(AB_f^2)=\sum_ea_e\sum_{f\cap e=\emptyset}W_{e,f}^2=\sum_{(e,f)}(a_e+a_f)J_{ef}^2$. Subtract $\tfrac32$ of it from the whole-$P$ formula above: the $J^2$ terms cancel ($3\cdot\tfrac32-\tfrac32\cdot3=0$), and $\tfrac32\mathop{\mathrm{tr}}B_f^3$ cancels against $P(B_f)$'s. $\square$ **Check**: $E(W)=-26.1123208173$ both ways at $n=6$ and $-212.9753387454$ at $n=8$ on the random pair-free tensor above.

**So at pair-free small mass, a value above $\theta_0$ needs $E\ge\varepsilon_n$ from three sources**: the diagonal term, of size $O(t^3)$; the coupling $-6\sum(a_e+a_f)X^2$, at most $\tfrac32\sqrt{3(n-3)}\,t^2$ by Cauchy–Schwarz with the matching inequality ($\sum_fX_{ef}^2\le\tfrac{n-3}4t^2$ for each $e$, $\sum_{e,f}X_{ef}^2=\tfrac34\lVert B_f\rVert^2$); and **the visible cubic $24\sum_RXXX$**, which per matching is $P(D_M)$ for the diagonal tensor $D_M$ of the $\tfrac\pi4$-rotated visible part (the triangle sum of its cross pairs, the cubes cancelling in each block), so $\lvert\cdot\rvert\le\Theta_nE(M)^{3/2}$ matching by matching (checked at $n=8$ on one matching of the random four-set tensor: $P(D_M)=3.8260460188=24\sum_{R\subset M}XXX$ and $\lVert D_M\rVert^2=E(M)=7.5828792132$, $D_M$ with zero row sums). **The invisible part of $B_f$ is spent entirely by L198**, which is where $\sqrt{3/2}$ comes from. *What is open is the visible cubic*: summed over matchings with each $E(M)\le t^2$, the bound is order $nt$, and a proof has to show that a critical point cannot spread product-like visible patterns over a $\tfrac1{cn}$ fraction of all matchings at once.

**Screen (after dispatch).** *Descent on the $\tfrac\pi4$ matching family plus the first-order condition of $t^2$, six starts on the product at $n=8$ under caps $0.3$ and $0.2$, found no frame satisfying both: the near-critical frames sit near minima of $t^2$ ($t^2=0.005$ to $0.016$, $\lvert\nabla t^2\rvert\le0.044$) and fail the matching family by $0.088$ to $0.102$. Eighty steps of a penalised descent, so a screen.*

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| $\mathop{\mathrm{tr}}W^3\le\lambda_{\max}$ | `sum_cube_le` in SmallMassE.lean | the power-sum inequality, given the spectrum |
| $\theta^2\le\tfrac32+\theta E$ | `crit_E_bound` | the scalar step from $\theta=\tfrac32T+E$, $T\le\lambda$, $\theta\lambda\le1$ |
| the threshold $\varepsilon_n$ | `crit_E_lt` | $E<\theta_0-\tfrac3{2\theta_0}$ forces $\theta<\theta_0$ |
| every $J$ cancels | `E_pair_coeff`, `E_rect_coeff` | the coefficient cancellation |
| L198 on the operators, $\mathop{\mathrm{tr}}W^3$ as a spectral sum, the frame expansion of $\mathop{\mathrm{tr}}W^3$ | none: the spectral theorem on $\Lambda^2$ is not in the layer | check the prose |
| the three-source estimates and the visible cubic as $P(D_M)$ | none: sums over matchings are prose | check the counting |
| the screen | none: a screen | check it claims nothing positive |

## What to attack

1. Claim 1: is $E$ invariant, is $\mathop{\mathrm{tr}}W^3\le\lambda_{\max}$ right with $\lambda_{\max}\ge0$, and does L198 apply as used? Is the threshold $\varepsilon_n$ right, including its values at $n=12$ and in the limit?
2. Claim 2: the expansion of $\mathop{\mathrm{tr}}W^3$ at pair-free $W$, including $\mathop{\mathrm{tr}}(A^2B_f)=0$ and $\mathop{\mathrm{tr}}(AB_f^2)=\sum(a_e+a_f)J_{ef}^2$, and the cancellation.
3. The three sources: the coupling estimate's Cauchy–Schwarz and matching-inequality steps (including $\sum_fX_{ef}^2\le\tfrac{n-3}4t^2$), and the visible cubic per matching as $P(D_M)$ for a diagonal Weyl tensor $D_M$ with $\lVert D_M\rVert^2=E(M)$.
4. Whether the section claims more than it shows, in particular about what remains open.
