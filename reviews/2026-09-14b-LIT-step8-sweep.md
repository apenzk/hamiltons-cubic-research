# Step 9 sweep, 2026-09-14b, the far region of route R25

**On Fable, from [2026-09-14b-step8-position.md](2026-09-14b-step8-position.md) alone.** Appended after every batch.

## Batch 1, the five directions against the literature, one query each

| direction | what the search returned | verdict |
| --- | --- | --- |
| 1. joint statistics, cubic with one quadratic constraint | the S-lemma and its generalisations ([Tuy and Tuan, JOGO 2013](https://link.springer.com/article/10.1007/s10898-012-9917-0); [exactness of dual Lagrangian bounds for QCQP, JOGO 2026](https://link.springer.com/article/10.1007/s10898-026-01616-7)) are quadratic-in-quadratic statements resting on the convexity of the joint numerical range of two quadratics, which a cubic objective breaks | **no mechanism**: nothing for a cubic objective with a quadratic side constraint beyond Lagrangian relaxation, whose gap is the thing at issue |
| 2. L57 with one quadratic constraint | stability of forbidden-configuration and flag-algebra extremal problems ([Pikhurko, Sliacan, Tyros 2017](https://arxiv.org/pdf/1706.02612), [stability for forbidden configurations 2024](https://arxiv.org/pdf/2411.07697)), and enumeration of zero-diagonal matrices with fixed line sums | **no mechanism**: the extremal graph literature is unweighted or certificate-based, and nothing treats a signed weighted triangle sum under a zero-row-sum condition with a second quadratic constraint |
| 3. symmetrisation | Baernstein--Taylor rearrangement for trilinear convolution forms on $S^n$ ([a sharpened form, 2018](https://arxiv.org/pdf/1810.06813)) rearranges functions on the sphere, and the symmetric-tensor spectral norm is attained at rank one ([Agrachev's Chebyshev-form note](https://people.sissa.it/~agrachev/agrachev_files/chebyshev.pdf), Banach's theorem) | **no mechanism**: no rearrangement acts on $O(n)$-orbits of tensors, and rank one is [L218](../findings/second-order.md)'s Banach form, already spent |
| 4. stability of L57 | nothing beyond the flag-algebra stability above | **absent from the literature as such**; a stability form of L57 would be proved from L57's own chain |
| 5. outside the boundary | Tkachev's extremum-to-idempotent theorem and the Hsiang-algebra Peirce bounds ([Tkachev, Braga 2024 slides](https://users.mai.liu.se/vlatk48/conferences/braga2024.pdf); [medial and isospectral algebras](https://arxiv.org/pdf/2210.08245); [Fox 2019](https://arxiv.org/pdf/1901.04012)), all on the shelf already ([R23](../routes.md), [tkachev-2019-*](../references/)) | **known and spent**: the extremum is an idempotent with Peirce spectrum in $(-\infty,\tfrac12]$, which is H2 and H3 |
| recent arXiv on the objects | second-kind sphere theorems ([Li 2025](https://arxiv.org/html/2407.13847)), a curvature-operator decomposition aimed at Hopf ([2507.15237](https://arxiv.org/abs/2507.15237)) | nothing on the maximiser of a cubic Weyl invariant |

**No source stored**: nothing read reaches the far region, and every relevant author is already on the shelf. **The literature does not carry a joint statistic for a cubic split, and does not need to: the finding the position asked about is structural, and batch 2 works it from the record's own calculus.**

## Batch 2, a derivation from the record's calculus: the split by ONE reflection has $P(\text{odd})=0$ exactly

**Screened first**: grep of [findings/](../findings/) for a reflection split, an odd part under a sign flip, or the fixed subalgebra of one reflection finds nothing (the "odd part" hits are Lie-algebraic symmetric pairs). *So this is not on the record.*

**Setting.** Fix a unit $u$ and let $\sigma_u\in O(n)$ be the reflection in $u^\perp$; it is an algebra automorphism of $\mathcal W_n$. Split $W=b+c$ into its $\sigma_u$-even and $\sigma_u$-odd parts. In a frame with $e_n=u$, $b$ collects $\mathcal D_n$, the pair blocks $V_{jk}$ with $j,k<n$ and the four-set blocks $V_Q$ with $n\notin Q$, and $c$ collects the $n-1$ pair blocks $V_{jn}$ and the $\binom{n-1}3$ four-set blocks $V_{Q\ni n}$. **$\mathcal B_u=\ker(\sigma_u-1)$ is a subalgebra, and $\mathcal C_u=\ker(\sigma_u+1)$ satisfies $\mathcal C_u\circ\mathcal C_u\subseteq\mathcal B_u$ and $\mathcal B_u\circ\mathcal C_u\subseteq\mathcal C_u$.** Hence, exactly,
$$P(W)=P(b)+3\langle L_bc,c\rangle,\qquad P(c)=0,\qquad\langle b\circ b,c\rangle=0 .$$
*This is the frame split of [L214](../findings/second-order.md) and the four-set split of [I101](../plan.md) with the third term gone: the odd part contributes to $P$ only through its coupling to the even part.*

**At a critical point** $Q(W)=\theta W$ splits by parity into
$$b\circ b+c\circ c=\theta b,\qquad L_bc=\tfrac\theta2\,c ,$$
so **the odd part is an exact $\tfrac\theta2$-eigenvector of $L_b$**, and pairing gives $P(b)=\theta(1-\tfrac32s^2)$, $\langle L_bc,c\rangle=\tfrac\theta2s^2$ with $s^2=\lVert c\rVert^2$. *At a global maximiser, H3 adds $L_W\le\tfrac\theta2$ on $W^\perp$.*

**The choice of $u$ is free, and $W$ is coordinate-diagonal iff some frame has $c=0$ at all of its $n$ vectors.** *So the root node reads: at a global maximiser, the function $s^2(u)=\lVert c_u\rVert^2$ on the unit sphere of $\mathbb R^n$ vanishes on an orthonormal frame.* A first step is $\min_us^2(u)=0$; then $W\in\mathcal B_u$, which is $O(n-1)$-equivariantly the curvature-type tensors on $u^\perp$ plus a symmetric form $W(u,\cdot,u,\cdot)$ on $u^\perp$, and the same question recurs one dimension down, **an induction the record has never set up.**

**What has to be true for the first step, and what the fences say.** Along the orbit direction $\mathrm{ad}_\xi W_{\mathrm{bal}}$ with $\xi=E_{kn}$, $c$ is exactly that direction and $L_bc=\tfrac\theta2c$ holds with $b=W_{\mathrm{bal}}$, which is [F37](../findings/fence-posts.md)'s degeneracy; the minimising $u$ removes it by the first-order condition $\partial_us^2=0$, which reads $\langle c,\mathrm{ad}_\xi b\rangle=0$ for $\xi\in u\wedge u^\perp$, the same shape as I100's frame condition but with $n-1$ parameters instead of $\binom n2$. **A screen (batch 3) says what $s^2$ looks like at the two competitors and whether the eigenvector condition is as stated.**

## Batch 3, the screen of batch 2 at $n=8$ (seconds, objects in hand)

At the two critical points the fast ascent reaches at $n=8$, Fox's $\sqrt{3/2}$ and $S^4\times S^4$ in a random frame, under the reflection in $e_0$: **$P(c)=0$ exactly, $P(b)+3\langle L_bc,c\rangle=\theta$ to $5\times10^{-6}$, $P(b)/\theta=1-\tfrac32s^2$ to four digits, and $2\,b\circ c=\theta c$ to $3\times10^{-7}$.** *The product is closed on $\mathcal W_n$ ([L209](../findings/curvature-invariants.md), and to $6\times10^{-16}$ here), so no projection enters. A first run reported a residual of $0.4$ because it compared $b\circ c$, not $2\,b\circ c$, with $\theta c$, a missing factor $2$ caught by [r938](REVIEW_r938.md)'s log and reproduced.* **$\min_us^2(u)$ is $10^{-15}$ at both points** by BFGS from twenty starts: at $S^4\times S^4$ that is a frame vector, at padded $W_{\mathbb{CP}^2}$ a padding direction, so the first inductive step holds at both competitors for different reasons, and $s^2(u)$ over random $u$ ranges $[0.04,0.50]$.

**What the screen changes.** The eigenvector condition and the exact split are confirmed, so the reflection split is a clean calculus. **It does not supply the step**: H3 on the plane $\{b,c\}$ reduces to $\theta\ge0$ with slack $\tfrac\theta2s^4$, and H4 there gives only $s^2\le\tfrac34$ ([r937](REVIEW_r937.md), [r938](REVIEW_r938.md)), because $P(c)=0$ leaves $P=\tfrac\theta2(3\alpha-\alpha^3)$ on the plane. *So the mechanism for "some reflection has $c=0$ at a maximiser" is as open as the far region itself, and the split's value is the induction it sets up and the $n-1$-parameter freedom in $u$.*

## Phase 3a, the screen

| candidate | mechanism | H consumed | on the record? | fence |
| --- | --- | --- | --- | --- |
| A. reflection induction | the root node as $n$ repetitions of one lemma, *a maximiser on $\mathrm{Fix}(H)$ is even under one more reflection*, on the fixed subalgebras of the sign group | H2, and H1 or H4 for the lemma, which has no mechanism yet | grep finds no reflection split, no odd part under a sign flip, no fixed subalgebra of one reflection | F37 (the orbit direction is a $\tfrac\theta2$-eigenvector, removed by minimising $u$), F67 (no decoupled bound of $P(b)$ against the coupling) |
| B. I101 by a Lagrangian on L57's chain | the coupling value as the joint statistic, which passed by screen with margin $0.0015$; prove $\tilde\varphi(\lambda)\le\Psi(\lambda)$ by L57's three steps with a multiplier | H1, H4 through L57 | four attempts on [file](2026-09-14-I100-derivation.md) | F67 at one level down; a $0.0015$ margin admits no lossy step |
| C. a stability form of L57 (node (b)) | quantify L57's three Cauchy--Schwarz steps by their defects | H1 | not on the record, absent from the literature as such | none, but it feeds only a route that also needs a lower bound on the diagonal mass, which nothing supplies |
| D. a joint statistic from the literature | S-lemma, cubic trust region, rearrangement | | batch 1: nothing for a cubic objective | closed by batch 1 |

## Phase 3b, the routes, graded on section 1's rubric

| route | closes | attackable | margin | analytic | value | distance to a proof of the goal |
| --- | --- | --- | --- | --- | --- | --- |
| **A. Reflection induction**: register the calculus ($P=P(b)+3\langle L_bc,c\rangle$, $P(c)=0$, $\pi(2b\circ c)=\theta c$, the $u$-minimisation), then attack the lemma with $u$ minimising $s^2$ and H4 along directions leaving the plane | 2 | 1 | 1 | 1 | **2** | the root node follows from the lemma applied $n$ times, with L57 at the bottom; the lemma is the far region in a form with one free vector and one clean pair of equations, and no mechanism yet |
| **B. I101 by a Lagrangian on L57's chain** | 1 | 2 | 1 | 1 | **2** | closes the single-four-set case of I100 only; the mixed case would still be open, and the margin is $0.0015$ |
| C. Stability of L57 | 1 | 2 | 1 | 1 | 2 | a lemma other routes could use, closing nothing by itself |
| D. Literature joint statistics | 0 | 0 | | | 0 | closed |

**What I would pick, and why.** *Route A, for one reason: it is the only candidate that changes the shape of the problem rather than the constants.* The record has attacked the far region as one statement about a maximiser in a $1638$-dimensional space; the reflection induction makes it $n$ copies of a statement with one free unit vector, two exact equations, and the maximiser's own value, and the competitors pass its first step for reasons a proof would have to reproduce (padding for $\mathbb{CP}^2$, a frame vector for the products). **Its grade is 2 because the lemma has no mechanism, and I say so rather than inflate it.** B is a real item with a thin margin, and C is a tool. *If A's lemma turns out to be F67 a fourth time, the honest conclusion is that the far region needs an idea from outside this record's calculus, and the next sweep should say so at its head.*

**Sources of this sweep**: those in batch 1, none stored. **Model note**: written on Fable at the user's confirmation ("Switched"), phases 2b to 3b.
