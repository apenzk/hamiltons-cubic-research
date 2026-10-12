# Reviewer 70, Gate 2 on the symmetry defect, fence posts 18–20, and $\Theta_3$

Ran 2026-08-23 on the same brief as [Reviewer 69](REVIEW_r69.md), independently. Log at `agent_logs/reviewer70.log`. Weyl bases (dims 10/35/84/168/300 at $n=4..8$) agree with [review_r30_core.py](../scripts/review_r30_core.py) to $10^{-9}$; every catalogue point rebuilt from geometry and Weyl-projected independently.

| # | Claim | Verdict |
|---|---|---|
| 1 | Fence post F18 | CONFIRMED as recorded (the brief's paraphrase was the overstatement) |
| 2 | $\Delta$ and its consequence | CONFIRMED; one hypothesis under-advertised |
| 3 | Convention and the $\mathbb{CP}^2$ correction | Both halves true; **the record's claim survives, its witness does not** |
| 4 | $\Theta_3=32\theta$ | Proportionality CONFIRMED; **the constant REFUTED, it is $-2$** |
| 5 | Fence post F19 | **REFUTED, sign inverted**; conclusion survives for a different reason |
| 6 | Fence post F20 | Primary CONFIRMED exactly; secondary OVERSTATED and **false at $n=4,5$** |

## Where it agrees with Reviewer 69, independently

Both reviewers, working from separate implementations, obtained the **same numbers on every disputed point**: $\Theta_3=-2\theta$; the third-moment ratio exactly $13.5$; $a/b$ exactly $-14$; $\Delta=12$ at the C₅ blow-up; $\Delta=8,16,24,32$ for padded $\mathbb{CP}^2$ under $\{\lambda\ge0\}$; the padded leak equal to $16$ and $24$. Both also independently derived $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ as the witness that $\gamma$-dependent weights are not inert.

## 1. Fence post F18

Prop 1.7 verified for eigen-generators *and* a random non-eigen generator, max error $4\times10^{-15}$; it is the eigenbasis expansion of $[\mathrm{ad}\,x,W]$ and needs no Weyl hypothesis. $\rho_a=2(n-2)$ holds off $\mathrm{Weyl}_n$ too, it needs only $\lVert v_a\rVert=1$. $A(W)=2W$ holds on $\mathrm{Weyl}_n$ ($10^{-15}$) and fails off it ($0.56$). Casimir on the other modules: $0$ scalar, $2n$ on $\mathrm{Sym}^2_0$, $4(n-1)$ on $\mathrm{Weyl}_n$, $n=5..8$.

**Extra:** $A(W)=2W$ is a **per-row** identity, $\sum_b\lambda_bR_{ab}=-2\lambda_a$ for every $a$ (residual $3\times10^{-15}$ on $\mathrm{Weyl}_n$, $1.0$ off it). The record uses only its $\lambda_a$-weighted trace; the per-row form is strictly stronger and is what makes the $\lambda$-weighted contraction collapse to $-4\theta$. Also $\sum\lambda_a\lambda_b\lambda_\gamma T_{ab\gamma}=2\langle W,W^\#\rangle$ holds **off** $\mathrm{Weyl}_n$, free of Bianchi and Ricci-flatness.

## 2. The symmetry defect

$g$ verified genuinely quadratic (parallelogram identity to $0.0$, $x^\mathsf{T}Gx-g(x)=7\times10^{-15}$); $\Delta$ invariant under random orthogonal remixing inside $\mathfrak p$ (spread $\le7\times10^{-15}$, including the degenerate spectra).

**$\ker W=0$ is load-bearing and the header under-advertises it.** $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$ does **not** follow from $S_{\mathfrak{mmm}}=0$ alone. Witness: padded $W_{\mathbb{CP}^2}$ at $n=8$ has $\Delta=0$, $S=0$, all three relations on $\mathfrak p\oplus\mathfrak m$, yet $[\mathfrak z,\mathfrak z]\to\mathfrak m=16\ne0$. What survives without the hypothesis is "$\mathfrak p\oplus\mathfrak m$ is a graded *subalgebra*".

**A limitation the record does not flag:** $W_{\mathbb{CP}^2}$ at $n=4$ is self-dual with a 3-dimensional kernel ($\dim\mathfrak p=1$, $\dim\mathfrak m=2$). **The consequence therefore excludes the very point that sets the $\sqrt{3/2}$ threshold.**

**A header claim contradicted by the script's own table.** "$\dim\mathfrak h$ is exactly the isotropy dimension at each of them" is true at the sphere products (30/31/34) and $\mathbb{CP}^{3,4}$ (9/16), and **false at $\mathbb{CP}^2$**, where $\dim\mathfrak p=1$ while $\dim\mathfrak k(W)=\dim\mathfrak u(2)=4$, the printed row says so.

Criticality of the C₅ blow-up reconfirmed: $\lVert Q(W)-\theta W\rVert=1.3\times10^{-16}$, smallest $|\lambda|=7.45\times10^{-2}$.

## 3. The convention

Confirmed exactly, and the padded leak resolved into blocks:

| $n$ | $[\mathfrak p,\mathfrak p]\to\mathfrak m$ | $[\mathfrak p,\mathfrak z]\to\mathfrak m$ | $[\mathfrak z,\mathfrak z]\to\mathfrak m$ | $[\mathfrak h,\mathfrak h]\to\mathfrak m$ |
|---|---|---|---|---|
| 8 | 0 | 0 | **16** | 16 |
| 10 | 0 | 0 | **24** | 24 |

The leak is **100% the kernel–kernel term**. But the record's claim is about $\mathfrak h=\mathfrak m^\perp$, which is the decomposition an involution requires, and on that object it is correct. **What does not survive is the framing that this contradicts the record, it corrects the witness, not the claim**, and the kernel-free replacement is the C₅ blow-up.

## 4. $\Theta_3$

Implemented Definition 6.1 with the full $\mu,\nu$ double sum and the explicit $\tfrac14$, with $g$ normalised so $\{dE_\mu\wedge dE_\nu\}_{\mu<\nu}$ is orthonormal ($=\tfrac14\times$ the full 4-index contraction, which is what makes $\lVert R\rVert^2=\lVert W\rVert_F^2$ in the pair basis).

Both of the paper's pinning identities satisfied, and they fix every sign: $q(R)\star X=\tfrac12\mathrm{Ric}\,X$ at $2.8\times10^{-17}$ (opposite sign misses by $0.44$); $q(R)\star=\tfrac12\mathrm{Der}_{\mathrm{Ric}}-R^{\mathrm{alt}}$ on $\Lambda^2$ at $1.8\times10^{-15}$ (opposite sign misses by $22$).

Result $\Theta_3(W)=-2\theta(W)$, ratio constant to $10^{-15}$. Same localisation table as Reviewer 69.

**Corroboration via Hamilton.** Implementing $Q(R)$ exactly as the paper's eq (46) writes it gives $q(R)\star R=-Q_{\mathrm{Ham}}(R)$ on Ricci-flat tensors to $10^{-16}$, with $\tfrac14\langle Q_{\mathrm{Ham}},R\rangle=2\theta$, i.e. $Q_{\mathrm{Ham}}=2(W^2+W^\#)$, the expected Ricci-flow reaction term. Eq (46) as printed carries a sign opposite to Definition 6.1; Hamilton's flow direction confirms Definition 6.1 is the reliable one.

## 5. Fence post F19, the Schwarzschild witness

Verified Lemma 6.3 **pointwise on a real Ricci-flat 4-manifold**: Euclidean Schwarzschild $\mathrm{diag}(f,1/f,r^2,r^2\sin^2\theta)$, $f=1-2M/r$, at $M=1$, $r=3$, $\theta=1$, with Christoffels, Riemann, $\nabla R$ and $\nabla^2R$ computed symbolically and pushed to an orthonormal frame. $\mathrm{Ric}=0$ exactly, and

$$\max|\nabla^*\nabla R+q(R)\star R|=3.5\times10^{-18}\ \text{against a scale of}\ 1.6\times10^{-2}$$

(the wrong-sign combination misses by $3.3\times10^{-2}$). There $g(q(R)\star R,R)=-3.658\times10^{-3}<0$ and $\lVert\nabla R\rVert^2=9.14\times10^{-3}\ne0$.

- The sign is inverted: $\int\theta\ge0$.
- **[FINDINGS.md line 990](../findings/INDEX.md) as printed asserts a squared $L^2$ norm is $\le0$.**
- **The parenthetical is refuted by a witness.** The Euclidean Schwarzschild Weyl tensor has spectrum $(2,2,-1,-1,-1,-1)/\sqrt{12}$ and $\theta=0.8660254038=\sqrt3/2=\theta_0(4)$ **exactly, at every radius** (the type-D structure is $r$-independent). A Ricci-flat metric carries the maximiser at $n=4$. It is complete-but-noncompact, so it does not break the compact statement, but it kills the "purely algebraic, unrealisable" reading.
- **The correct reason the route is closed:** Lemma 6.3 supplies an *identity* $\int\theta=\tfrac12\lVert\nabla R\rVert^2$, a lower bound, and offers no upper bound on $\lVert\nabla R\rVert^2$. The load-bearing part of the record's argument, Conjecture A is pointwise-algebraic about arbitrary $W$, while Lemma 6.3 speaks only of $W$ realised as a compact manifold's full curvature, is untouched and is the part worth keeping.

## 6. Fence post F20

Moments computed exactly by Wick sums over the $15\times15$ perfect matchings, validated against Monte Carlo ($|z|\le1.4$).

- $\Psi_1=\mathrm{scal}/(n(n-1))$ identically, **scalar-flatness suffices**, matched to 9 decimals on non-Ricci-flat operators.
- $\Psi_2=12/(n(n-1)(n+1)(n+2))$, $1/70,1/140,1/252,1/420$ at $n=5,6,7,8$.
- **Primary confirmed exactly**: ratio $13.5$. The script's Monte Carlo gives $5.4408\times10^{-5}$ against the true $5.577\times10^{-5}$, about 2.4% low, one quoted s.e.
- $a/b=-14.000000000$ exactly at $n=6,7,8$, residual $<3\times10^{-19}$.
- **Secondary overstated**: "$\Psi_3$ is the only degree-3 quantity" is valid only for *homogeneous polynomial* combinations, and the record's own "$c\Psi_3+\text{const}$" already leaves that class. Odd higher moments $\Psi_5,\Psi_7,\dots$ have the right parity ($\theta$ and $\Psi_{\mathrm{odd}}$ are odd under $W\mapsto-W$) and no degree argument excludes them. Testing one order further by measurement: fitting $\theta\sim a\Psi_3+b\Psi_5$ at $n=6$ over 8 points leaves residual $0.200$ against a $\theta$ spread of $1.097$, so the conclusion happens to hold there, by measurement rather than by the recorded reasoning.
- **False at $n=4,5$**: the cubic invariant space is 1-dimensional, $\langle W,W^\#\rangle=2\,\mathrm{tr}\,W^3$, so $\theta=3\,\mathrm{tr}\,W^3$ and $\Psi_3=\theta/315$ ($n=4$), $\theta/945$ ($n=5$), $\theta$ **is** exactly a moment there. This is also the real reason the script's $n=5$ fit is rank-deficient, which the script attributes to sampling rather than to the geometry.
- The brief's other worries close: $\Psi_1\Psi_2=0$; and non-uniform *invariant* weights cannot help because $O(n)$ acts **transitively** on $G_2(\mathbb R^n)$, so any $W$-independent invariant weight is constant. A $W$-**dependent** weight is a different object outside Weingart's closed forms and remains genuinely open.

## Other items

- `b_symmetry_defect.py`'s `graded?` column does not test the kernel, so it prints YES where $\mathfrak{so}(n)$ is not graded. Any use of it as evidence needs `#0 = 0` alongside.
- Weingart is internally sign-inconsistent in two places (Lemma 6.2 vs line 2154; Definition 6.1 vs eq (46)). Definition 6.1 is self-consistent with both representation formulas and with Hamilton's flow direction. **The notes file must record which is used, because fence post F19's conclusion flips on it.**
- **Euclidean Schwarzschild is a cheap exact geometric fixture** for anything involving $\nabla R$: Ricci-flat, $\nabla R\ne0$, $\theta=\theta_0(4)$ at every radius, and it validates a $q(R)\star$ implementation to $10^{-18}$.
