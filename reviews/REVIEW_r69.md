# Reviewer 69, Gate 2 on the symmetry defect, fence posts 18–20, and $\Theta_3$

Ran 2026-08-23 on the brief in `agent_logs/reviewer69.log`. All machinery written from definitions; every $\theta$ quoted has Ricci, Bianchi and trace residuals below $10^{-16}$.

| # | Claim | Verdict |
|---|---|---|
| 1 | Fence post F18 | CONFIRMED as scoped, OVERSTATED as phrased; $n\ge5$ is an unstated hypothesis |
| 2 | $\Delta$ and its consequence | (a),(b) CONFIRMED; (c) CONFIRMED only with $\ker W=0$, **and the script drops that hypothesis** |
| 3 | Convention and the $\mathbb{CP}^2$ correction | First half CONFIRMED; **the conclusion REFUTED**; the record survives unweakened |
| 4 | $\Theta_3=32\theta$ | Proportionality CONFIRMED; **the constant REFUTED, it is $-2$** |
| 5 | Fence post F19 | **REFUTED on both the sign and the hypothesis** |
| 6 | Fence post F20 | Primary CONFIRMED and strengthened; **secondary REFUTED with a construction** |

## 1. Fence post F18

Prop 1.7 unsummed at $8.9\times10^{-16}$ ($n=5..8$); $\rho_a=2(n-2)$ spread $\le7\times10^{-14}$ ($n=5..10$); $\sum\lambda_a\lambda_bR_{ab}=-2.000000000000$; total $4(n-1)$ exact, drifting to $16.9$–$17.0$ at $n=6$ on non-Weyl controls.

**Two boundaries the record does not state.**

- **$n=4$ is a real exception.** "Generator-independent weight must be scalar" relies on irreducibility of the adjoint of $\mathfrak{so}(n)$, which fails at $n=4$. Tracing $g$ separately over $\Lambda^2_\pm$ gives $(2.75,9.25)$, $(8.73,3.27)$, $(7.18,4.82)$ on three random $\mathrm{Weyl}_4$ points (non-constant invariant contractions) while the total stays pinned at $12$. The correct hypothesis is $n\ge5$.
- **Only the *unweighted* sum is inert.** Weighting by the spectrum gives exactly $\sum_\gamma\lambda_\gamma\lVert[\mathrm{ad}\,v_\gamma,W]\rVert^2=-4\theta(W)$, verified to 12 digits at $n=5,6,7,8,10$ and proved in two lines from $A(W)=2W$ and the definition of $\#$.

## 2. The symmetry defect

$\Delta$ basis-independent across four independently drawn orthonormal bases of $\mathfrak p$: $12.000000000$ (C₅), $11.208194346$ (random $n=6$). $\Delta=0\iff\max\lVert[\mathrm{ad}\,x,W]\rVert=0$: $0.0$ at $S^6\times S^6$, $5.3\times10^{-16}$ at $\mathbb{CP}^4$, $0.775$ at C₅.

**The proof of (c) is correct as briefed and wrong as implemented.** $\ker W=0$ is used exactly twice, for $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m$ and for $[\mathfrak m,\mathfrak m]\perp\mathfrak m\Rightarrow[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$. Both uses are load-bearing. The script's header omits it and its `graded?` column prints **YES** for two padded points that are not graded:

| point | $\dim\ker$ | $\langle[\mathfrak m,\mathfrak m],\mathfrak m\rangle^2$ | $\langle[\mathfrak p,\mathfrak p],\mathfrak m\rangle^2$ | $\langle[\mathfrak h,\mathfrak h],\mathfrak m\rangle^2$ | graded in $\mathfrak{so}(n)$? |
|---|---|---|---|---|---|
| $\mathbb{CP}^2$ ($n=4$) | 3 | 0 | 0 | **0** | yes |
| $\mathbb{CP}^2$ padded $n=8$ | 25 | 0 | 0 | **16.0** | **no** |
| $\mathbb{CP}^2$ padded $n=10$ | 42 | 0 | 0 | **24.0** | **no** |
| $S^3\times S^3$ padded $n=8$ | 13 | 0 | 0 | **36.0** | **no** |
| C₅ blow-up $n=10$ | 0 | 0 | 80.0 | 80.0 | no |

**Deflation:** "random Weyl sit near half the Casimir" is a dimension count, $\Delta/\text{total}$ matches $\dim\mathfrak p/N$ to within 1% at every random point.

## 3. The convention

$\{\lambda\ge0\}$ embedding-dependence CONFIRMED exactly: padded $\mathbb{CP}^2$ gives $8,16,24,32$ at $n=6,8,10,12$ with $\theta$ pinned at $1.224744871$. The arithmetic of the correction CONFIRMED: $\langle[\mathfrak h,\mathfrak h],\mathfrak m\rangle^2=16,24$, i.e. norms $4.0$ and $4.899$, exactly the record's numbers, and $0$ at unpadded $\mathbb{CP}^2$.

**The conclusion REFUTED.** At $n=8$, $\mathfrak p$ is 1-dimensional and $\mathfrak m$ 2-dimensional; $\mathfrak p\oplus\mathfrak m\cong\mathfrak{su}(2)$ is a graded 3-dimensional *subalgebra*, but $\mathfrak{so}(8)$ is 28-dimensional and the 25-dimensional kernel is unassigned, and those kernel directions are **not** symmetries ($\max\lVert[\mathrm{ad}\,x,W]\rVert=1.0$ over the kernel). $S_{\mathfrak{mpp}}=0$ certifies a grading of the span of the nonzero eigenvectors, not of $\mathfrak{so}(n)$.

**Recommendation: swap the witness, do not weaken the claim.** The C₅ blow-up is padding-free, trivial kernel, $S=0$ exactly, $\theta=0.670820$, $\langle[\mathfrak p,\mathfrak p],\mathfrak m\rangle^2=80$.

## 4. $\Theta_3$

Implemented Definition 6.1 with its explicit $\tfrac14$. Three validations passed: the paper's own $q(R)\star X=\tfrac12\mathrm{Ric}\,X$; $q(R)\star$ on $\Lambda^p$ of the round sphere giving $p(n-p)/2\cdot\mathrm{Id}$ for $p=1,2,3$ at $n=5,6,7$; and Lemma 6.3 on locally symmetric spaces, $\max|q(R)\star R|=0.0$ for $S^6$, $S^3\times S^3$, $S^2\times S^6$, $\mathbb{CP}^3$, $\mathbb{CP}^4$, the full tensor, not just the pairing.

Result: $g(q(R)\star R,R)=-2\,\theta(W)$. The factor 32 localised:

| convention | ratio |
|---|---|
| paper's $\tfrac14$, $\{e_i\wedge e_j\}_{i<j}$ orthonormal | $-2$ |
| naive full 4-index contraction | $-8$ |
| drop the $\tfrac14$ (the script) | $-32$ |
| also flip $R_{E_\mu,E_\nu}$ (the script) | $+32$ |

**The magnitude is convention-dependent; the sign is not**, it survives flipping the sign convention for $R$ ($\Theta_3$ is cubic) and any positive metric rescaling. Weingart is internally inconsistent: Lemma 6.2 writes $\Theta_3:=+g(q(R)\star R,R)$, line 2154 writes $-$.

## 5. Fence post F19

- **Sign backwards.** With $g(q(R)\star R,R)=-2\theta$, Lemma 6.3 gives $\lVert\nabla R\rVert^2=+2\int\theta\ge0$.
- **Hypothesis too weak.** $g(q(R)\star R,R)\propto\theta$ holds *only* on Ricci-flat tensors; off it the ratio drifts (1.02, 1.10, 2.22, 4.08, 9.68 as $|\mathrm{Ric}|$ grows to 7.6). **Counterexample: the round sphere** has parallel Ricci and $g(q(R)\star R,R)=0$ while $\theta=40,75,126$ at $n=5,6,7$. So "parallel Ricci" must be "Ricci-flat".
- **Conclusion broader than premise.** One Bochner identity does not close all integrated arguments.
- **What survives:** on a compact Ricci-flat manifold $\int\theta=\tfrac12\lVert\nabla R\rVert^2\ge0$, equality iff flat. A *lower* bound is useless against a conjectured upper bound, and Conjecture A is algebraic anyway. The fence stands for the opposite reason to the one recorded.

## 6. Fence post F20

Moments computed **exactly** (Wishart determinant moment plus Isserlis contraction), validated against the round-sphere control at $10^{-18}$.

**Primary CONFIRMED and strengthened.** $S^3\times S^3$ and $\mathbb{CP}^3$ agree in $\theta$ to $2.2\times10^{-16}$, and $\Psi_3=5.577209277192865\times10^{-5}$ against $7.529232524210420\times10^{-4}$, ratio **exactly 13.5**. No fitting, no sampling. And $a/b=\mathbf{-14.000000}$ exactly for $n\ge6$, residual $\le5\times10^{-19}$.

Closed form the record lacks: $\Psi_2=12/((n-1)n(n+1)(n+2))\cdot\lVert W\rVert^2$. Also $\Psi_1=\mathrm{scal}/\mathbb E\lVert x\wedge y\rVert^2$, so $\mathrm{tr}\,W=0$ suffices, full Ricci-flatness is not needed.

**Secondary REFUTED, with a construction.** Define the three-plane correlation $\Phi:=\mathbb E_{x,y,z}[\sec(x,y)\sec(y,z)\sec(z,x)]$, a cubic invariant with $a/b=-0.5$, a different point of the same 2-plane. Since the cubic invariants on $\mathrm{Weyl}_n$ ($n\ge6$) are 2-dimensional, $\{\Psi_3,\Phi\}$ is a basis and

$$\theta=c_n\Psi_3+\tfrac5{72}\Phi,\qquad c_n=1050,\ 2310,\ 4620\ \text{at}\ n=6,7,8,$$

residual $4\times10^{-16}$ and exact out-of-sample ($1.145643924$ at $S^4\times S^4$, $0.986013297$ at $\mathbb{CP}^4$). The $\Phi$ coefficient $5/72$ is $n$-independent. **So $\theta$ is an explicit closed form in sectional-curvature moments.** Also false at $n=4,5$, where the cubic invariants are 1-dimensional ($\langle W,W^\#\rangle=2\,\mathrm{tr}\,W^3$) and $\Psi_3=1.0582\times10^{-3}\cdot\theta$ exactly at $n=5$.

**What survives:** $\theta$ is not a function of the *uniform single-plane* third moment.

## Found beyond the brief, the bound the plan was asking for

$\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ is not in the record. Combined with $g_\gamma\ge0$ and $\sum_\gamma g_\gamma=4(n-1)$ it gives

$$\theta\ \le\ |\lambda_{\min}|\cdot\frac{4(n-1)-\Delta-G_0}{4},\qquad G_0:=\sum_{\gamma\in\ker}g_\gamma,$$

**exactly the shape [plan.md](../plan.md) item (vi) asks for, an upper bound on $\theta$ decreasing in $\Delta$.** Verified at 13 points, with **equality at every symmetric-space point** ($S^3\times S^3$, $S^6\times S^6$, $S^5\times S^7$, $\mathbb{CP}^3$, $\mathbb{CP}^4$, padded $\mathbb{CP}^2$) and slack only where $\Delta>0$ (C₅: $0.671$ against $0.894$) or at random points ($\approx0$ against $\approx1.2$). Equality holds exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace, i.e. every eigenvector above the bottom is an infinitesimal symmetry. The weakness is that $|\lambda_{\min}|$ is uncontrolled; it converts the open question into a two-variable one in $(\Delta,\lambda_{\min})$.
